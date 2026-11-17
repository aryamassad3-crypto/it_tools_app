import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:it_tools_app/main.dart';

void main() {
  testWidgets('App launches and displays the login page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ITToolsApp());

    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.textContaining('noor@devmmnd.com'), findsOneWidget);
  });
}
