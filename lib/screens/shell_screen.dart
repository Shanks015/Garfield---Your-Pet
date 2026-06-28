import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flowday/providers/preferences_provider.dart';
import 'package:flowday/services/notification_service.dart';

class ShellScreen extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const ShellScreen({
    required this.navigationShell,
    super.key,
  });

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to preferences changes to automatically reschedule notifications
    ref.listen(userPreferencesProvider, (previous, next) {
      final prefs = next.valueOrNull;
      if (prefs != null) {
        final ns = ref.read(notificationServiceProvider);
        ns.cancelAll().then((_) {
          ns.scheduleWaterReminder(prefs.waterIntervalMin);
          ns.scheduleBreakReminder(prefs.breakIntervalMin);
          ns.scheduleWalkReminder(prefs.walkIntervalMin);
          ns.scheduleExerciseReminder(prefs.exerciseReminderHour);
        });
      } else {
        // Seed default preferences if none exist
        ref.read(preferencesActionsProvider).seedDefaultPreferences();
      }
    });

    // Also call seed check immediately if state is empty
    final prefsAsync = ref.watch(userPreferencesProvider);
    if (prefsAsync.hasValue && prefsAsync.value == null) {
      Future.microtask(() {
        ref.read(preferencesActionsProvider).seedDefaultPreferences();
      });
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth <= 700;
        
        if (isMobile) {
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) => _onTap(context, index),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                  icon: Icon(Icons.notifications_outlined),
                  selectedIcon: Icon(Icons.notifications),
                  label: 'Reminders',
                ),
                NavigationDestination(
                  icon: Icon(Icons.fitness_center_outlined),
                  selectedIcon: Icon(Icons.fitness_center),
                  label: 'Workout',
                ),
                NavigationDestination(
                  icon: Icon(Icons.school_outlined),
                  selectedIcon: Icon(Icons.school),
                  label: 'Learning',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  extended: constraints.maxWidth > 900,
                  selectedIndex: navigationShell.currentIndex,
                  onDestinationSelected: (index) => _onTap(context, index),
                  labelType: constraints.maxWidth > 900 
                      ? NavigationRailLabelType.none 
                      : NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.dashboard_outlined),
                      selectedIcon: Icon(Icons.dashboard),
                      label: Text('Dashboard'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.notifications_outlined),
                      selectedIcon: Icon(Icons.notifications),
                      label: Text('Reminders'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.fitness_center_outlined),
                      selectedIcon: Icon(Icons.fitness_center),
                      label: Text('Workout'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.school_outlined),
                      selectedIcon: Icon(Icons.school),
                      label: Text('Learning'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      label: Text('Settings'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1, color: Color(0xFF334155)),
                Expanded(
                  child: navigationShell,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
