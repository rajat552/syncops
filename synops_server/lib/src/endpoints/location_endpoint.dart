import 'package:serverpod/serverpod.dart';
import 'package:synops_server/src/generated/future_calls.dart';
import 'package:synops_server/src/generated/protocol.dart';

class LocationEndpoint extends Endpoint {
  /// Responder submits a live GPS ping/telemetry update.
  Future<void> sendLocationPing(Session session, LocationPing ping) async {
    // High-frequency telemetry is streamed in real-time, not dumped to PostgreSQL
    await session.messages.postMessage('location_pings_${ping.taskId}', ping);
    await session.messages.postMessage('location_pings_all', ping);

    // Update task's last activity timestamp and push back the deadline
    final task = await Task.db.findById(session, ping.taskId);
    if (task != null && (task.status == 'ACCEPTED' || task.status == 'EN_ROUTE' || task.status == 'IN_PROGRESS')) {
      final now = DateTime.now().toUtc();
      task.lastActivityAt = now;
      task.expiresAt = now.add(const Duration(seconds: 45));
      await Task.db.updateRow(session, task);

      // Reschedule future call timeout with refreshed 45s deadline
      await session.serverpod.futureCalls
          .callWithDelay(
            const Duration(seconds: 45),
            identifier: 'task-timeout-${task.id}',
          )
          .taskTimeoutCall
          .handleTimeout(task.id!);

      // Broadcast task update so coordinator sees refreshed last-seen timestamp
      await session.messages.postMessage('task_updates', task);
    }
  }

  /// Live stream of location updates for a specific emergency incident.
  Stream<LocationPing> subscribeToTaskLocation(Session session, int taskId) async* {
    final stream = session.messages.createStream<LocationPing>('location_pings_$taskId');
    await for (final ping in stream) {
      yield ping;
    }
  }

  /// Live stream of all active responders across the operations map.
  Stream<LocationPing> subscribeToAllLocations(Session session) async* {
    final stream = session.messages.createStream<LocationPing>('location_pings_all');
    await for (final ping in stream) {
      yield ping;
    }
  }
}
