import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flowday/theme/app_theme.dart';
import 'package:flowday/local/collections/curriculum_day_collection.dart';
import 'package:flowday/local/collections/learning_goal_collection.dart';
import 'package:flowday/providers/learning_provider.dart';
import 'package:flowday/services/gemini_service.dart';
import 'package:flowday/providers/isar_provider.dart';

// ── Streaming state ──────────────────────────────────────────────────────────
enum GenerationStatus { idle, streaming, done, error }

class GenerationState {
  final GenerationStatus status;
  final List<CurriculumDayLocal> days;
  final String? errorMessage;
  const GenerationState({
    required this.status,
    required this.days,
    this.errorMessage,
  });
  GenerationState copyWith({
    GenerationStatus? status,
    List<CurriculumDayLocal>? days,
    String? errorMessage,
  }) =>
      GenerationState(
        status: status ?? this.status,
        days: days ?? this.days,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}

// ── Providers ────────────────────────────────────────────────────────────────
final _generationStateProvider =
    StateProvider<GenerationState>((ref) => const GenerationState(
          status: GenerationStatus.idle,
          days: [],
        ));

// ── Screen ───────────────────────────────────────────────────────────────────
class LearningScreen extends ConsumerStatefulWidget {
  const LearningScreen({super.key});
  @override
  ConsumerState<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends ConsumerState<LearningScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _weeksController = TextEditingController(text: '4');
  StreamSubscription<CurriculumDayLocal>? _streamSub;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _weeksController.dispose();
    _streamSub?.cancel();
    super.dispose();
  }

  Future<void> _generateCurriculum(LearningGoalLocal goal) async {
    final gemini = ref.read(geminiServiceProvider);
    final isar = ref.read(isarProvider);
    final notifier = ref.read(_generationStateProvider.notifier);

    notifier.state = const GenerationState(
        status: GenerationStatus.streaming, days: []);

    final goalKey = goal.remoteId.isNotEmpty
        ? goal.remoteId
        : goal.id.toString();

    _streamSub = gemini
        .generateCurriculumStream(
          goalId: goalKey,
          goalTitle: goal.title,
          goalDescription: goal.description ?? '',
          targetWeeks: goal.targetWeeks,
        )
        .listen(
          (day) async {
            await isar.writeTxn(() async {
              await isar.curriculumDayLocals.put(day);
            });
            notifier.state = notifier.state.copyWith(
              days: [...notifier.state.days, day],
            );
          },
          onDone: () {
            notifier.state =
                notifier.state.copyWith(status: GenerationStatus.done);
          },
          onError: (e) {
            notifier.state = notifier.state.copyWith(
              status: GenerationStatus.error,
              errorMessage: e.toString(),
            );
          },
        );
  }

