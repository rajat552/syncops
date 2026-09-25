import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synops_client/synops_client.dart';
import '../core/theme.dart';
import '../services/syncops_service.dart';
import '../widgets/countdown_timer_view.dart';
import '../widgets/status_badge.dart';
import '../widgets/tactical_map_view.dart';

class ResponderScreen extends StatefulWidget {
  const ResponderScreen({super.key});

  @override
  State<ResponderScreen> createState() => _ResponderScreenState();
}

class _ResponderScreenState extends State<ResponderScreen> {
  final _service = SyncOpsService.instance;
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _service,
      builder: (context, _) {
        final currentResponderId = _service.currentRole.id;
        final myActiveTask = _service.tasks.where((t) {
          return t.assignedToId == currentResponderId &&
              t.status != 'COMPLETED' &&
              t.status != 'CANCELLED';
        }).firstOrNull;

        final availableTasks = _service.tasks
            .where((t) => t.status == 'PENDING')
            .toList();

        return Scaffold(
          body: myActiveTask != null
              ? _buildActiveMissionTerminal(myActiveTask)
              : _buildAvailableMissionsFeed(availableTasks),
        );
      },
    );
  }

  Widget _buildActiveMissionTerminal(Task task) {
    final lastPing = _service.lastPingsByTask[task.id];
    final isSimulating = _service.isSimulatingTelemetry;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: SyncOpsTheme.surfaceElevated,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: SyncOpsTheme.primaryCyan.withOpacity(0.4),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      color: SyncOpsTheme.primaryCyan,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'ACTIVE FIELD ASSIGNMENT',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: SyncOpsTheme.primaryCyan,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
                StatusBadge(status: task.status, isLarge: true),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Mission Details Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SeverityBadge(severity: task.severity),
                      if (task.expiresAt != null)
                        CountdownTimerView(expiresAt: task.expiresAt),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    task.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      color: SyncOpsTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Radar view
          TacticalMapView(task: task, lastPing: lastPing),
          const SizedBox(height: 14),

          // Real-time GPS Telemetry Controls Card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: SyncOpsTheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSimulating
                    ? SyncOpsTheme.successGreen.withOpacity(0.6)
                    : SyncOpsTheme.border,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.radar_rounded,
                          size: 16,
                          color: isSimulating
                              ? SyncOpsTheme.successGreen
                              : SyncOpsTheme.textMuted,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'LIVE TELEMETRY STREAM',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: isSimulating
                                ? SyncOpsTheme.successGreen
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: isSimulating,
                      activeThumbColor: SyncOpsTheme.successGreen,
                      onChanged: (val) {
                        if (val) {
                          _service.startTelemetrySimulation(task);
                        } else {
                          _service.stopTelemetrySimulation();
                        }
                      },
                    ),
                  ],
                ),
                Text(
                  isSimulating
                      ? '● Broadcasting live GPS pings every 3s. Heartbeat extends Serverpod timeout.'
                      : 'Telemetry stopped. If no signal is received within the response window, Serverpod will automatically recover the task.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: isSimulating
                        ? SyncOpsTheme.successGreen
                        : SyncOpsTheme.warningAmber,
                  ),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () async {
                    await _service.sendPing(
                      taskId: task.id!,
                      latitude: task.latitude - 0.005,
                      longitude: task.longitude - 0.005,
                    );
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Instant GPS ping dispatched to Serverpod stream!',
                          ),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.send_rounded, size: 14),
                  label: Text(
                    'TRANSMIT MANUAL GPS PING',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: SyncOpsTheme.primaryCyan,
                    side: const BorderSide(color: SyncOpsTheme.primaryCyan),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Primary One-Touch State Action Buttons
          _buildActionControls(task),

          const SizedBox(height: 12),

          // Voluntary Release Button
          Center(
            child: TextButton.icon(
              onPressed: _isProcessing ? null : () => _showReleaseDialog(task),
              icon: const Icon(
                Icons.exit_to_app_rounded,
                color: SyncOpsTheme.alertOrange,
                size: 16,
              ),
              label: Text(
                'RELEASE TASK (RETURN TO DISPATCH QUEUE)',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: SyncOpsTheme.alertOrange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionControls(Task task) {
    if (task.status == 'ACCEPTED') {
      return _buildBigActionButton(
        label: 'START RESPONSE (EN ROUTE)',
        icon: Icons.directions_run_rounded,
        color: SyncOpsTheme.accentBlue,
        onPressed: () => _advanceStatus(task.id!, 'EN_ROUTE'),
      );
    } else if (task.status == 'EN_ROUTE') {
      return _buildBigActionButton(
        label: 'REPORT ARRIVED ON SCENE',
        icon: Icons.location_on_rounded,
        color: SyncOpsTheme.purpleNeon,
        onPressed: () => _advanceStatus(task.id!, 'ARRIVED'),
      );
    } else if (task.status == 'ARRIVED') {
      return _buildBigActionButton(
        label: 'MARK WORK IN PROGRESS',
        icon: Icons.play_arrow_rounded,
        color: SyncOpsTheme.primaryCyan,
        onPressed: () => _advanceStatus(task.id!, 'IN_PROGRESS'),
      );
    } else if (task.status == 'IN_PROGRESS') {
      return _buildBigActionButton(
        label: 'COMPLETE MISSION & CLOSE',
        icon: Icons.check_circle_rounded,
        color: SyncOpsTheme.successGreen,
        onPressed: () => _advanceStatus(task.id!, 'COMPLETED'),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildBigActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: _isProcessing ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: _isProcessing
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Icon(icon, size: 20),
        label: Text(
          label,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildAvailableMissionsFeed(List<Task> availableTasks) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DISPATCH QUEUE',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: SyncOpsTheme.textMuted,
                      letterSpacing: 0.8,
                    ),
                  ),
                  Text(
                    'AVAILABLE EMERGENCY TASKS',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => _service.refreshTasks(),
                icon: const Icon(
                  Icons.refresh_rounded,
                  color: SyncOpsTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: availableTasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.verified_outlined,
                          size: 48,
                          color: SyncOpsTheme.successGreen,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No pending emergency tasks in queue.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Switch to Dispatcher to create or simulate a critical incident.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: SyncOpsTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: availableTasks.length,
                    itemBuilder: (context, index) {
                      final task = availableTasks[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SeverityBadge(severity: task.severity),
                                      const SizedBox(width: 8),
                                      StatusBadge(status: task.status),
                                    ],
                                  ),
                                  if (task.reassignmentCount > 0)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: SyncOpsTheme.criticalRed
                                            .withOpacity(0.18),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: SyncOpsTheme.criticalRed
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      child: Text(
                                        'REOPENED DUE TO TIMEOUT',
                                        style: GoogleFonts.jetBrainsMono(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w800,
                                          color: SyncOpsTheme.criticalRed,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                task.title,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                task.description,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  color: SyncOpsTheme.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'COORDINATES: ${task.latitude.toStringAsFixed(3)}°, ${task.longitude.toStringAsFixed(3)}°',
                                    style: GoogleFonts.jetBrainsMono(
                                      fontSize: 10,
                                      color: SyncOpsTheme.textMuted,
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: _isProcessing
                                        ? null
                                        : () => _acceptTask(task.id!),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: SyncOpsTheme.primaryCyan,
                                      foregroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.check_circle_outline,
                                      size: 16,
                                    ),
                                    label: Text(
                                      'ACCEPT TASK',
                                      style: GoogleFonts.jetBrainsMono(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _acceptTask(int taskId) async {
    setState(() => _isProcessing = true);
    try {
      await _service.acceptTask(taskId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task accepted! Response window initialized.'),
            backgroundColor: SyncOpsTheme.successGreen,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: SyncOpsTheme.criticalRed,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<void> _advanceStatus(int taskId, String nextStatus) async {
    setState(() => _isProcessing = true);
    try {
      await _service.advanceStatus(taskId, nextStatus);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transition error: $e'),
            backgroundColor: SyncOpsTheme.criticalRed,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  void _showReleaseDialog(Task task) {
    final reasonController = TextEditingController(
      text: 'Encountered vehicle malfunction on route',
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: SyncOpsTheme.surface,
          title: Text(
            'VOLUNTARY TASK RELEASE',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Releasing will return this emergency incident immediately to the dispatcher queue.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: SyncOpsTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: reasonController,
                style: GoogleFonts.plusJakartaSans(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Reason for Release',
                  filled: true,
                  fillColor: SyncOpsTheme.surfaceElevated,
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                setState(() => _isProcessing = true);
                try {
                  await _service.releaseTask(task.id!, reasonController.text);
                } finally {
                  if (mounted) setState(() => _isProcessing = false);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: SyncOpsTheme.alertOrange,
              ),
              child: const Text('CONFIRM RELEASE'),
            ),
          ],
        );
      },
    );
  }
}
