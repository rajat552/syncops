# SyncOps — Flutter Operations Center Frontend

The Flutter frontend for **SyncOps**, a real-time emergency task coordination platform featuring automated inactivity recovery powered by Serverpod 4.

For the complete project specification, backend architecture, and hackathon demo guide, please refer to the root [README.md](../../README.md).

---

## 🖥️ Frontend Structure

- **`lib/main.dart`**: Entrypoint, navigation shell, and role selector (Dispatcher Maya, Responder Alex, Responder Bailey).
- **`lib/core/theme.dart`**: Military-grade dark tactical theme, color tokens, and Google Fonts typography.
- **`lib/core/constants.dart`**: Demo identities and emergency presets.
- **`lib/services/syncops_service.dart`**: Client service managing Serverpod RPC calls, WebSocket event streams, and GPS telemetry simulations.
- **`lib/screens/coordinator_screen.dart`**: Dispatcher Command Center with live KPI metric cards, incident inspector, and quick dispatch dialog.
- **`lib/screens/responder_screen.dart`**: Field responder terminal with one-touch mission advancement (`START RESPONSE` → `ARRIVED` → `IN PROGRESS` → `COMPLETED`) and telemetry broadcasting.
- **`lib/screens/demo_controller_sheet.dart`**: Interactive 7-step presentation controller built specifically for hackathon judges.
- **`lib/widgets/tactical_map_view.dart`**: Self-contained Canvas radar painter with concentric range rings, rotating sweep beam, and real-time responder marker.
- **`lib/widgets/countdown_timer_view.dart`**: Live ticker counting down until Serverpod's auto-recovery future call triggers.
- **`lib/widgets/incident_timeline_widget.dart`**: Immutable visual audit trail highlighting automated recovery events.

---

## 🚀 Running the Flutter App

From the project root:
```bash
serverpod start
```

Or specifically run the Flutter app:
```bash
cd synops_flutter
flutter run
```

Run tests:
```bash
flutter test
```
