import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../storage/token_storage.dart';
import 'auth_interceptor.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) {
  return TokenStorage();
}

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final baseOptions = BaseOptions(
    baseUrl: AppConfig.apiBaseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 30),
    headers: {'Accept': 'application/json', 'Accept-Language': 'ar'},
  );

  final client = Dio(baseOptions);
  final refreshDio = Dio(baseOptions);
  final storage = ref.watch(tokenStorageProvider);

  // إضافة حارس المصادقة
  client.interceptors.add(
    AuthInterceptor(tokenStorage: storage, refreshDio: refreshDio),
  );

  if (kDebugMode) {
    client.interceptors.add(
      LogInterceptor(
        requestHeader: false, // منع طباعة التوكن في السجلات
        responseHeader: false,
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  return client;
}
