import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/auth_status_provider.dart';

class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String login = '/login';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orders = '/orders';
  static const String favorites = '/favorites';
  static const String editProfile = '/profile/edit';
  static const String ratings = '/ratings';

  /// قائمة المسارات المحمية التي تتطلب تسجيل دخول
  static const Set<String> protectedRoutes = {
    checkout,
    orders,
    favorites,
    editProfile,
    ratings,
  };

  static bool isProtected(String location) {
    return protectedRoutes.any(
      (route) => location == route || location.startsWith('$route/'),
    );
  }
}

GoRouter createAppRouter(AuthStatusNotifier authNotifier) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    refreshListenable: authNotifier,
    redirect: (BuildContext context, GoRouterState state) {
      final currentPath = state.uri.path;
      final isGuest = authNotifier.isGuest;
      final isGoingToLogin = currentPath == AppRoutes.login;

      // 1. إذا كان زائراً ويحاول دخول مسار محمي -> تحويل لصفحة الدخول مع حفظ المسار الأصلي
      if (isGuest && AppRoutes.isProtected(currentPath)) {
        final fromLocation = Uri.encodeComponent(state.uri.toString());
        return '${AppRoutes.login}?from=$fromLocation';
      }

      // 2. إذا سجل دخوله بنجاح وهو واقف في صفحة الدخول -> إرجاعه للمسار المحفوظ في from أو للرئيسية
      if (!isGuest && isGoingToLogin) {
        final fromParam = state.uri.queryParameters['from'];
        if (fromParam != null && fromParam.isNotEmpty) {
          return Uri.decodeComponent(fromParam);
        }
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('الصفحة الرئيسية'))),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('تسجيل الدخول'))),
      ),
      GoRoute(
        path: AppRoutes.cart,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('سلة المشتريات'))),
      ),
      GoRoute(
        path: AppRoutes.checkout,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('إتمام الطلب'))),
      ),
      GoRoute(
        path: AppRoutes.orders,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('طلباتي'))),
      ),
      GoRoute(
        path: AppRoutes.favorites,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('المفضلة'))),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('تعديل الحساب'))),
      ),
      GoRoute(
        path: AppRoutes.ratings,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('التقييم'))),
      ),
    ],
  );
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authStatusProvider);
  return createAppRouter(authNotifier);
});
