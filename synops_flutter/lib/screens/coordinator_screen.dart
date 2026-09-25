import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synops_client/synops_client.dart';
import '../core/constants.dart';
import '../core/theme.dart';
import '../services/syncops_service.dart';
import '../widgets/countdown_timer_view.dart';
import '../widgets/incident_timeline_widget.dart';
import '../widgets/status_badge.dart';
import '../widgets/tactical_map_view.dart';

class CoordinatorScreen extends StatefulWidget {
  const CoordinatorScreen({super.key});

  @override
  State<CoordinatorScreen> createState() => _CoordinatorScreenState();
}

class _CoordinatorScreenState extends State<CoordinatorScreen> {
  final _service = SyncOpsService.instance;
  String _filter = 'ALL';

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _service,
      builder: (context, _) {
        final tasks = _filteredTasks();
        final selected = _service.selectedTask;

        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;

              return Column(
                children: [
                  _buildKpiBanner(),
                  _buildFilterAndActionBar(),
                  Expanded(
                    child: isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: _buildTaskList(tasks),
                              ),
                              Container(
                                width: 1,
                                color: SyncOpsTheme.border,
                              ),
                              Expanded(
                                flex: 6,
                                child: selected != null
                                    ? _buildTaskDetailPane(selected)
                                    : _buildEmptyDetailPlaceholder(),
                              ),
                            ],
                          )
                        : _buildTaskList(tasks),
                  ),
                ],
              );
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showCreateIncidentDialog(context),
            backgroundColor: SyncOpsTheme.criticalRed,
            icon: const Icon(Icons.add_alert_rounded, color: Colors.white),
            label: Text(
              'DISPATCH INCIDENT',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        );
      },
    );
  }

  List<Task> _filteredTasks() {
    final list = _service.tasks;
    if (_filter == 'ALL') return list;
    if (_filter == 'ACTIVE') {
      return list
          .where((t) => t.status != 'COMPLETED' && t.status != 'CANCELLED')
          .toList();
    }
    if (_filter == 'REASSIGNED') {
      return list.where((t) => t.reassignmentCount > 0).toList();
    }
    if (_filter == 'CRITICAL') {
      return list.where((t) => t.severity == 'CRITICAL').toList();
    }
    if (_filter == 'COMPLETED') {
      return list.where((t) => t.status == 'COMPLETED').toList();
    }
    return list;
  }

  Widget _buildKpiBanner() {
    final summary = _service.dashboardSummary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: SyncOpsTheme.surface,
        border: Border(
          bottom: BorderSide(color: SyncOpsTheme.border, width: 1),
        ),
      ),
      child: Row(
        children: [
          _buildKpiCard(
            label: 'ACTIVE INCIDENTS',
            value: (summary?.activeIncidents ?? 0).toString(),
            color: SyncOpsTheme.primaryCyan,
            icon: Icons.emergency_outlined,
          ),
          const SizedBox(width: 8),
          _buildKpiCard(
            label: 'IN RESPONSE',
            value: (summary?.inResponse ?? 0).toString(),
            color: SyncOpsTheme.accentBlue,
            icon: Icons.directions_run_rounded,
          ),
          const SizedBox(width: 8),
          _buildKpiCard(
            label: 'NEEDS ATTENTION',
            value: (summary?.needsAttention ?? 0).toString(),
            color: SyncOpsTheme.alertOrange,
            icon: Icons.warning_amber_rounded,
          ),
          const SizedBox(width: 8),
          _buildKpiCard(
            label: 'REASSIGNED TOTAL',
            value: (summary?.reassignedTotal ?? 0).toString(),
            color: SyncOpsTheme.criticalRed,
            icon: Icons.autorenew_rounded,
          ),
          const SizedBox(width: 8),
          _buildKpiCard(
            label: 'COMPLETED TODAY',
            value: (summary?.completedToday ?? 0).toString(),
            color: SyncOpsTheme.successGreen,
            icon: Icons.check_circle_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildKpiCard({
    required String label,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: SyncOpsTheme.surfaceElevated.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: SyncOpsTheme.border.withOpacity(0.6),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    label,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: SyncOpsTheme.textMuted,
                      letterSpacing: 0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(icon, size: 14, color: color),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterAndActionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: SyncOpsTheme.surface.withOpacity(0.8),
        border: Border(
          bottom: BorderSide(color: SyncOpsTheme.border, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('ALL', 'All'),
                _buildFilterChip('ACTIVE', 'Active Response'),
                _buildFilterChip('CRITICAL', 'Critical'),
                _buildFilterChip('REASSIGNED', 'Recovered'),
                _buildFilterChip('COMPLETED', 'Completed'),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _service.refreshTasks(),
            icon: const Icon(
              Icons.refresh_rounded,
              size: 18,
              color: SyncOpsTheme.textSecondary,
            ),
            tooltip: 'Refresh Feed',
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final isSelected = _filter == value;
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (val) {
          if (val) setState(() => _filter = value);
        },
        labelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected ? Colors.white : SyncOpsTheme.textSecondary,
        ),
        selectedColor: SyncOpsTheme.primaryCyan.withOpacity(0.3),
        backgroundColor: SyncOpsTheme.surfaceElevated,
        side: BorderSide(
          color: isSelected ? SyncOpsTheme.primaryCyan : SyncOpsTheme.border,
          width: 1,
        ),
      ),
    );
  }

  Widget _buildTaskList(List<Task> tasks) {
    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 48, color: SyncOpsTheme.textMuted),
            const SizedBox(height: 12),
            Text(
              'No incidents found matching filter',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                color: SyncOpsTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Click "DISPATCH INCIDENT" to create a new critical mission.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: SyncOpsTheme.textMuted,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final isSelected = _service.selectedTask?.id == task.id;

        return Card(
          color: isSelected
              ? SyncOpsTheme.surfaceHighlight
              : SyncOpsTheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: isSelected
                  ? SyncOpsTheme.primaryCyan
                  : SyncOpsTheme.border,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          margin: const EdgeInsets.only(bottom: 8),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              _service.selectTask(task);
              if (MediaQuery.of(context).size.width < 900) {
                _showTaskDetailBottomSheet(context, task);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            color: SyncOpsTheme.criticalRed.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: SyncOpsTheme.criticalRed.withOpacity(0.5),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.autorenew_rounded,
                                size: 11,
                                color: SyncOpsTheme.criticalRed,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                'AUTO-RECOVERED (${task.reassignmentCount}x)',
                                style: GoogleFonts.jetBrainsMono(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  color: SyncOpsTheme.criticalRed,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    task.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: SyncOpsTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: SyncOpsTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            task.assignedResponderName != null
                                ? Icons.person_pin_circle_rounded
                                : Icons.schedule_rounded,
                            size: 13,
                            color: SyncOpsTheme.textMuted,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            task.assignedResponderName != null
                                ? task.assignedResponderName!
                                : 'Awaiting Responder',
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 11,
                              color: task.assignedResponderName != null
                                  ? SyncOpsTheme.primaryCyan
                                  : SyncOpsTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                      if (task.expiresAt != null && task.status != 'COMPLETED')
                        CountdownTimerView(expiresAt: task.expiresAt),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTaskDetailPane(Task task) {
    final lastPing = _service.lastPingsByTask[task.id];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SeverityBadge(severity: task.severity),
                  const SizedBox(width: 8),
                  StatusBadge(status: task.status, isLarge: true),
                ],
              ),
              if (task.expiresAt != null && task.status != 'COMPLETED')
                CountdownTimerView(expiresAt: task.expiresAt),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            task.title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            task.description,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: SyncOpsTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 16),

          // Tactical Radar / Live Telemetry Map
          TacticalMapView(task: task, lastPing: lastPing),

          const SizedBox(height: 16),

          // Demo action bar: Simulate Inactivity & Timeout
          if (task.status == 'ACCEPTED' ||
              task.status == 'EN_ROUTE' ||
              task.status == 'IN_PROGRESS') ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: SyncOpsTheme.criticalRed.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: SyncOpsTheme.criticalRed.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.bolt_rounded,
                    color: SyncOpsTheme.criticalRed,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'JUDGE HERO DEMO TRIGGER',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: SyncOpsTheme.criticalRed,
                          ),
                        ),
                        Text(
                          'Simulate responder going radio-silent to trigger Serverpod automatic recovery.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: SyncOpsTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await _service.triggerSimulatedTimeout(task.id!);
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Simulated timeout executed: Serverpod recovered task to PENDING queue!',
                            ),
                            backgroundColor: SyncOpsTheme.criticalRed,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SyncOpsTheme.criticalRed,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    icon: const Icon(Icons.timer_off_rounded, size: 16),
                    label: Text(
                      'TRIGGER TIMEOUT',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Incident Timeline Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'INCIDENT TIMELINE AUDIT',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: SyncOpsTheme.textMuted,
                  letterSpacing: 0.8,
                ),
              ),
              Text(
                '${_service.activeTimeline.length} events logged',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: SyncOpsTheme.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          IncidentTimelineWidget(events: _service.activeTimeline),
        ],
      ),
    );
  }

  Widget _buildEmptyDetailPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.radar_rounded,
            size: 64,
            color: SyncOpsTheme.textMuted.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'SELECT AN INCIDENT TO MONITOR',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: SyncOpsTheme.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Select any active or past incident from the feed to view live radar and audit trail.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: SyncOpsTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  void _showTaskDetailBottomSheet(BuildContext context, Task task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: SyncOpsTheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return _buildTaskDetailPane(task);
          },
        );
      },
    );
  }

  void _showCreateIncidentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const _CreateIncidentDialog(),
    );
  }
}

