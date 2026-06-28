import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flowday/screens/shell_screen.dart';
import 'package:flowday/screens/dashboard_screen.dart';
import 'package:flowday/screens/reminders_screen.dart';
import 'package:flowday/screens/workout_screen.dart';
import 'package:flowday/screens/learning_screen.dart';
import 'package:flowday/screens/settings_screen.dart';
import 'package:flowday/screens/auth_screen.dart';
import 'package:flowday/providers/auth_provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  RouterNotifier(this._ref) {
    _ref.listen(authStateProvider, (_, __) {
      notifyListeners();
    });
  }
}

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider);
  final authStateAsync = ref.watch(authStateProvider);
  final user = authStateAsync.valueOrNull;

  return GoRouter(
    initialLocation: '/dashboard',
    navigatorKey: _rootNavigatorKey,
    refreshListenable: notifier,
    redirect: (context, state) {
      if (authStateAsync.isLoading) return null;

      final loggedIn = user != null;
      final loggingIn = state.matchedLocation == '/auth';

      if (!loggedIn && !loggingIn) {
        return '/auth';
      }
      if (loggedIn && loggingIn) {
        return '/dashboard';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/reminders',
                builder: (context, state) => const RemindersScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/workout',
                builder: (context, state) => const WorkoutScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/learning',
                builder: (context, state) => const LearningScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
