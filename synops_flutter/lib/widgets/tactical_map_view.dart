import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synops_client/synops_client.dart';
import '../core/theme.dart';

class TacticalMapView extends StatefulWidget {
  final Task task;
  final LocationPing? lastPing;

  const TacticalMapView({
    super.key,
    required this.task,
    this.lastPing,
  });

  @override
  State<TacticalMapView> createState() => _TacticalMapViewState();
}

class _TacticalMapViewState extends State<TacticalMapView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        color: const Color(0xFF070B12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: SyncOpsTheme.border, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: _TacticalRadarPainter(
                  pulseValue: _pulseController.value,
                  task: widget.task,
                  lastPing: widget.lastPing,
                ),
              );
            },
          ),
          // Tactical Header Overlay
          Positioned(
            top: 10,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A).withOpacity(0.85),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: SyncOpsTheme.border, width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: SyncOpsTheme.primaryCyan,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'TACTICAL RADAR 2.5KM GRID',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: SyncOpsTheme.primaryCyan,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Coordinate telemetry readouts
          Positioned(
            bottom: 10,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'TARGET: ${widget.task.latitude.toStringAsFixed(4)}°N, ${widget.task.longitude.toStringAsFixed(4)}°W',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 9,
                      color: SyncOpsTheme.textSecondary,
                    ),
                  ),
                ),
                if (widget.lastPing != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'UNIT: ${widget.lastPing!.latitude.toStringAsFixed(4)}°N, ${widget.lastPing!.longitude.toStringAsFixed(4)}°W',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 9,
                        color: SyncOpsTheme.successGreen,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TacticalRadarPainter extends CustomPainter {
  final double pulseValue;
  final Task task;
  final LocationPing? lastPing;

  _TacticalRadarPainter({
    required this.pulseValue,
    required this.task,
    required this.lastPing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = min(size.width, size.height) * 0.45;

    final gridPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final ringPaint = Paint()
      ..color = const Color(0xFF334155).withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw range rings
    for (int i = 1; i <= 3; i++) {
      final r = maxRadius * (i / 3);
      canvas.drawCircle(center, r, ringPaint);
    }

    // Draw crosshair axes
    canvas.drawLine(
      Offset(center.dx - maxRadius, center.dy),
      Offset(center.dx + maxRadius, center.dy),
      gridPaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - maxRadius),
      Offset(center.dx, center.dy + maxRadius),
      gridPaint,
    );

    // Rotating sweep beam effect
    final sweepAngle = pulseValue * 2 * pi;
    final sweepPaint = Paint()
      ..shader = SweepGradient(
        center: Alignment.center,
        startAngle: 0,
        endAngle: pi / 2,
        colors: [
          SyncOpsTheme.primaryCyan.withOpacity(0.18),
          Colors.transparent,
        ],
        transform: GradientRotation(sweepAngle),
      ).createShader(Rect.fromCircle(center: center, radius: maxRadius));

    canvas.drawCircle(center, maxRadius, sweepPaint);

    // Target incident marker (at center)
    final targetColor = SyncOpsTheme.getSeverityColor(task.severity);
    final pulseRadius = 12.0 + (pulseValue * 14.0);
    final pulseAlpha = (1.0 - pulseValue).clamp(0.0, 1.0);

    final pulsePaint = Paint()
      ..color = targetColor.withOpacity(pulseAlpha * 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, pulseRadius, pulsePaint);

    final targetPaint = Paint()
      ..color = targetColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 5.0, targetPaint);

    // Draw responder position if available
    if (lastPing != null) {
      // Calculate relative offset based on coordinate differences
      final dLat = lastPing!.latitude - task.latitude;
      final dLng = lastPing!.longitude - task.longitude;

      // Scale to view pixels (clamped to maxRadius)
      final scale = maxRadius * 30.0;
      double dx = center.dx + (dLng * scale);
      double dy = center.dy - (dLat * scale);

      // Clamp inside circular bounds
      final dist = sqrt(pow(dx - center.dx, 2) + pow(dy - center.dy, 2));
      if (dist > maxRadius * 0.9) {
        final ratio = (maxRadius * 0.9) / dist;
        dx = center.dx + (dx - center.dx) * ratio;
        dy = center.dy + (dy - center.dy) * ratio;
      }

      final unitOffset = Offset(dx, dy);

      // Trail line between unit and incident target
      final linePaint = Paint()
        ..color = SyncOpsTheme.successGreen.withOpacity(0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(unitOffset, center, linePaint);

      // Unit pulsing icon
      final unitPaint = Paint()
        ..color = SyncOpsTheme.successGreen
        ..style = PaintingStyle.fill;
      canvas.drawCircle(unitOffset, 6.0, unitPaint);

      final unitRing = Paint()
        ..color = SyncOpsTheme.successGreen.withOpacity(0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      canvas.drawCircle(unitOffset, 10.0, unitRing);
    }
  }

  @override
  bool shouldRepaint(covariant _TacticalRadarPainter oldDelegate) {
    return oldDelegate.pulseValue != pulseValue ||
        oldDelegate.task != task ||
        oldDelegate.lastPing != lastPing;
  }
}