class _CreateIncidentDialog extends StatefulWidget {
  const _CreateIncidentDialog();

  @override
  State<_CreateIncidentDialog> createState() => _CreateIncidentDialogState();
}

class _CreateIncidentDialogState extends State<_CreateIncidentDialog> {
  final _titleController = TextEditingController(
    text: 'Critical Trauma Supply Delivery',
  );
  final _descController = TextEditingController(
    text:
        'Urgent blood plasma and defibrillator transport to Sector 4 field clinic.',
  );
  String _severity = 'CRITICAL';
  int _timeoutSeconds = 40;
  bool _isCreating = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: SyncOpsTheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: SyncOpsTheme.border, width: 1),
      ),
      title: Row(
        children: [
          const Icon(
            Icons.add_alert_rounded,
            color: SyncOpsTheme.criticalRed,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'DISPATCH EMERGENCY INCIDENT',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 480,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'QUICK PRESETS (HACKATHON DEMO)',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: SyncOpsTheme.textMuted,
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: SyncOpsConstants.presetIncidents.map((p) {
                  return ActionChip(
                    label: Text(p['title'] as String),
                    labelStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                    backgroundColor: SyncOpsTheme.surfaceElevated,
                    onPressed: () {
                      setState(() {
                        _titleController.text = p['title'] as String;
                        _descController.text = p['description'] as String;
                        _severity = p['severity'] as String;
                        _timeoutSeconds = p['timeoutSeconds'] as int;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                style: GoogleFonts.plusJakartaSans(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Incident Title',
                  filled: true,
                  fillColor: SyncOpsTheme.surfaceElevated,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descController,
                maxLines: 2,
                style: GoogleFonts.plusJakartaSans(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Mission Description',
                  filled: true,
                  fillColor: SyncOpsTheme.surfaceElevated,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _severity,
                      dropdownColor: SyncOpsTheme.surfaceElevated,
                      style: GoogleFonts.plusJakartaSans(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Severity',
                        filled: true,
                        fillColor: SyncOpsTheme.surfaceElevated,
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'CRITICAL',
                          child: Text('CRITICAL'),
                        ),
                        DropdownMenuItem(value: 'HIGH', child: Text('HIGH')),
                        DropdownMenuItem(
                          value: 'MEDIUM',
                          child: Text('MEDIUM'),
                        ),
                        DropdownMenuItem(value: 'LOW', child: Text('LOW')),
                      ],
                      onChanged: (val) =>
                          setState(() => _severity = val ?? 'CRITICAL'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      initialValue: _timeoutSeconds.toString(),
                      style: GoogleFonts.plusJakartaSans(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Timeout Window (s)',
                        filled: true,
                        fillColor: SyncOpsTheme.surfaceElevated,
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (val) =>
                          _timeoutSeconds = int.tryParse(val) ?? 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'CANCEL',
            style: GoogleFonts.plusJakartaSans(color: SyncOpsTheme.textMuted),
          ),
        ),
        ElevatedButton(
          onPressed: _isCreating
              ? null
              : () async {
                  final navigator = Navigator.of(context);
                  final messenger = ScaffoldMessenger.of(context);
                  setState(() => _isCreating = true);
                  try {
                    await SyncOpsService.instance.createIncident(
                      title: _titleController.text,
                      description: _descController.text,
                      latitude: 37.7749,
                      longitude: -122.4194,
                      severity: _severity,
                      timeoutSeconds: _timeoutSeconds,
                    );
                    if (mounted) navigator.pop();
                  } catch (e) {
                    if (mounted) {
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text('Failed: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } finally {
                    if (mounted) setState(() => _isCreating = false);
                  }
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: SyncOpsTheme.criticalRed,
            foregroundColor: Colors.white,
          ),
          child: _isCreating
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  'DISPATCH NOW',
                  style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.w700),
                ),
        ),
      ],
    );
  }
}
