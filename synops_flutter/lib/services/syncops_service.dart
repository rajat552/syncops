import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:synops_client/synops_client.dart';
import '../client.dart';
import '../core/constants.dart';

class SyncOpsService extends ChangeNotifier {
  static final SyncOpsService instance = SyncOpsService._();
  SyncOpsService._();

  SyncOpsRole currentRole = SyncOpsConstants.coordinator;

  List<Task> tasks = [];
  Task? selectedTask;
  List<TaskEvent> activeTimeline = [];
  DashboardSummary? dashboardSummary;

  final Map<int, LocationPing> lastPingsByTask = {};
  final List<LocationPing> recentPings = [];
  final List<TaskEvent> liveAuditLog = [];

  StreamSubscription<Task>? _taskSubscription;
  StreamSubscription<TaskEvent>? _eventSubscription;
  StreamSubscription<LocationPing>? _locationSubscription;
  Timer? _pollingTimer;
  Timer? _telemetryTimer;

  bool isConnected = false;
  bool isLoading = false;
  String? lastError;

  void setRole(SyncOpsRole role) {
    currentRole = role;
    notifyListeners();
  }

  Future<void> initialize() async {
    isLoading = true;
    notifyListeners();

    try {
      await refreshTasks();
      await refreshDashboard();
      _setupRealtimeStreams();
      isConnected = true;
      lastError = null;
    } catch (e) {
      lastError = e.toString();
      isConnected = false;
    } finally {
      isLoading = false;
      notifyListeners();
    }

    // Secondary resilient heartbeat poller (every 4 seconds) to ensure synchronization
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 4), (_) async {
      await refreshTasks(silent: true);
      await refreshDashboard(silent: true);
      if (selectedTask != null) {
        await loadTimeline(selectedTask!.id!, silent: true);
      }
    });
  }

  void _setupRealtimeStreams() {
    _taskSubscription?.cancel();
    _taskSubscription = client.task.subscribeToTaskUpdates().listen(
      (updatedTask) {
        final index = tasks.indexWhere((t) => t.id == updatedTask.id);
        if (index >= 0) {
          tasks[index] = updatedTask;
        } else {
          tasks.insert(0, updatedTask);
        }

        if (selectedTask?.id == updatedTask.id) {
          selectedTask = updatedTask;
        }
        notifyListeners();
      },
      onError: (err) {
        debugPrint('Task stream error: $err');
      },
    );

    _eventSubscription?.cancel();
    _eventSubscription = client.task.subscribeToAllEvents().listen(
      (event) {
        liveAuditLog.insert(0, event);
        if (liveAuditLog.length > 50) {
          liveAuditLog.removeLast();
        }

        if (selectedTask?.id == event.taskId) {
          activeTimeline.add(event);
        }
        notifyListeners();
      },
      onError: (err) {
        debugPrint('Event stream error: $err');
      },
    );

    _locationSubscription?.cancel();
    _locationSubscription = client.location.subscribeToAllLocations().listen(
      (ping) {
        lastPingsByTask[ping.taskId] = ping;
        recentPings.insert(0, ping);
        if (recentPings.length > 30) {
          recentPings.removeLast();
        }
        notifyListeners();
      },
      onError: (err) {
        debugPrint('Location stream error: $err');
      },
    );
  }

  Future<void> refreshTasks({bool silent = false}) async {
    try {
      final fetched = await client.task.getAllTasks();
      tasks = fetched;
      if (selectedTask != null) {
        final updatedSelected = tasks
            .where((t) => t.id == selectedTask!.id)
            .firstOrNull;
        if (updatedSelected != null) {
          selectedTask = updatedSelected;
        }
      }
      isConnected = true;
      if (!silent) notifyListeners();
    } catch (e) {
      if (!silent) {
        lastError = e.toString();
        notifyListeners();
      }
    }
  }

  Future<void> refreshDashboard({bool silent = false}) async {
    try {
      final summary = await client.task.getDashboardSummary();
      dashboardSummary = summary;
      if (!silent) notifyListeners();
    } catch (_) {}
  }

  Future<void> selectTask(Task? task) async {
    selectedTask = task;
    activeTimeline.clear();
    notifyListeners();

    if (task?.id != null) {
      await loadTimeline(task!.id!);
    }
  }

  Future<void> loadTimeline(int taskId, {bool silent = false}) async {
    try {
      final events = await client.task.getTaskTimeline(taskId);
      activeTimeline = events;
      if (!silent) notifyListeners();
    } catch (e) {
      if (!silent) {
        lastError = e.toString();
        notifyListeners();
      }
    }
  }

  Future<Task> createIncident({
    required String title,
    required String description,
    required double latitude,
    required double longitude,
    required String severity,
    String? skill,
    int timeoutSeconds = 45,
  }) async {
    final task = await client.task.createTask(
      title: title,
      description: description,
      latitude: latitude,
      longitude: longitude,
      severity: severity,
      createdById: currentRole.id,
      requiredSkill: skill,
      timeoutSeconds: timeoutSeconds,
    );
    await refreshTasks();
    await refreshDashboard();
    selectedTask = task;
    await loadTimeline(task.id!);
    return task;
  }

  Future<Task> acceptTask(int taskId, {int timeoutSeconds = 40}) async {
    final task = await client.task.acceptTask(
      taskId: taskId,
      responderId: currentRole.id,
      responderName: currentRole.name,
      timeoutSeconds: timeoutSeconds,
    );
    await refreshTasks();
    await refreshDashboard();
    if (selectedTask?.id == taskId) {
      selectedTask = task;
      await loadTimeline(taskId);
    }
    return task;
  }

  Future<Task> advanceStatus(
    int taskId,
    String nextStatus, {
    int timeoutSeconds = 45,
  }) async {
    final task = await client.task.updateTaskStatus(
      taskId: taskId,
      responderId: currentRole.id,
      newStatus: nextStatus,
      timeoutSeconds: timeoutSeconds,
    );
    await refreshTasks();
    await refreshDashboard();
    if (selectedTask?.id == taskId) {
      selectedTask = task;
      await loadTimeline(taskId);
    }
    return task;
  }

  Future<Task> releaseTask(int taskId, String reason) async {
    final task = await client.task.releaseTask(
      taskId: taskId,
      responderId: currentRole.id,
      reason: reason,
    );
    stopTelemetrySimulation();
    await refreshTasks();
    await refreshDashboard();
    if (selectedTask?.id == taskId) {
      selectedTask = task;
      await loadTimeline(taskId);
    }
    return task;
  }

  Future<Task> triggerSimulatedTimeout(int taskId) async {
    final task = await client.task.triggerSimulatedTimeout(taskId: taskId);
    stopTelemetrySimulation();
    await refreshTasks();
    await refreshDashboard();
    if (selectedTask?.id == taskId) {
      selectedTask = task;
      await loadTimeline(taskId);
    }
    return task;
  }

  Future<void> sendPing({
    required int taskId,
    required double latitude,
    required double longitude,
    double? speed,
    double? batteryLevel,
  }) async {
    final ping = LocationPing(
      responderId: currentRole.id,
      responderName: currentRole.name,
      taskId: taskId,
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.now().toUtc(),
      speed: speed ?? 34.5,
      batteryLevel: batteryLevel ?? 88.0,
    );
    await client.location.sendLocationPing(ping);
  }

  void startTelemetrySimulation(Task task) {
    stopTelemetrySimulation();
    double currentLat = task.latitude - 0.015;
    double currentLng = task.longitude - 0.012;

    _telemetryTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      // Step closer to target
      currentLat += (task.latitude - currentLat) * 0.2;
      currentLng += (task.longitude - currentLng) * 0.2;

      try {
        await sendPing(
          taskId: task.id!,
          latitude: currentLat,
          longitude: currentLng,
        );
      } catch (_) {}
    });
  }

  void stopTelemetrySimulation() {
    _telemetryTimer?.cancel();
    _telemetryTimer = null;
  }

  bool get isSimulatingTelemetry => _telemetryTimer != null;

  @override
  void dispose() {
    _pollingTimer?.cancel();
    _telemetryTimer?.cancel();
    _taskSubscription?.cancel();
    _eventSubscription?.cancel();
    _locationSubscription?.cancel();
    super.dispose();
  }
}
