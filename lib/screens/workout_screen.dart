import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flowday/theme/app_theme.dart';
import 'package:flowday/local/collections/workout_plan_collection.dart';
import 'package:flowday/providers/workout_provider.dart';
import 'package:flowday/services/notification_service.dart';

class WorkoutScreen extends ConsumerStatefulWidget {
  const WorkoutScreen({super.key});

  @override
  ConsumerState<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends ConsumerState<WorkoutScreen> {
  bool _isWorkoutActive = false;
  WorkoutPlanLocal? _activePlan;
  
  // Active workout state
  int _currentExerciseIndex = 0;
  List<Map<String, dynamic>> _exercises = [];
  List<List<bool>> _setsCompletedStatus = []; // Outer: exercise, Inner: set
  
  // Timer state
  bool _isResting = false;
  int _restDuration = 0;
  int _restSecondsRemaining = 0;
  Timer? _restTimer;

  // Logging state
  final _notesController = TextEditingController();
  DateTime? _startTime;

  @override
  void dispose() {
    _restTimer?.cancel();
    _notesController.dispose();
    super.dispose();
  }

  void _startWorkout(WorkoutPlanLocal plan) {
    final rawExercises = jsonDecode(plan.exercises) as List<dynamic>;
    
    setState(() {
      _activePlan = plan;
      _isWorkoutActive = true;
      _currentExerciseIndex = 0;
      _startTime = DateTime.now();
      _notesController.clear();
      
      _exercises = rawExercises.map((e) => Map<String, dynamic>.from(e)).toList();
      _setsCompletedStatus = _exercises.map((e) {
        final setsCount = e['sets'] as int? ?? 3;
        return List<bool>.filled(setsCount, false);
      }).toList();
    });
  }

  void _startRest(int seconds) {
    _restTimer?.cancel();
    setState(() {
      _isResting = true;
      _restDuration = seconds;
      _restSecondsRemaining = seconds;
    });

    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_restSecondsRemaining > 1) {
        setState(() {
          _restSecondsRemaining--;
        });
      } else {
        _stopRest();
      }
    });
  }

  void _stopRest() {
    _restTimer?.cancel();
    setState(() {
      _isResting = false;
    });
  }

  void _toggleSet(int exerciseIndex, int setIndex) {
    if (_isResting) _stopRest();

    setState(() {
      final currentVal = _setsCompletedStatus[exerciseIndex][setIndex];
      _setsCompletedStatus[exerciseIndex][setIndex] = !currentVal;

      // Start rest timer if the set was marked completed
      if (!currentVal) {
        final restSec = _exercises[exerciseIndex]['rest_sec'] as int? ?? 45;
        _startRest(restSec);
      }
    });
  }

  bool _isExerciseComplete(int index) {
    return _setsCompletedStatus[index].every((completed) => completed);
  }

  bool _isAllExercisesComplete() {
    return _setsCompletedStatus.every((exSets) => exSets.every((completed) => completed));
  }

  Future<void> _finishWorkout() async {
    _restTimer?.cancel();
    if (_startTime == null || _activePlan == null) return;

    final durationMin = DateTime.now().difference(_startTime!).inMinutes;
    final exercisesLogged = <Map<String, dynamic>>[];

    for (int i = 0; i < _exercises.length; i++) {
      final name = _exercises[i]['name'] as String;
      final sets = _exercises[i]['sets'] as int? ?? 3;
      final reps = _exercises[i]['reps'] as String? ?? '10';
      
      int completedSets = _setsCompletedStatus[i].where((c) => c).length;
      if (completedSets > 0) {
        exercisesLogged.add({
          'name': name,
          'sets_completed': completedSets,
          'total_sets': sets,
          'reps': reps,
        });
      }
    }

    // Save Workout Log
    await ref.read(workoutActionsProvider).logWorkout(
      planDayIndex: _activePlan!.dayIndex,
      durationMin: durationMin,
      exercisesDone: exercisesLogged,
      notes: _notesController.text.trim(),
    );

    // Trigger learning nudge 5 mins later
    ref.read(notificationServiceProvider).showLearningNudge();

    // Show completion dialog
    if (mounted) {
      final currentStreak = ref.read(workoutStreakProvider);
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Center(
            child: Text(
              'Workout Complete! 🎉',
              style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.stars, color: AppTheme.primaryGreen, size: 64),
              const SizedBox(height: 16),
              Text(
                'You crushed ${_activePlan!.dayLabel}!',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                'Duration: $durationMin mins\nCompleted exercises: ${exercisesLogged.length}/${_exercises.length}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.local_fire_department, color: AppTheme.primaryGreen),
                    const SizedBox(width: 8),
                    Text(
                      'Streak: ${currentStreak + 1} Days',
                      style: const TextStyle(color: AppTheme.primaryGreen, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _isWorkoutActive = false;
                    _activePlan = null;
                  });
                },
                child: const Text('Back to Home'),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nextWorkoutAsync = ref.watch(nextWorkoutDayProvider);
    final streak = ref.watch(workoutStreakProvider);

    if (_isWorkoutActive && _activePlan != null) {
      return _buildActiveWorkoutView(theme);
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Strength Training',
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
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Chip(
                  avatar: const Icon(Icons.local_fire_department, color: AppTheme.primaryGreen, size: 18),
                  label: Text('$streak Day Streak'),
                  backgroundColor: AppTheme.surfaceCard,
                  side: const BorderSide(color: AppTheme.surfaceMuted),
                ),
              )
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverToBoxAdapter(
              child: nextWorkoutAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error loading workout: $err')),
                data: (plan) {
                  final exList = (jsonDecode(plan.exercises) as List<dynamic>)
                      .map((e) => Map<String, dynamic>.from(e))
                      .toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header Card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryGreen.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'NEXT UP',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: AppTheme.primaryGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                plan.dayLabel,
                                style: theme.textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                plan.focus,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                              const Divider(height: 32, color: AppTheme.surfaceMuted),
                              ElevatedButton.icon(
                                onPressed: () => _startWorkout(plan),
                                icon: const Icon(Icons.play_arrow_rounded),
                                label: const Text('Start Workout Session'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Exercises list
                      Text(
                        'Routines & Exercises',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: exList.length,
                        separatorBuilder: (context, idx) => const SizedBox(height: 12),
                        itemBuilder: (context, idx) {
                          final ex = exList[idx];
                          return Card(
                            color: AppTheme.surfaceCard.withOpacity(0.5),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppTheme.surfaceMuted,
                                child: Text(
                                  '${idx + 1}',
                                  style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold),
                                ),
                              ),
                              title: Text(
                                ex['name'] as String,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${ex['sets']} sets × ${ex['reps']} reps (Rest: ${ex['rest_sec']}s)',
                                style: const TextStyle(color: AppTheme.textSecondary),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildActiveWorkoutView(ThemeData theme) {
    final ex = _exercises[_currentExerciseIndex];
    final sets = _setsCompletedStatus[_currentExerciseIndex];
    final progress = (_currentExerciseIndex) / _exercises.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(_activePlan!.dayLabel, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Quit Session?'),
                content: const Text('Are you sure you want to quit? Your workout progress won\'t be saved.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        _isWorkoutActive = false;
                        _activePlan = null;
                      });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentRed),
                    child: const Text('Quit'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Progress indicator
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppTheme.surfaceMuted,
                  color: AppTheme.primaryGreen,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Exercise ${_currentExerciseIndex + 1} of ${_exercises.length}',
                      style: const TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${(progress * 100).toInt()}% Done',
                      style: const TextStyle(color: AppTheme.primaryGreen, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Main card
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ex['name'] as String,
                            style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Goal: ${ex['sets']} sets × ${ex['reps']} reps',
                            style: const TextStyle(color: AppTheme.primaryGreen, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          if (ex['tip'] != null) ...[
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.surfaceMuted.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.info_outline, color: AppTheme.accentBlue, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      ex['tip'] as String,
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 24),

                          // Sets Checklist
                          Expanded(
                            child: ListView.builder(
                              itemCount: sets.length,
                              itemBuilder: (context, idx) {
                                final isDone = sets[idx];
                                return CheckboxListTile(
                                  value: isDone,
                                  title: Text(
                                    'Set ${idx + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: isDone ? TextDecoration.lineThrough : null,
                                      color: isDone ? AppTheme.textSecondary : AppTheme.textPrimary,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${ex['reps']} reps',
                                    style: TextStyle(color: isDone ? AppTheme.textSecondary.withOpacity(0.5) : AppTheme.textSecondary),
                                  ),
                                  activeColor: AppTheme.primaryGreen,
                                  checkColor: Colors.white,
                                  onChanged: (_) => _toggleSet(_currentExerciseIndex, idx),
                                  secondary: CircleAvatar(
                                    backgroundColor: isDone ? AppTheme.primaryGreen.withOpacity(0.2) : AppTheme.surfaceMuted,
                                    child: Icon(
                                      isDone ? Icons.check : Icons.fitness_center,
                                      color: isDone ? AppTheme.primaryGreen : AppTheme.textSecondary,
                                      size: 18,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Note input form shown before finish
                if (_isAllExercisesComplete()) ...[
                  TextField(
                    controller: _notesController,
                    decoration: InputDecoration(
                      hintText: 'Add workout notes (e.g. felt great, raised weights...)',
                      filled: true,
                      fillColor: AppTheme.surfaceCard,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppTheme.surfaceMuted),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Action Navigation buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentExerciseIndex > 0)
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _currentExerciseIndex--;
                          });
                        },
                        child: const Text('Previous'),
                      )
                    else
                      const SizedBox(),
                    
                    if (_isAllExercisesComplete())
                      ElevatedButton(
                        onPressed: _finishWorkout,
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryGreen),
                        child: const Text('Finish Workout 🎉'),
                      )
                    else if (_isExerciseComplete(_currentExerciseIndex) && _currentExerciseIndex < _exercises.length - 1)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentExerciseIndex++;
                          });
                        },
                        child: const Text('Next Exercise'),
                      )
                    else
                      const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
          
          // Custom Overlay Rest Timer
          if (_isResting) _buildRestTimerOverlay(theme),
        ],
      ),
    );
  }

  Widget _buildRestTimerOverlay(ThemeData theme) {
    final progress = _restSecondsRemaining / _restDuration;
    return Container(
      color: AppTheme.surfaceDark.withOpacity(0.95),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rest Active ⏰',
              style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Recover for the next set',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 40),
            
            SizedBox(
              height: 200,
              width: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: AppTheme.surfaceMuted,
                    color: AppTheme.accentBlue,
                  ),
                  Center(
                    child: Text(
                      '${_restSecondsRemaining}s',
                      style: theme.textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 48,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            OutlinedButton(
              onPressed: _stopRest,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.textPrimary,
                side: const BorderSide(color: AppTheme.surfaceMuted),
              ),
              child: const Text('Skip Rest Timer'),
            ),
          ],
        ),
      ),
    );
  }
}
