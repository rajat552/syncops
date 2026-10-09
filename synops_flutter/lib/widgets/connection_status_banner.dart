import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../services/syncops_service.dart';

/// Displays a dismissible animated banner at the top of the screen
/// when the Serverpod connection is lost or a critical RPC error occurs.
///
/// Usage: Wrap any Scaffold body with this widget or include it in a Column
/// above the main content.
class ConnectionStatusBanner extends StatelessWidget {
  const ConnectionStatusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final service = SyncOpsService.instance;
    return AnimatedBuilder(
      animation: service,
      builder: (context, _) {
        if (service.isConnected) return const SizedBox.shrink();
        return _OfflineBanner(errorMessage: service.lastError);
      },
    );
  }
}

class _OfflineBanner extends StatefulWidget {
  final String? errorMessage;
  const _OfflineBanner({this.errorMessage});

  @override
  State<_OfflineBanner> createState() => _OfflineBannerState();
}

class _OfflineBannerState extends State<_OfflineBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    )..forward();
    _heightFactor = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _heightFactor,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: SyncOpsTheme.criticalRed.withOpacity(0.12),
          border: Border(
            bottom: BorderSide(
              color: SyncOpsTheme.criticalRed.withOpacity(0.5),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Blinking indicator dot
            _PulsingDot(),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'SERVERPOD CONNECTION LOST',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: SyncOpsTheme.criticalRed,
                      letterSpacing: 0.6,
                    ),
                  ),
                  if (widget.errorMessage != null)
                    Text(
                      widget.errorMessage!,
                      style: GoogleFonts.nunito(
                        fontSize: 11,
                        color: SyncOpsTheme.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Retry button
            TextButton.icon(
              onPressed: () => SyncOpsService.instance.initialize(),
              style: TextButton.styleFrom(
                foregroundColor: SyncOpsTheme.criticalRed,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: BorderSide(
                    color: SyncOpsTheme.criticalRed.withOpacity(0.4),
                  ),
                ),
              ),
              icon: const Icon(Icons.refresh_rounded, size: 14),
              label: Text(
                'RETRY',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: SyncOpsTheme.criticalRed.withOpacity(
            0.4 + _pulse.value * 0.6,
          ),
        ),
      ),
    );
  }
}
