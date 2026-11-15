import 'package:go_router/go_router.dart';

import 'package:it_tools_app/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:it_tools_app/features/onboarding/presentation/pages/onboarding_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
    ],
  );
}
