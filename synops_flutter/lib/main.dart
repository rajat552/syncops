import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'client.dart';
import 'core/constants.dart';
import 'core/theme.dart';
import 'screens/coordinator_screen.dart';
import 'screens/demo_controller_sheet.dart';
import 'screens/responder_screen.dart';
import 'services/syncops_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  await SyncOpsService.instance.initialize();
  runApp(const SyncOpsApp());
}

class SyncOpsApp extends StatelessWidget {
  const SyncOpsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SyncOps — Emergency Operations',
      debugShowCheckedModeBanner: false,
      theme: SyncOpsTheme.themeData,
      home: const SyncOpsShell(),
    );
  }
}

class SyncOpsShell extends StatefulWidget {
  const SyncOpsShell({super.key});

  @override
  State<SyncOpsShell> createState() => _SyncOpsShellState();
}

class _SyncOpsShellState extends State<SyncOpsShell> {
  final _service = SyncOpsService.instance;
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _service,
      builder: (context, _) {
        return Scaffold(
          appBar: _buildTopAppBar(context),
          body: IndexedStack(
            index: _currentTabIndex,
            children: const [
              CoordinatorScreen(),
              ResponderScreen(),
              _GlobalAuditFeedScreen(),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: SyncOpsTheme.border, width: 1),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: _currentTabIndex,
              onTap: (index) => setState(() => _currentTabIndex = index),
              backgroundColor: SyncOpsTheme.surface,
              selectedItemColor: SyncOpsTheme.primaryCyan,
              unselectedItemColor: SyncOpsTheme.textMuted,
              selectedLabelStyle: GoogleFonts.jetBrainsMono(
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: GoogleFonts.jetBrainsMono(fontSize: 11),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_rounded),
                  label: 'COORDINATOR',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shield_outlined),
                  label: 'RESPONDER TERMINAL',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history_edu_rounded),
                  label: 'AUDIT LOG',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildTopAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: SyncOpsTheme.criticalRed,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'SYNCOPS',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Emergency Operations Center',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _service.isConnected
                            ? SyncOpsTheme.successGreen
                            : SyncOpsTheme.criticalRed,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _service.isConnected
                          ? 'SERVERPOD 4 • LIVE RPC & STREAMS'
                          : 'CONNECTING TO SERVERPOD...',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 9,
                        color: _service.isConnected
                            ? SyncOpsTheme.successGreen
                            : SyncOpsTheme.criticalRed,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        // Role Switcher Dropdown
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: SyncOpsTheme.surfaceElevated,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: SyncOpsTheme.border, width: 1),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<SyncOpsRole>(
              value: _service.currentRole,
              dropdownColor: SyncOpsTheme.surfaceElevated,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: Colors.white,
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: SyncOpsTheme.primaryCyan,
                size: 18,
              ),
              onChanged: (role) {
                if (role != null) {
                  _service.setRole(role);
                  if (role.roleType == 'RESPONDER' && _currentTabIndex == 0) {
                    setState(() => _currentTabIndex = 1);
                  } else if (role.roleType == 'COORDINATOR' &&
                      _currentTabIndex == 1) {
                    setState(() => _currentTabIndex = 0);
                  }
                }
              },
              items: SyncOpsConstants.availableRoles.map((role) {
                return DropdownMenuItem<SyncOpsRole>(
                  value: role,
                  child: Row(
                    children: [
                      Icon(
                        role.roleType == 'COORDINATOR'
                            ? Icons.admin_panel_settings_rounded
                            : Icons.badge_outlined,
                        size: 14,
                        color: SyncOpsTheme.primaryCyan,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        role.name,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Quick Judge Demo Controller Button
        Padding(
          padding: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
          child: ElevatedButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const DemoControllerSheet(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: SyncOpsTheme.primaryCyan,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            icon: const Icon(Icons.play_arrow_rounded, size: 16),
            label: Text(
              'HERO DEMO',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GlobalAuditFeedScreen extends StatelessWidget {
  const _GlobalAuditFeedScreen();

  @override
  Widget build(BuildContext context) {
    final service = SyncOpsService.instance;

    return AnimatedBuilder(
      animation: service,
      builder: (context, _) {
        final logs = service.liveAuditLog;

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'IMMUTABLE SYSTEM AUDIT TRAIL',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: SyncOpsTheme.textMuted,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          'Real-Time Serverpod Event Stream',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: SyncOpsTheme.primaryCyan.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'LIVE STREAM ACTIVE',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: SyncOpsTheme.primaryCyan,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: logs.isEmpty
                      ? Center(
                          child: Text(
                            'Listening for real-time Serverpod audit events...',
                            style: GoogleFonts.plusJakartaSans(
                              color: SyncOpsTheme.textMuted,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: logs.length,
                          itemBuilder: (context, index) {
                            final event = logs[index];
                            final isRecovery =
                                event.type == 'TIMEOUT_AUTO_RECOVERED';

                            return Card(
                              color: isRecovery
                                  ? SyncOpsTheme.criticalRed.withOpacity(0.12)
                                  : SyncOpsTheme.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                  color: isRecovery
                                      ? SyncOpsTheme.criticalRed.withOpacity(
                                          0.5,
                                        )
                                      : SyncOpsTheme.border,
                                ),
                              ),
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: Icon(
                                  isRecovery
                                      ? Icons.autorenew_rounded
                                      : Icons.info_outline_rounded,
                                  color: isRecovery
                                      ? SyncOpsTheme.criticalRed
                                      : SyncOpsTheme.primaryCyan,
                                ),
                                title: Text(
                                  event.message,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    fontWeight: isRecovery
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  'Task #${event.taskId} • ${event.actorName ?? 'System'} • ${event.timestamp.toLocal().toIso8601String().substring(11, 19)}',
                                  style: GoogleFonts.jetBrainsMono(
                                    fontSize: 10,
                                    color: SyncOpsTheme.textMuted,
                                  ),
                                ),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: SyncOpsTheme.surfaceElevated,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    event.type,
                                    style: GoogleFonts.jetBrainsMono(
                                      fontSize: 9,
                                      color: isRecovery
                                          ? SyncOpsTheme.criticalRed
                                          : SyncOpsTheme.textSecondary,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
