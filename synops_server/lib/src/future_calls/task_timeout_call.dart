import 'package:serverpod/serverpod.dart';
import 'package:synops_server/src/generated/protocol.dart';

class TaskTimeoutCall extends FutureCall {
  Future<void> handleTimeout(Session session, int taskId) async {
    session.log('Checking timeout for task #$taskId', level: LogLevel.info);

    final task = await Task.db.findById(session, taskId);
    if (task == null) {
      session.log('Task #$taskId not found for timeout check', level: LogLevel.warning);
      return;
    }

    // Only recover if still in an active uncompleted state
    final activeStatuses = {'ACCEPTED', 'EN_ROUTE', 'IN_PROGRESS'};
    if (!activeStatuses.contains(task.status)) {
      session.log('Task #$taskId status is "${task.status}". No timeout recovery needed.', level: LogLevel.info);
      return;
    }

    // If expiresAt was pushed back by a recent ping, do not expire yet
    if (task.expiresAt != null && DateTime.now().toUtc().isBefore(task.expiresAt!)) {
      session.log('Task #$taskId expiresAt is in the future (${task.expiresAt}). Skipping timeout.', level: LogLevel.info);
      return;
    }

    final previousResponder = task.assignedResponderName ?? 'Responder #${task.assignedToId}';
    final previousStatus = task.status;

    // Idempotent atomic state recovery
    task.assignedToId = null;
    task.assignedResponderName = null;
    task.status = 'PENDING';
    task.reassignmentCount = task.reassignmentCount + 1;
    task.expiresAt = null;

    final updatedTask = await Task.db.updateRow(session, task);

    // Create audit event
    final auditEvent = TaskEvent(
      taskId: taskId,
      actorName: 'SYSTEM_AUTOPILOT',
      type: 'TIMEOUT_AUTO_RECOVERED',
      message: 'Responder ($previousResponder) became inactive in state $previousStatus. Task automatically recovered and reopened for dispatch.',
      timestamp: DateTime.now().toUtc(),
      metadata: '{"previousResponder": "$previousResponder", "reassignmentCount": ${task.reassignmentCount}}',
    );
    await TaskEvent.db.insertRow(session, auditEvent);

    // Broadcast real-time updates to all connected listeners
    await session.messages.postMessage('task_updates', updatedTask);
    await session.messages.postMessage('task_events_$taskId', auditEvent);
    await session.messages.postMessage('task_events_all', auditEvent);

    session.log('Task #$taskId automatically recovered and reopened (Reassignment #${task.reassignmentCount}).', level: LogLevel.info);
  }
}
