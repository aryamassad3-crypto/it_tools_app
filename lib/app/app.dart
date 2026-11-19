import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:it_tools_app/core/config/app_router.dart';
import 'package:it_tools_app/core/theme/app_theme.dart';

class ITToolsApp extends StatelessWidget {
  const ITToolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'المحيط - إكسسوارات الكمبيوتر',
      debugShowCheckedModeBanner: false,

      // ربط الثيم
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,

      // دعم اللغة العربية (RTL)
      locale: const Locale('ar', 'AE'),
      supportedLocales: const [Locale('ar', 'AE')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // ربط الـ GoRouter لإدارة التنقل
      routerConfig: AppRouter.router,
    );
  }
}
