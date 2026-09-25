import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';

class CountdownTimerView extends StatefulWidget {
  final DateTime? expiresAt;
  final VoidCallback? onExpired;

  const CountdownTimerView({
    super.key,
    required this.expiresAt,
    this.onExpired,
  });

  @override
  State<CountdownTimerView> createState() => _CountdownTimerViewState();
}

class _CountdownTimerViewState extends State<CountdownTimerView> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateRemaining();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateRemaining(),
    );
  }

  @override
  void didUpdateWidget(covariant CountdownTimerView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expiresAt != widget.expiresAt) {
      _updateRemaining();
    }
  }

  void _updateRemaining() {
    if (widget.expiresAt == null) {
      setState(() => _remaining = Duration.zero);
      return;
    }
    final now = DateTime.now().toUtc();
    final diff = widget.expiresAt!.difference(now);
    if (diff.isNegative) {
      setState(() => _remaining = Duration.zero);
      widget.onExpired?.call();
    } else {
      setState(() => _remaining = diff);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.expiresAt == null) {
      return const SizedBox.shrink();
    }

    final totalSeconds = _remaining.inSeconds;
    final minutes = (_remaining.inMinutes).toString().padLeft(2, '0');
    final seconds = (_remaining.inSeconds % 60).toString().padLeft(2, '0');

    final isUrgent = totalSeconds < 15;
    final timerColor = isUrgent
        ? SyncOpsTheme.criticalRed
        : SyncOpsTheme.warningAmber;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: timerColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: timerColor.withOpacity(0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUrgent ? Icons.warning_amber_rounded : Icons.timer_outlined,
            color: timerColor,
            size: 16,
          ),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'AUTO-RECOVERY IN',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: timerColor.withOpacity(0.8),
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                '$minutes:$seconds',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: timerColor,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