  Future<void> _createGoal() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    final goal = await ref.read(learningActionsProvider).createGoal(
          title: title,
          description: _descController.text.trim(),
          targetWeeks: int.tryParse(_weeksController.text) ?? 4,
        );
    if (goal != null && mounted) {
      Navigator.of(context).pop();
      await _generateCurriculum(goal);
    }
  }

  void _showCreateGoalSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surfaceCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
            24, 24, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'New Learning Goal',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Goal Title',
                hintText: 'e.g. Learn Rust Programming',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'What specifically do you want to achieve?',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _weeksController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Target Weeks',
                hintText: '4',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _createGoal,
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Generate AI Curriculum'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeGoalAsync = ref.watch(activeGoalProvider);
    final curriculumAsync = ref.watch(curriculumDaysProvider);
    final generationState = ref.watch(_generationStateProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateGoalSheet,
        backgroundColor: AppTheme.primaryGreen,
        icon: const Icon(Icons.add),
        label: const Text('New Goal'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Learning Calendar',
                style: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
              background: Container(color: AppTheme.surfaceDark),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverToBoxAdapter(
              child: activeGoalAsync.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) =>
                    Center(child: Text('Error: $e')),
                data: (goal) {
                  if (goal == null) {
                    return _buildEmptyState();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildGoalHeader(goal),
                      const SizedBox(height: 24),
                      if (generationState.status ==
                          GenerationStatus.streaming)
                        _buildStreamingBanner(generationState.days.length),
                      if (generationState.status == GenerationStatus.error)
                        _buildErrorBanner(
                            generationState.errorMessage ?? 'Unknown error'),
                      if (generationState.status != GenerationStatus.idle)
                        _buildStreamedDays(generationState.days, goal)
                      else
                        _buildCurriculumFromIsar(curriculumAsync, goal),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          const Icon(Icons.school_outlined,
              size: 80, color: AppTheme.textSecondary),
          const SizedBox(height: 24),
          Text(
            'No active goal yet',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Create a learning goal and let AI build\nyour personalised curriculum.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _showCreateGoalSheet,
            icon: const Icon(Icons.auto_awesome),
            label: const Text('Create First Goal'),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalHeader(LearningGoalLocal goal) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.flag, color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    goal.title,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${goal.targetWeeks}w',
                    style: const TextStyle(
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            if (goal.description != null && goal.description!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                goal.description!,
                style: const TextStyle(color: AppTheme.textSecondary),
              ),
            ],
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () => _generateCurriculum(goal),
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Regenerate Curriculum'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreamingBanner(int count) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.accentBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.accentBlue.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppTheme.accentBlue,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Gemini is building your curriculum… $count days generated',
            style: const TextStyle(
                color: AppTheme.accentBlue, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBanner(String message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.accentRed.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.accentRed.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppTheme.accentRed),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Generation error: $message',
              style: const TextStyle(color: AppTheme.accentRed),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreamedDays(
      List<CurriculumDayLocal> days, LearningGoalLocal goal) {
    if (days.isEmpty) return const SizedBox();
    return _DaysList(days: days, goal: goal);
  }

  Widget _buildCurriculumFromIsar(
      AsyncValue<List<CurriculumDayLocal>> async, LearningGoalLocal goal) {
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (days) {
        if (days.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Center(
              child: Column(
                children: [
                  const Icon(Icons.auto_awesome,
                      size: 48, color: AppTheme.textSecondary),
                  const SizedBox(height: 12),
                  const Text(
                    'No curriculum yet.\nTap "Regenerate Curriculum" to generate one.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ),
          );
        }
        return _DaysList(days: days, goal: goal);
      },
    );
  }
}

// ── Days list (week-grouped) ─────────────────────────────────────────────────
class _DaysList extends ConsumerWidget {
  final List<CurriculumDayLocal> days;
  final LearningGoalLocal goal;
  const _DaysList({required this.days, required this.goal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Group by week
    final Map<int, List<CurriculumDayLocal>> weeks = {};
    for (final d in days) {
      weeks.putIfAbsent(d.weekNumber, () => []).add(d);
    }
    final sortedWeeks = weeks.keys.toList()..sort();

    return Column(
      children: sortedWeeks.map((week) {
        final weekDays = weeks[week]!..sort((a, b) => a.dayNumber.compareTo(b.dayNumber));
        return _WeekSection(week: week, days: weekDays, goal: goal);
      }).toList(),
    );
  }
}

class _WeekSection extends StatelessWidget {
  final int week;
  final List<CurriculumDayLocal> days;
  final LearningGoalLocal goal;
  const _WeekSection(
      {required this.week, required this.days, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 8),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'W$week',
                    style: const TextStyle(
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Week $week',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ...days.map((d) => _DayCard(day: d, goal: goal)),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _DayCard extends ConsumerStatefulWidget {
  final CurriculumDayLocal day;
  final LearningGoalLocal goal;
  const _DayCard({required this.day, required this.goal});

  @override
  ConsumerState<_DayCard> createState() => _DayCardState();
}

class _DayCardState extends ConsumerState<_DayCard> {
  bool _expanded = false;
  bool _isLogging = false;

  Future<void> _logSession() async {
    setState(() => _isLogging = true);
    final goalKey = widget.goal.remoteId.isNotEmpty
        ? widget.goal.remoteId
        : widget.goal.id.toString();
    final dayKey = widget.day.remoteId.isNotEmpty
        ? widget.day.remoteId
        : widget.day.id.toString();

    await ref.read(learningActionsProvider).logLearningSession(
          curriculumDayId: dayKey,
          goalId: goalKey,
          durationMin: widget.day.estimatedMin,
          completed: true,
        );
    if (mounted) setState(() => _isLogging = false);
  }

  @override
  Widget build(BuildContext context) {
    final logs = ref.watch(learningLogsProvider).valueOrNull ?? [];
    final dayKey = widget.day.remoteId.isNotEmpty
        ? widget.day.remoteId
        : widget.day.id.toString();
    final isCompleted =
        logs.any((l) => l.curriculumDayId == dayKey && l.completed);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isCompleted
            ? AppTheme.primaryGreen.withValues(alpha: 0.08)
            : AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isCompleted
              ? AppTheme.primaryGreen.withValues(alpha: 0.4)
              : AppTheme.surfaceMuted,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Day badge
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppTheme.primaryGreen
                          : AppTheme.surfaceMuted,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: isCompleted
                          ? const Icon(Icons.check,
                              color: Colors.white, size: 18)
                          : Text(
                              '${widget.day.dayNumber}',
                              style: const TextStyle(
                                color: AppTheme.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.day.topic,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          '~${widget.day.estimatedMin} min',
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: AppTheme.textSecondary,
                  ),
                ],
              ),
              if (_expanded) ...[
                const SizedBox(height: 14),
                const Divider(color: AppTheme.surfaceMuted, height: 1),
                const SizedBox(height: 14),
                Text(
                  widget.day.description,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                if (widget.day.practicalTask.isNotEmpty) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.task_alt,
                          color: AppTheme.accentAmber, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.day.practicalTask,
                          style: const TextStyle(
                            color: AppTheme.textPrimary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
                // Resources
                _buildResources(widget.day.resources),
                const SizedBox(height: 16),
                if (!isCompleted)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isLogging ? null : _logSession,
                      icon: _isLogging
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : const Icon(Icons.check_circle_outline),
                      label: Text(
                          _isLogging ? 'Logging…' : 'Mark as Complete'),
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle,
                            color: AppTheme.primaryGreen, size: 16),
                        SizedBox(width: 6),
                        Text('Completed',
                            style: TextStyle(
                                color: AppTheme.primaryGreen,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResources(String resourcesJson) {
    try {
      final list = jsonDecode(resourcesJson) as List<dynamic>;
      if (list.isEmpty) return const SizedBox();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Resources',
              style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          ...list.map(
            (r) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(Icons.link,
                      color: AppTheme.accentBlue, size: 14),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      r.toString(),
                      style: const TextStyle(
                          color: AppTheme.accentBlue, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
        ],
      );
    } catch (_) {
      return const SizedBox();
    }
  }
}
