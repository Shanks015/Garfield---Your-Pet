import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flowday/theme/app_theme.dart';
import 'package:flowday/providers/health_provider.dart';
import 'package:flowday/providers/workout_provider.dart';
import 'package:flowday/providers/learning_provider.dart';
import 'package:flowday/providers/auth_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final healthLogs = ref.watch(todayHealthLogsProvider).valueOrNull ?? [];
    final workoutLogs = ref.watch(workoutLogsProvider).valueOrNull ?? [];
    final streak = ref.watch(workoutStreakProvider);
    final activeGoal = ref.watch(activeGoalProvider).valueOrNull;
    final curriculumDays = ref.watch(curriculumDaysProvider).valueOrNull ?? [];
    final learningLogs = ref.watch(learningLogsProvider).valueOrNull ?? [];

    // ── Metrics ────────────────────────────────────────────────────────────
    final waterCount = healthLogs.where((l) => l.logType == 'water').length;
    final waterMl = waterCount * 250;
    final waterGoal = 2500;
    final waterProgress = (waterMl / waterGoal).clamp(0.0, 1.0);

    final breakCount = healthLogs.where((l) => l.logType == 'break').length;
    final walkCount = healthLogs.where((l) => l.logType == 'walk').length;

    final workoutsThisWeek = workoutLogs.where((l) {
      final weekAgo = DateTime.now().subtract(const Duration(days: 7));
      return l.completedAt.isAfter(weekAgo);
    }).length;

    final completedLessons = learningLogs.where((l) => l.completed).length;
    final totalLessons = curriculumDays.length;
    final learningProgress =
        totalLessons > 0 ? completedLessons / totalLessons : 0.0;

    // ── Week strip (last 7 days) ───────────────────────────────────────────
    final today = DateTime.now();
    final weekDays = List.generate(
      7,
      (i) => today.subtract(Duration(days: 6 - i)),
    );
    final workoutDates = workoutLogs
        .map((l) =>
            DateTime(l.completedAt.year, l.completedAt.month, l.completedAt.day))
        .toSet();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── App Bar ──────────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good ${_greeting()}, ${_firstName(user?.email)}!',
                    style: GoogleFonts.spaceGrotesk(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // ── Week Activity Strip ───────────────────────────────────
                _SectionLabel('This Week'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: weekDays.map((d) {
                    final normalized = DateTime(d.year, d.month, d.day);
                    final isToday = normalized ==
                        DateTime(today.year, today.month, today.day);
                    final hasWorkout = workoutDates.contains(normalized);
                    return _DayPip(
                      label: _shortDay(d.weekday),
                      active: hasWorkout,
                      isToday: isToday,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 28),

                // ── Health Ring Row ───────────────────────────────────────
                _SectionLabel('Today\'s Wellness'),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _RingCard(
                        label: 'Hydration',
                        progress: waterProgress,
                        value: '${waterMl}ml',
                        color: AppTheme.accentBlue,
                        icon: Icons.local_drink,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _RingCard(
                        label: 'Eye Breaks',
                        progress: (breakCount / 8).clamp(0.0, 1.0),
                        value: '$breakCount',
                        color: AppTheme.accentAmber,
                        icon: Icons.remove_red_eye_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _RingCard(
                        label: 'Walks',
                        progress: (walkCount / 4).clamp(0.0, 1.0),
                        value: '$walkCount',
                        color: AppTheme.primaryGreen,
                        icon: Icons.directions_walk,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // ── Workout Summary ───────────────────────────────────────
                _SectionLabel('Strength Training'),
                const SizedBox(height: 14),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              AppTheme.primaryGreen.withValues(alpha: 0.15),
                          child: const Icon(Icons.fitness_center,
                              color: AppTheme.primaryGreen, size: 28),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$workoutsThisWeek workouts this week',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Current streak: $streak days 🔥',
                                style: const TextStyle(
                                    color: AppTheme.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '$streak',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // ── Learning Summary ──────────────────────────────────────
                _SectionLabel('Learning Progress'),
                const SizedBox(height: 14),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (activeGoal != null) ...[
                          Row(
                            children: [
                              const Icon(Icons.school,
                                  color: AppTheme.accentBlue),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  activeGoal.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                              ),
                              Text(
                                '$completedLessons / $totalLessons',
                                style: const TextStyle(
                                  color: AppTheme.accentBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: learningProgress,
                              minHeight: 8,
                              backgroundColor: AppTheme.surfaceMuted,
                              color: AppTheme.accentBlue,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${(learningProgress * 100).toInt()}% complete · ${activeGoal.targetWeeks} weeks',
                            style: const TextStyle(
                                color: AppTheme.textSecondary, fontSize: 12),
                          ),
                        ] else
                          const Text(
                            'No active learning goal. Head to the Learning tab to create one!',
                            style: TextStyle(color: AppTheme.textSecondary),
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

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'morning';
    if (h < 17) return 'afternoon';
    return 'evening';
  }

  String _firstName(String? email) {
    if (email == null) return 'there';
    final local = email.split('@').first;
    return local.isNotEmpty
        ? local[0].toUpperCase() + local.substring(1)
        : 'there';
  }

  String _shortDay(int weekday) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return days[weekday - 1];
  }
}

// ── Small reusable widgets ───────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppTheme.textSecondary,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _DayPip extends StatelessWidget {
  final String label;
  final bool active;
  final bool isToday;
  const _DayPip(
      {required this.label, required this.active, required this.isToday});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: active
                ? AppTheme.primaryGreen
                : isToday
                    ? AppTheme.surfaceMuted
                    : AppTheme.surfaceCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isToday
                  ? AppTheme.primaryGreen
                  : AppTheme.surfaceMuted,
              width: isToday ? 2 : 1,
            ),
          ),
          child: Center(
            child: active
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : Text(
                    label,
                    style: TextStyle(
                      color: isToday
                          ? AppTheme.primaryGreen
                          : AppTheme.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class _RingCard extends StatelessWidget {
  final String label;
  final double progress;
  final String value;
  final Color color;
  final IconData icon;
  const _RingCard({
    required this.label,
    required this.progress,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 6,
                    backgroundColor: AppTheme.surfaceMuted,
                    color: color,
                  ),
                  Center(
                    child: Icon(icon, color: color, size: 22),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
