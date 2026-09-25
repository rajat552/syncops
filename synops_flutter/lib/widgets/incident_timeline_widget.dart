import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synops_client/synops_client.dart';
import '../core/theme.dart';

class IncidentTimelineWidget extends StatelessWidget {
  final List<TaskEvent> events;

  const IncidentTimelineWidget({
    super.key,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'No events recorded yet.',
            style: GoogleFonts.plusJakartaSans(color: SyncOpsTheme.textMuted),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        final isLast = index == events.length - 1;
        final isRecovery =
            event.type == 'TIMEOUT_AUTO_RECOVERED' ||
            event.type == 'TASK_REOPENED';
        final isCreated = event.type == 'TASK_CREATED';
        final isCompleted = event.type == 'TASK_COMPLETED';

        Color nodeColor = SyncOpsTheme.primaryCyan;
        IconData nodeIcon = Icons.radio_button_checked;

        if (isRecovery) {
          nodeColor = SyncOpsTheme.criticalRed;
          nodeIcon = Icons.autorenew_rounded;
        } else if (isCompleted) {
          nodeColor = SyncOpsTheme.successGreen;
          nodeIcon = Icons.check_circle_outline;
        } else if (isCreated) {
          nodeColor = SyncOpsTheme.accentBlue;
          nodeIcon = Icons.add_alert_rounded;
        } else if (event.type == 'TASK_ACCEPTED') {
          nodeColor = SyncOpsTheme.primaryCyan;
          nodeIcon = Icons.person_pin_circle_rounded;
        } else if (event.type == 'TASK_EN_ROUTE') {
          nodeColor = SyncOpsTheme.accentBlue;
          nodeIcon = Icons.directions_run_rounded;
        } else if (event.type == 'TASK_ARRIVED') {
          nodeColor = SyncOpsTheme.purpleNeon;
          nodeIcon = Icons.location_on_rounded;
        }

        final timeStr = _formatTimestamp(event.timestamp);

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline vertical line & node
              SizedBox(
                width: 32,
                child: Column(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: nodeColor.withOpacity(0.18),
                        shape: BoxShape.circle,
                        border: Border.all(color: nodeColor, width: 1.5),
                      ),
                      child: Icon(nodeIcon, size: 13, color: nodeColor),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: SyncOpsTheme.borderBright.withOpacity(0.4),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Event content card
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isRecovery
                        ? SyncOpsTheme.criticalRed.withOpacity(0.08)
                        : SyncOpsTheme.surfaceElevated.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isRecovery
                          ? SyncOpsTheme.criticalRed.withOpacity(0.4)
                          : SyncOpsTheme.border.withOpacity(0.5),
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
                              event.type.replaceAll('_', ' '),
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: nodeColor,
                              ),
                            ),
                          ),
                          Text(
                            timeStr,
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 10,
                              color: SyncOpsTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        event.message,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: isRecovery
                              ? Colors.white
                              : SyncOpsTheme.textPrimary,
                          fontWeight: isRecovery
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                      if (event.actorName != null) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.badge_outlined,
                              size: 12,
                              color: SyncOpsTheme.textMuted,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              event.actorName!,
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 10,
                                color: SyncOpsTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTimestamp(DateTime dt) {
    final local = dt.toLocal();
    final hour = local.hour.toString().padLeft(2, '0');
    final min = local.minute.toString().padLeft(2, '0');
    final sec = local.second.toString().padLeft(2, '0');
    return '$hour:$min:$sec';
  }
}
