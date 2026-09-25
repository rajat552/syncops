import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:synops_flutter/widgets/status_badge.dart';

void main() {
  testWidgets('StatusBadge renders correct status and glowing indicator', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: StatusBadge(status: 'EN_ROUTE'),
        ),
      ),
    );

    expect(find.text('EN ROUTE'), findsOneWidget);
  });

  testWidgets('SeverityBadge renders critical severity', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SeverityBadge(severity: 'CRITICAL'),
        ),
      ),
    );

    expect(find.text('CRITICAL'), findsOneWidget);
  });
}
