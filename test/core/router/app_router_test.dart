import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:it_tools_app/core/auth/auth_status_provider.dart';
import 'package:it_tools_app/core/router/app_router.dart';
import 'package:it_tools_app/core/storage/token_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockTokenStorage extends Mock implements TokenStorage {}

void main() {
  late MockTokenStorage mockStorage;
  late AuthStatusNotifier authNotifier;

  setUp(() {
    mockStorage = MockTokenStorage();
    when(() => mockStorage.readAccessToken()).thenAnswer((_) async => null);
    when(
      () => mockStorage.saveTokens(
        accessToken: any(named: 'accessToken'),
        refreshToken: any(named: 'refreshToken'),
      ),
    ).thenAnswer((_) async {});
    when(() => mockStorage.clear()).thenAnswer((_) async {});

    authNotifier = AuthStatusNotifier(mockStorage);
  });

  group('AppRouter Guest Protection Tests', () {
    testWidgets('allows guest to visit public routes like /cart', (
      tester,
    ) async {
      final router = createAppRouter(authNotifier);

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      router.go(AppRoutes.cart);
      await tester.pumpAndSettle();

      expect(find.text('سلة المشتريات'), findsOneWidget);
    });

    testWidgets(
      'redirects guest to /login with from param when accessing protected route and returns after login',
      (tester) async {
        final router = createAppRouter(authNotifier);

        await tester.pumpWidget(MaterialApp.router(routerConfig: router));
        await tester.pumpAndSettle();

        // محاولة الزائر فتح صفحة إتمام الطلب المحمية
        router.go(AppRoutes.checkout);
        await tester.pumpAndSettle();

        // التحقق من تحويله لصفحة تسجيل الدخول مع حفظ المسار الأصلي في from
        expect(find.text('تسجيل الدخول'), findsOneWidget);
        expect(
          router.routerDelegate.currentConfiguration.uri.toString(),
          '/login?from=%2Fcheckout',
        );

        // محاكاة تسجيل الدخول بنجاح
        await authNotifier.setAuthenticated(
          accessToken: 'valid_token',
          refreshToken: 'valid_refresh_token',
        );
        await tester.pumpAndSettle();

        // التحقق من إرجاعه تلقائياً إلى صفحة إتمام الطلب
        expect(find.text('إتمام الطلب'), findsOneWidget);
      },
    );
  });
}
