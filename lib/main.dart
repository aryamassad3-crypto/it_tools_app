import 'package:flutter/material.dart';

import 'features/auth/presentation/pages/login_page.dart';

void main() {
  runApp(const ITToolsApp());
}

class ITToolsApp extends StatelessWidget {
  const ITToolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IT Tools App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo',
        primaryColor: const Color(0xFF0578B7),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0578B7),
          primary: const Color(0xFF0578B7),
        ),
        useMaterial3: true,
      ),
      // جعل شاشة تسجيل الدخول هي البداية مؤقتاً للتجربة والتصميم
      home: const LoginPage(),
    );
  }
}
