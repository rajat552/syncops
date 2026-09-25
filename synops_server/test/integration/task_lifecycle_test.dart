import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Given Task Endpoint and Lifecycle Workflow',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      test(
        'Coordinator creates critical incident, sets up timeline and open task list',
        () async {
          final task = await endpoints.task.createTask(
            sessionBuilder,
            title: 'Emergency Trauma Supply Delivery',
            description:
                'Urgent delivery of blood units to Sector 4 field hospital.',
            latitude: 37.7749,
            longitude: -122.4194,
            severity: 'CRITICAL',
            createdById: 101,
            requiredSkill: 'HAZMAT_PARAMEDIC',
            timeoutSeconds: 60,
          );

          expect(task.id, isNotNull);
          expect(task.title, 'Emergency Trauma Supply Delivery');
          expect(task.status, 'PENDING');
          expect(task.severity, 'CRITICAL');
          expect(task.reassignmentCount, 0);

          // Verify audit event timeline
          final timeline = await endpoints.task.getTaskTimeline(
            sessionBuilder,
            task.id!,
          );
          expect(timeline.length, 1);
          expect(timeline.first.type, 'TASK_CREATED');

          // Verify in open tasks list
          final openTasks = await endpoints.task.getOpenTasks(sessionBuilder);
          expect(openTasks.any((t) => t.id == task.id), isTrue);
        },
      );

      test('Responder accepts task and transitions to ACCEPTED', () async {
        final task = await endpoints.task.createTask(
          sessionBuilder,
          title: 'Search and Rescue Grid B',
          description: 'Missing hiker reported near northern ridge.',
          latitude: 37.7833,
          longitude: -122.4167,
          severity: 'HIGH',
          createdById: 101,
          timeoutSeconds: 45,
        );

        final acceptedTask = await endpoints.task.acceptTask(
          sessionBuilder,
          taskId: task.id!,
          responderId: 201,
          responderName: 'Officer Miller',
          timeoutSeconds: 45,
        );

        expect(acceptedTask.status, 'ACCEPTED');
        expect(acceptedTask.assignedToId, 201);
        expect(acceptedTask.assignedResponderName, 'Officer Miller');
        expect(acceptedTask.expiresAt, isNotNull);

        // Verify timeline recorded acceptance
        final timeline = await endpoints.task.getTaskTimeline(
          sessionBuilder,
          task.id!,
        );
        expect(timeline.length, 2);
        expect(timeline.any((e) => e.type == 'TASK_ACCEPTED'), isTrue);
      });

      test(
        'Prevents duplicate concurrent acceptance by second responder',
        () async {
          final task = await endpoints.task.createTask(
            sessionBuilder,
            title: 'Generator Power Failure',
            description: 'Substation cooling pump down.',
            latitude: 37.7600,
            longitude: -122.4200,
            severity: 'HIGH',
            createdById: 101,
            timeoutSeconds: 45,
          );

          // First responder claims
          await endpoints.task.acceptTask(
            sessionBuilder,
            taskId: task.id!,
            responderId: 201,
            responderName: 'Responder One',
            timeoutSeconds: 45,
          );

          // Second responder tries to claim the same task -> must be rejected
          expect(
            () async => await endpoints.task.acceptTask(
              sessionBuilder,
              taskId: task.id!,
              responderId: 202,
              responderName: 'Responder Two',
              timeoutSeconds: 45,
            ),
            throwsA(isA<StateError>()),
          );
        },
      );

      test(
        'Responder advances task through full lifecycle to COMPLETED',
        () async {
          final task = await endpoints.task.createTask(
            sessionBuilder,
            title: 'Water Rescue Patrol',
            description: 'Stranded kayak near pier 14.',
            latitude: 37.7900,
            longitude: -122.3900,
            severity: 'CRITICAL',
            createdById: 101,
            timeoutSeconds: 60,
          );

          await endpoints.task.acceptTask(
            sessionBuilder,
            taskId: task.id!,
            responderId: 201,
            responderName: 'Medic Dave',
            timeoutSeconds: 60,
          );

          // Transition to EN_ROUTE
          final enRoute = await endpoints.task.updateTaskStatus(
            sessionBuilder,
            taskId: task.id!,
            responderId: 201,
            newStatus: 'EN_ROUTE',
            timeoutSeconds: 60,
          );
          expect(enRoute.status, 'EN_ROUTE');
          expect(enRoute.startedAt, isNotNull);

          // Transition to ARRIVED
          final arrived = await endpoints.task.updateTaskStatus(
            sessionBuilder,
            taskId: task.id!,
            responderId: 201,
            newStatus: 'ARRIVED',
            timeoutSeconds: 60,
          );
          expect(arrived.status, 'ARRIVED');
          expect(arrived.arrivedAt, isNotNull);

          // Transition to IN_PROGRESS
          final inProgress = await endpoints.task.updateTaskStatus(
            sessionBuilder,
            taskId: task.id!,
            responderId: 201,
            newStatus: 'IN_PROGRESS',
            timeoutSeconds: 60,
          );
          expect(inProgress.status, 'IN_PROGRESS');

          // Transition to COMPLETED
          final completed = await endpoints.task.updateTaskStatus(
            sessionBuilder,
            taskId: task.id!,
            responderId: 201,
            newStatus: 'COMPLETED',
            timeoutSeconds: 60,
          );
          expect(completed.status, 'COMPLETED');
          expect(completed.completedAt, isNotNull);
          expect(completed.expiresAt, isNull);
        },
      );

      test(
        'Rejects unauthorized status updates and invalid state transitions',
        () async {
          final task = await endpoints.task.createTask(
            sessionBuilder,
            title: 'Gas Leak Perimeter Security',
            description: 'Secure 100m perimeter around building C.',
            latitude: 37.7500,
            longitude: -122.4300,
            severity: 'MEDIUM',
            createdById: 101,
            timeoutSeconds: 60,
          );

          await endpoints.task.acceptTask(
            sessionBuilder,
            taskId: task.id!,
            responderId: 201,
            responderName: 'Guard Alex',
            timeoutSeconds: 60,
          );

          // Wrong responder tries to update status
          expect(
            () async => await endpoints.task.updateTaskStatus(
              sessionBuilder,
              taskId: task.id!,
              responderId: 999, // Unauthorized
              newStatus: 'EN_ROUTE',
              timeoutSeconds: 60,
            ),
            throwsA(isA<StateError>()),
          );

          // Authorized responder tries invalid jump: ACCEPTED -> COMPLETED without en_route/arrived
          expect(
            () async => await endpoints.task.updateTaskStatus(
              sessionBuilder,
              taskId: task.id!,
              responderId: 201,
              newStatus: 'COMPLETED',
              timeoutSeconds: 60,
            ),
            throwsA(isA<StateError>()),
          );
        },
      );

      test(
        'Automated recovery: Simulating timeout reopens task, clears responder, and increments count',
        () async {
          final task = await endpoints.task.createTask(
            sessionBuilder,
            title: 'Avalanche Beacon Search',
            description: 'Beacon signal active at coordinates.',
            latitude: 37.7600,
            longitude: -122.4400,
            severity: 'CRITICAL',
            createdById: 101,
            timeoutSeconds: 45,
          );

          await endpoints.task.acceptTask(
            sessionBuilder,
            taskId: task.id!,
            responderId: 201,
            responderName: 'Responder One',
            timeoutSeconds: 45,
          );

          // Trigger simulated timeout recovery (same pipeline as Future Call)
          final recoveredTask = await endpoints.task.triggerSimulatedTimeout(
            sessionBuilder,
            taskId: task.id!,
          );

          expect(recoveredTask.status, 'PENDING');
          expect(recoveredTask.assignedToId, isNull);
          expect(recoveredTask.assignedResponderName, isNull);
          expect(recoveredTask.reassignmentCount, 1);

          // Verify audit event exists
          final timeline = await endpoints.task.getTaskTimeline(
            sessionBuilder,
            task.id!,
          );
          expect(
            timeline.any((e) => e.type == 'TIMEOUT_AUTO_RECOVERED'),
            isTrue,
          );

          // Second responder can now claim the reopened task!
          final secondResponderTask = await endpoints.task.acceptTask(
            sessionBuilder,
            taskId: task.id!,
            responderId: 202,
            responderName: 'Responder Two',
            timeoutSeconds: 45,
          );

          expect(secondResponderTask.status, 'ACCEPTED');
          expect(secondResponderTask.assignedToId, 202);
          expect(secondResponderTask.assignedResponderName, 'Responder Two');
          expect(secondResponderTask.reassignmentCount, 1);
        },
      );
    },
  );
}
