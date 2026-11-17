import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:it_tools_app/app/app.dart';

void mainCommon() {
  // التأكد من تهيئة بيئة الفلاتر قبل تشغيل التطبيق
  WidgetsFlutterBinding.ensureInitialized();

  // تثبيت الاتجاه العمودي فقط للشاشات (Portrait Mode)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const ITToolsApp());
  });
}
