// This is a basic Flutter widget test.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:it_tools_app/app/app.dart'; // استدعاء ملف الـ app

void main() {
  testWidgets('IT Tools App smoke test', (WidgetTester tester) async {
    // بناء التطبيق والتحقق من ظهور شاشة الـ Splash والشعار أو النص الافتتاحي
    await tester.pumpWidget(const ITToolsApp());

    // التحقق من وجود اسم التطبيق "المحيط" في شاشة الـ Splash
    expect(find.text('المحيط'), findsOneWidget);
  });
}
