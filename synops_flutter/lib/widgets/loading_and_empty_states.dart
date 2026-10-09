import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';

/// Animated shimmer placeholder for loading states.
/// Mimics the shape of a task list card.
class TaskCardShimmer extends StatefulWidget {
  const TaskCardShimmer({super.key});

  @override
  State<TaskCardShimmer> createState() => _TaskCardShimmerState();
}

class _TaskCardShimmerState extends State<TaskCardShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _shimmer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _shimmer = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmer,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: SyncOpsTheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: SyncOpsTheme.border, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _ShimmerBox(width: 60, height: 20, shimmer: _shimmer.value),
                  const SizedBox(width: 8),
                  _ShimmerBox(width: 40, height: 20, shimmer: _shimmer.value),
                  const Spacer(),
                  _ShimmerBox(width: 70, height: 18, shimmer: _shimmer.value),
                ],
              ),
              const SizedBox(height: 10),
              _ShimmerBox(
                width: double.infinity,
                height: 14,
                shimmer: _shimmer.value,
              ),
              const SizedBox(height: 6),
              _ShimmerBox(width: 220, height: 12, shimmer: _shimmer.value),
              const SizedBox(height: 10),
              Row(
                children: [
                  _ShimmerBox(width: 90, height: 14, shimmer: _shimmer.value),
                  const Spacer(),
                  _ShimmerBox(width: 60, height: 14, shimmer: _shimmer.value),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double shimmer;

  const _ShimmerBox({
    required this.width,
    required this.height,
    required this.shimmer,
  });

  @override
  Widget build(BuildContext context) {
    final base = SyncOpsTheme.border.withOpacity(0.5);
    final highlight = SyncOpsTheme.borderBright.withOpacity(0.9);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: LinearGradient(
          begin: Alignment(-1 + shimmer * 2, 0),
          end: Alignment(shimmer * 2, 0),
          colors: [base, highlight, base],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}

/// Shown when the task list is empty for a given filter.
class EmptyTaskState extends StatelessWidget {
  final String filter;
  final VoidCallback? onCreateIncident;

  const EmptyTaskState({
    super.key,
    required this.filter,
    this.onCreateIncident,
  });

  @override
  Widget build(BuildContext context) {
    final isPending = filter == 'ALL' || filter == 'ACTIVE';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: SyncOpsTheme.surfaceElevated,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPending
                    ? Icons.check_circle_outline_rounded
                    : Icons.filter_list_off_rounded,
                size: 40,
                color: SyncOpsTheme.primaryOrange,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isPending ? 'ALL CLEAR' : 'NO MATCHING INCIDENTS',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: SyncOpsTheme.textMuted,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              isPending
                  ? 'No active incidents in the operations queue.\nDispatch a new emergency to begin.'
                  : 'No incidents match the "$filter" filter.\nTry a different filter or create a new incident.',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 13,
                color: SyncOpsTheme.textSecondary,
              ),
            ),
            if (isPending && onCreateIncident != null) ...[
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: onCreateIncident,
                style: ElevatedButton.styleFrom(
                  backgroundColor: SyncOpsTheme.criticalRed,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                icon: const Icon(Icons.add_alert_rounded, size: 16),
                label: Text(
                  'DISPATCH FIRST INCIDENT',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Empty state for the Responder Terminal when no tasks are available.
class EmptyResponderState extends StatelessWidget {
  const EmptyResponderState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: SyncOpsTheme.surfaceElevated,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shield_outlined,
                size: 44,
                color: SyncOpsTheme.accentTeal,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'STANDBY — AWAITING DISPATCH',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: SyncOpsTheme.textMuted,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'No open incidents in the dispatch queue.\nThe coordinator will notify you when a mission is assigned.',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: 13,
                color: SyncOpsTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: SyncOpsTheme.accentTeal.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: SyncOpsTheme.accentTeal.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: SyncOpsTheme.successGreen,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'LIVE STREAM MONITORING ACTIVE',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: SyncOpsTheme.accentTeal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
