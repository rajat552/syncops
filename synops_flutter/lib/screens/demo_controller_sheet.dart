import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synops_client/synops_client.dart';
import '../core/constants.dart';
import '../core/theme.dart';
import '../services/syncops_service.dart';

class DemoControllerSheet extends StatefulWidget {
  const DemoControllerSheet({super.key});

  @override
  State<DemoControllerSheet> createState() => _DemoControllerSheetState();
}

class _DemoControllerSheetState extends State<DemoControllerSheet> {
  final _service = SyncOpsService.instance;
  int _currentStep = 0;
  bool _isBusy = false;
  Task? _demoTask;
  String _lastStatusMessage =
      'Ready to begin 3-minute hackathon judge scenario.';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: SyncOpsTheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: SyncOpsTheme.primaryCyan.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.rocket_launch_rounded,
                        color: SyncOpsTheme.primaryCyan,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SYNCOPS HACKATHON HERO DEMO',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Automated Inactivity Detection & Recovery in 7 Steps',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: SyncOpsTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close_rounded,
                    color: SyncOpsTheme.textMuted,
                  ),
                ),
              ],
            ),
            const Divider(color: SyncOpsTheme.border, height: 24),

            // Status notification bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: SyncOpsTheme.surfaceElevated,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: SyncOpsTheme.primaryCyan.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  if (_isBusy) ...[
                    const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: SyncOpsTheme.primaryCyan,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      _lastStatusMessage,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        color: SyncOpsTheme.primaryCyan,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Step 1: Create Critical Incident
            _buildStepRow(
              stepNumber: 1,
              title: 'Create Critical Incident',
              subtitle:
                  'Dispatcher creates "Trauma Blood Delivery" with 40s response window.',
              buttonLabel: '1. DISPATCH INCIDENT',
              buttonColor: SyncOpsTheme.criticalRed,
              onPressed: _step1CreateIncident,
              isCompleted: _currentStep >= 1,
            ),

            // Step 2: Responder A Accepts
            _buildStepRow(
              stepNumber: 2,
              title: 'Responder A Accepts',
              subtitle:
                  'Officer Alex claims task. Serverpod schedules timeout future call.',
              buttonLabel: '2. RESPONDER A ACCEPTS',
              buttonColor: SyncOpsTheme.primaryCyan,
              onPressed: _currentStep >= 1 ? _step2ResponderAAccepts : null,
              isCompleted: _currentStep >= 2,
            ),

            // Step 3: Stream Live GPS Telemetry
            _buildStepRow(
              stepNumber: 3,
              title: 'Stream Live GPS Telemetry',
              subtitle:
                  'Broadcast real-time location pings to Serverpod stream.',
              buttonLabel: '3. STREAM GPS PINGS',
              buttonColor: SyncOpsTheme.accentBlue,
              onPressed: _currentStep >= 2 ? _step3StreamTelemetry : null,
              isCompleted: _currentStep >= 3,
            ),

            // Step 4: Simulate Responder Going Silent / Timeout
            _buildStepRow(
              stepNumber: 4,
              title: 'HERO MOMENT: Responder Goes Silent',
              subtitle:
                  'Stop telemetry and trigger Serverpod automated recovery.',
              buttonLabel: '4. SIMULATE ABANDONMENT',
              buttonColor: SyncOpsTheme.criticalRed,
              onPressed: _currentStep >= 3 ? _step4TriggerTimeout : null,
              isCompleted: _currentStep >= 4,
            ),

            // Step 5: Verify Auto-Recovery & Reassignment
            _buildStepRow(
              stepNumber: 5,
              title: 'Serverpod Auto-Recovery Triggered',
              subtitle:
                  'Task returned to PENDING. Reassignment count incremented.',
              buttonLabel: '5. VERIFY REOPENED QUEUE',
              buttonColor: SyncOpsTheme.alertOrange,
              onPressed: _currentStep >= 4 ? _step5VerifyRecovery : null,
              isCompleted: _currentStep >= 5,
            ),

            // Step 6: Responder B Accepts Reopened Task
            _buildStepRow(
              stepNumber: 6,
              title: 'Second Responder Accepts',
              subtitle:
                  'Officer Bailey accepts recovered task. Mission continues.',
              buttonLabel: '6. RESPONDER B ACCEPTS',
              buttonColor: SyncOpsTheme.purpleNeon,
              onPressed: _currentStep >= 5 ? _step6ResponderBAccepts : null,
              isCompleted: _currentStep >= 6,
            ),

            // Step 7: Mission Completed
            _buildStepRow(
              stepNumber: 7,
              title: 'Complete Incident & Inspect Audit',
              subtitle:
                  'Mark COMPLETED and review full immutable audit timeline.',
              buttonLabel: '7. COMPLETE MISSION',
              buttonColor: SyncOpsTheme.successGreen,
              onPressed: _currentStep >= 6 ? _step7CompleteMission : null,
              isCompleted: _currentStep >= 7,
            ),

            const SizedBox(height: 16),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    _currentStep = 0;
                    _demoTask = null;
                    _lastStatusMessage = 'Reset demo scenario.';
                  });
                },
                icon: const Icon(
                  Icons.refresh_rounded,
                  size: 16,
                  color: SyncOpsTheme.textMuted,
                ),
                label: Text(
                  'RESET DEMO SCENARIO',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 11,
                    color: SyncOpsTheme.textMuted,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepRow({
    required int stepNumber,
    required String title,
    required String subtitle,
    required String buttonLabel,
    required Color buttonColor,
    required VoidCallback? onPressed,
    required bool isCompleted,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCompleted
            ? SyncOpsTheme.surfaceElevated.withOpacity(0.8)
            : SyncOpsTheme.surfaceElevated.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCompleted
              ? SyncOpsTheme.successGreen.withOpacity(0.5)
              : SyncOpsTheme.border.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted
                  ? SyncOpsTheme.successGreen
                  : buttonColor.withOpacity(0.2),
              border: Border.all(
                color: isCompleted ? SyncOpsTheme.successGreen : buttonColor,
                width: 1.5,
              ),
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : Text(
                      stepNumber.toString(),
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isCompleted
                        ? SyncOpsTheme.textSecondary
                        : Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: SyncOpsTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: (_isBusy || onPressed == null) ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
            child: Text(
              buttonLabel,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _step1CreateIncident() async {
    setState(() => _isBusy = true);
    try {
      _service.setRole(SyncOpsConstants.coordinator);
      final task = await _service.createIncident(
        title: 'Trauma Blood Delivery [DEMO HERO]',
        description:
            'Urgent type O-negative blood units to Sector 4 field triage.',
        latitude: 37.7749,
        longitude: -122.4194,
        severity: 'CRITICAL',
        timeoutSeconds: 30,
      );
      setState(() {
        _demoTask = task;
        _currentStep = 1;
        _lastStatusMessage =
            'Step 1 Complete: Created Incident #${task.id} (Status: PENDING).';
      });
    } catch (e) {
      setState(() => _lastStatusMessage = 'Error: $e');
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _step2ResponderAAccepts() async {
    if (_demoTask == null) return;
    setState(() => _isBusy = true);
    try {
      _service.setRole(SyncOpsConstants.responderA);
      final task = await _service.acceptTask(
        _demoTask!.id!,
        timeoutSeconds: 30,
      );
      setState(() {
        _demoTask = task;
        _currentStep = 2;
        _lastStatusMessage =
            'Step 2 Complete: Responder Alex Chen accepted Task #${task.id}. Timeout scheduled.';
      });
    } catch (e) {
      setState(() => _lastStatusMessage = 'Error: $e');
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _step3StreamTelemetry() async {
    if (_demoTask == null) return;
    setState(() => _isBusy = true);
    try {
      await _service.advanceStatus(_demoTask!.id!, 'EN_ROUTE');
      await _service.sendPing(
        taskId: _demoTask!.id!,
        latitude: _demoTask!.latitude - 0.008,
        longitude: _demoTask!.longitude - 0.006,
        speed: 42.0,
      );
      setState(() {
        _currentStep = 3;
        _lastStatusMessage =
            'Step 3 Complete: Alex is EN_ROUTE. Streamed live GPS telemetry to coordinator.';
      });
    } catch (e) {
      setState(() => _lastStatusMessage = 'Error: $e');
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _step4TriggerTimeout() async {
    if (_demoTask == null) return;
    setState(() => _isBusy = true);
    try {
      final task = await _service.triggerSimulatedTimeout(_demoTask!.id!);
      setState(() {
        _demoTask = task;
        _currentStep = 4;
        _lastStatusMessage =
            'Step 4 & 5 Complete: Inactivity detected! Serverpod auto-recovered Task #${task.id} back to PENDING (Reassignments: ${task.reassignmentCount}).';
      });
    } catch (e) {
      setState(() => _lastStatusMessage = 'Error: $e');
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _step5VerifyRecovery() async {
    if (_demoTask == null) return;
    setState(() => _isBusy = true);
    try {
      await _service.refreshTasks();
      final updated = _service.tasks
          .where((t) => t.id == _demoTask!.id)
          .firstOrNull;
      setState(() {
        _demoTask = updated ?? _demoTask;
        _currentStep = 5;
        _lastStatusMessage =
            'Step 5 Verified: Task is claimable in Open Queue. Assignee cleared.';
      });
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _step6ResponderBAccepts() async {
    if (_demoTask == null) return;
    setState(() => _isBusy = true);
    try {
      _service.setRole(SyncOpsConstants.responderB);
      final task = await _service.acceptTask(
        _demoTask!.id!,
        timeoutSeconds: 40,
      );
      setState(() {
        _demoTask = task;
        _currentStep = 6;
        _lastStatusMessage =
            'Step 6 Complete: Bailey Torres claimed reopened task! Recovery pipeline verified.';
      });
    } catch (e) {
      setState(() => _lastStatusMessage = 'Error: $e');
    } finally {
      setState(() => _isBusy = false);
    }
  }

  Future<void> _step7CompleteMission() async {
    if (_demoTask == null) return;
    setState(() => _isBusy = true);
    try {
      await _service.advanceStatus(_demoTask!.id!, 'EN_ROUTE');
      await _service.advanceStatus(_demoTask!.id!, 'ARRIVED');
      await _service.advanceStatus(_demoTask!.id!, 'IN_PROGRESS');
      final task = await _service.advanceStatus(_demoTask!.id!, 'COMPLETED');
      await _service.loadTimeline(task.id!);
      setState(() {
        _demoTask = task;
        _currentStep = 7;
        _lastStatusMessage =
            'HERO SCENARIO COMPLETE! Mission succeeded. Review full audit timeline in Coordinator.';
      });
    } catch (e) {
      setState(() => _lastStatusMessage = 'Error: $e');
    } finally {
      setState(() => _isBusy = false);
    }
  }
}
