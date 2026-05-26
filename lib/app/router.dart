import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../features/auth/providers/auth_provider.dart';
import '../features/auth/screens/splash_screen.dart';
import '../features/auth/screens/onboarding_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/auth/screens/due_date_setup_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/baby_growth/screens/baby_growth_screen.dart';
import '../features/health/screens/health_screen.dart';
import '../features/nutrition/screens/nutrition_screen.dart';
import '../features/yoga/screens/yoga_screen.dart';
import '../features/reminders/screens/reminders_screen.dart';
import '../features/emotional/screens/emotional_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../shared/widgets/main_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter buildRouter(BuildContext context) {
  final authProvider = context.read<AuthProvider>();

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    refreshListenable: authProvider,
    redirect: (context, state) {
      final auth = context.read<AuthProvider>();
      final isAuth = auth.isAuthenticated;
      final isSetup = auth.isProfileSetup;
      final loc = state.matchedLocation;

      // Splash / Onboarding — always accessible
      if (loc == '/splash' || loc == '/onboarding') return null;

      // Auth screens
      if (loc == '/login' || loc == '/signup') {
        return isAuth ? (isSetup ? '/home' : '/setup') : null;
      }

      // Setup screen
      if (loc == '/setup') {
        return isAuth ? null : '/login';
      }

      // Protected routes
      if (!isAuth) return '/login';
      if (!isSetup) return '/setup';
      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/signup', builder: (_, __) => const SignupScreen()),
      GoRoute(path: '/setup', builder: (_, __) => const DueDateSetupScreen()),

      // Main shell with bottom nav
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
          GoRoute(path: '/baby', builder: (_, __) => const BabyGrowthScreen()),
          GoRoute(path: '/health', builder: (_, __) => const HealthScreen()),
          GoRoute(path: '/nutrition', builder: (_, __) => const NutritionScreen()),
          GoRoute(path: '/yoga', builder: (_, __) => const YogaScreen()),
          GoRoute(path: '/reminders', builder: (_, __) => const RemindersScreen()),
          GoRoute(path: '/emotional', builder: (_, __) => const EmotionalScreen()),
          GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
        ],
      ),
    ],
  );
}
