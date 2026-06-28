import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flowday/theme/app_theme.dart';
import 'package:flowday/providers/health_provider.dart';
import 'package:flowday/providers/preferences_provider.dart';

class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final healthLogs = ref.watch(todayHealthLogsProvider).valueOrNull ?? [];
    final prefs = ref.watch(userPreferencesProvider).valueOrNull;
    final healthActions = ref.read(healthActionsProvider);
    final prefActions = ref.read(preferencesActionsProvider);

    // Calculate metrics
    final waterLogsCount = healthLogs.where((l) => l.logType == 'water').length;
    final waterVolumeMl = waterLogsCount * 250;
    final waterGoalMl = 2500;
    final waterProgress = (waterVolumeMl / waterGoalMl).clamp(0.0, 1.0);

    final breakLogsCount = healthLogs.where((l) => l.logType == 'break').length;
    final walkLogsCount = healthLogs.where((l) => l.logType == 'walk').length;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Wellness & Reminders',
                style: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
              background: Container(
                color: AppTheme.surfaceDark,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Water Tracker Card
                _buildWaterCard(context, waterVolumeMl, waterGoalMl, waterProgress, () {
                  healthActions.logMetric('water', notes: 'Logged 250ml water');
                }, () {
                  healthActions.logMetric('water', notes: 'Logged 500ml water');
                }),
                const SizedBox(height: 24),

                // Break & Walk Stats Row
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        context: context,
                        title: 'Eye Breaks',
                        subtitle: 'Target: Every ${prefs?.breakIntervalMin ?? 60}m',
                        count: breakLogsCount,
                        unit: 'completed',
                        icon: Icons.remove_red_eye_outlined,
                        color: AppTheme.accentBlue,
                        onTap: () {
                          healthActions.logMetric('break', notes: 'Logged 5m eye break');
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildMetricCard(
                        context: context,
                        title: 'Active Walks',
                        subtitle: 'Target: Every ${prefs?.walkIntervalMin ?? 90}m',
                        count: walkLogsCount,
                        unit: 'completed',
                        icon: Icons.directions_walk_rounded,
                        color: AppTheme.accentAmber,
                        onTap: () {
                          healthActions.logMetric('walk', notes: 'Logged active walk');
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Interval Configuration Settings
                Text(
                  'Reminder Schedules',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 16),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildIntervalSlider(
                          context: context,
                          title: 'Water Intake Interval',
                          value: (prefs?.waterIntervalMin ?? 45).toDouble(),
                          min: 15,
                          max: 120,
                          step: 15,
                          unit: 'minutes',
                          color: AppTheme.primaryGreen,
                          onChanged: (newVal) {
                            if (prefs == null) return;
                            prefActions.updatePreferences(
                              waterIntervalMin: newVal.round(),
                              breakIntervalMin: prefs.breakIntervalMin,
                              walkIntervalMin: prefs.walkIntervalMin,
                              exerciseReminderHour: prefs.exerciseReminderHour,
                              workStartHour: prefs.workStartHour,
                              workEndHour: prefs.workEndHour,
                            );
                          },
                        ),
                        const Divider(height: 40, color: AppTheme.surfaceMuted),
                        _buildIntervalSlider(
                          context: context,
                          title: 'Screen Break Interval',
                          value: (prefs?.breakIntervalMin ?? 60).toDouble(),
                          min: 20,
                          max: 180,
                          step: 10,
                          unit: 'minutes',
                          color: AppTheme.accentBlue,
                          onChanged: (newVal) {
                            if (prefs == null) return;
                            prefActions.updatePreferences(
                              waterIntervalMin: prefs.waterIntervalMin,
                              breakIntervalMin: newVal.round(),
                              walkIntervalMin: prefs.walkIntervalMin,
                              exerciseReminderHour: prefs.exerciseReminderHour,
                              workStartHour: prefs.workStartHour,
                              workEndHour: prefs.workEndHour,
                            );
                          },
                        ),
                        const Divider(height: 40, color: AppTheme.surfaceMuted),
                        _buildIntervalSlider(
                          context: context,
                          title: 'Stand & Walk Interval',
                          value: (prefs?.walkIntervalMin ?? 90).toDouble(),
                          min: 30,
                          max: 240,
                          step: 15,
                          unit: 'minutes',
                          color: AppTheme.accentAmber,
                          onChanged: (newVal) {
                            if (prefs == null) return;
                            prefActions.updatePreferences(
                              waterIntervalMin: prefs.waterIntervalMin,
                              breakIntervalMin: prefs.breakIntervalMin,
                              walkIntervalMin: newVal.round(),
                              exerciseReminderHour: prefs.exerciseReminderHour,
                              workStartHour: prefs.workStartHour,
                              workEndHour: prefs.workEndHour,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaterCard(
    BuildContext context,
    int volumeMl,
    int goalMl,
    double progress,
    VoidCallback onAdd250,
    VoidCallback onAdd500,
  ) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hydration Tracker',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Daily goal: ${goalMl}ml',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${volumeMl} ml',
                    style: theme.textTheme.displayMedium?.copyWith(
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: onAdd250,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryGreen.withOpacity(0.1),
                          foregroundColor: AppTheme.primaryGreen,
                        ),
                        child: const Text('+250 ml'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: onAdd500,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryGreen.withOpacity(0.1),
                          foregroundColor: AppTheme.primaryGreen,
                        ),
                        child: const Text('+500 ml'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              height: 120,
              width: 120,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 10,
                    backgroundColor: AppTheme.surfaceMuted,
                    color: AppTheme.primaryGreen,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.local_drink, color: AppTheme.primaryGreen, size: 36),
                        const SizedBox(height: 4),
                        Text(
                          '${(progress * 100).toInt()}%',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required int count,
    required String unit,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 28),
                IconButton(
                  onPressed: onTap,
                  icon: const Icon(Icons.add, color: AppTheme.textPrimary),
                  style: IconButton.styleFrom(
                    backgroundColor: color.withOpacity(0.1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '$count $unit',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntervalSlider({
    required BuildContext context,
    required String title,
    required double value,
    required double min,
    required double max,
    required double step,
    required String unit,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${value.toInt()} $unit',
              style: theme.textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: color,
            inactiveTrackColor: AppTheme.surfaceMuted,
            thumbColor: color,
            overlayColor: color.withOpacity(0.2),
            valueIndicatorColor: color,
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: ((max - min) / step).round(),
            label: '${value.toInt()} $unit',
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
