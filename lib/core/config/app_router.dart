import 'package:go_router/go_router.dart';
import 'package:it_tools_app/features/categories/presentation/pages/categories_page.dart';
import 'package:it_tools_app/features/categories/presentation/pages/product_list_page.dart';
import 'package:it_tools_app/features/home/presentation/pages/home_screen.dart';

import 'package:it_tools_app/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:it_tools_app/features/onboarding/presentation/pages/onboarding_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String home = '/home';
  static const String categories = '/categories';
  static const String productList = '/product-list';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/home', // أو جعله المسار الافتتاحي '/' حسب هيكلة تطبيقكم
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/categories',
        name: 'categories',
        builder: (context, state) => const CategoriesPage(),
      ),
      GoRoute(
        path: productList,
        name: 'product-list',
        builder: (context, state) {
          final categoryName = state.extra as String? ?? 'ماوس';
          return ProductListPage(categoryName: categoryName);
        },
      ),
    ],
  );
}
