import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:flowday/local/collections/workout_plan_collection.dart';
import 'package:flowday/local/collections/workout_log_collection.dart';
import 'package:flowday/providers/isar_provider.dart';
import 'package:flowday/providers/auth_provider.dart';
import 'package:flowday/services/sync_service.dart';
import 'package:flowday/services/notification_service.dart';

final workoutPlansProvider = StreamProvider<List<WorkoutPlanLocal>>((ref) {
  final isar = ref.watch(isarProvider);
  return isar.workoutPlanLocals.where().sortByDayIndex().watch(fireImmediately: true);
});

final nextWorkoutDayProvider = FutureProvider<WorkoutPlanLocal>((ref) async {
  final isar = ref.watch(isarProvider);
  
  // Safeguard: Seed default plans if Isar is empty
  final plansCount = await isar.workoutPlanLocals.count();
  if (plansCount == 0) {
    await isar.writeTxn(() async {
      for (final raw in _defaultPlans) {
        final plan = WorkoutPlanLocal()
          ..remoteId = raw['id']
          ..dayLabel = raw['day_label']
          ..dayIndex = raw['day_index']
          ..focus = raw['focus']
          ..exercises = raw['exercises']
          ..updatedAt = DateTime.now()
          ..pendingSync = true;
        await isar.workoutPlanLocals.put(plan);
      }
    });
  }

  // Count completed workout logs in Isar
  final count = await isar.workoutLogLocals.count();
  final nextIndex = count % 5;
  
  final plan = await isar.workoutPlanLocals
      .filter()
      .dayIndexEqualTo(nextIndex)
      .findFirst();

  // If still null (unlikely), return a dummy or first
  if (plan == null) {
    return (await isar.workoutPlanLocals.where().sortByDayIndex().findFirst())!;
  }
  return plan;
});

final workoutLogsProvider = StreamProvider<List<WorkoutLogLocal>>((ref) {
  final isar = ref.watch(isarProvider);
  return isar.workoutLogLocals.where().sortByCompletedAtDesc().watch(fireImmediately: true);
});

final workoutStreakProvider = Provider<int>((ref) {
  final logs = ref.watch(workoutLogsProvider).valueOrNull ?? [];
  if (logs.isEmpty) return 0;

  // Convert logs to a sorted set of unique dates (normalized to midnight)
  final dates = logs
      .map((log) => DateTime(log.completedAt.year, log.completedAt.month, log.completedAt.day))
      .toSet()
      .toList()
    ..sort((a, b) => b.compareTo(a)); // Sort descending (newest first)

  final today = DateTime.now();
  final todayNormalized = DateTime(today.year, today.month, today.day);
  final yesterdayNormalized = todayNormalized.subtract(const Duration(days: 1));

  // If the latest logged workout is not today or yesterday, streak is broken (0)
  if (dates.isEmpty || (dates[0] != todayNormalized && dates[0] != yesterdayNormalized)) {
    return 0;
  }

  int streak = 1;
  for (int i = 0; i < dates.length - 1; i++) {
    final diff = dates[i].difference(dates[i + 1]).inDays;
    if (diff == 1) {
      streak++;
    } else if (diff > 1) {
      break;
    }
  }

  return streak;
});

final workoutActionsProvider = Provider((ref) {
  final isar = ref.watch(isarProvider);
  final user = ref.watch(currentUserProvider);
  final syncService = ref.read(syncServiceProvider);
  final notificationService = ref.read(notificationServiceProvider);

  return WorkoutActions(isar, user?.id, syncService, notificationService);
});

class WorkoutActions {
  final Isar _isar;
  final String? _userId;
  final SyncService _syncService;
  final NotificationService _notificationService;

  WorkoutActions(this._isar, this._userId, this._syncService, this._notificationService);

  Future<void> logWorkout({
    required int planDayIndex,
    required int durationMin,
    required List<Map<String, dynamic>> exercisesDone,
    String? notes,
  }) async {
    if (_userId == null) return;

    final log = WorkoutLogLocal()
      ..remoteId = ''
      ..userId = _userId!
      ..planDayIndex = planDayIndex
      ..completedAt = DateTime.now()
      ..durationMin = durationMin
      ..exercisesDone = jsonEncode(exercisesDone)
      ..notes = notes
      ..updatedAt = DateTime.now()
      ..pendingSync = true;

    await _isar.writeTxn(() async {
      await _isar.workoutLogLocals.put(log);
    });

    // Sync in background
    _syncService.pushWorkoutLog(_userId!);

    // Trigger pet notification
    _notificationService.triggerPetNotification('Workout Day $planDayIndex complete! Beast mode! 💪', 'happy');
  }
}

// Seed default plans matching database seeds
final List<Map<String, dynamic>> _defaultPlans = [
  {
    'id': 'plan_push_0',
    'day_label': 'Day A – Push',
    'day_index': 0,
    'focus': 'Chest · Shoulders · Triceps',
    'exercises': '[{"name":"Push-Ups","sets":3,"reps":"15","rest_sec":45,"tip":"Keep core tight, chest to floor"},{"name":"Pike Push-Ups","sets":3,"reps":"12","rest_sec":45,"tip":"Hips high, targets shoulders"},{"name":"Diamond Push-Ups","sets":3,"reps":"10","rest_sec":60,"tip":"Hands form a diamond under chest"},{"name":"Tricep Dips (Chair)","sets":3,"reps":"12","rest_sec":60,"tip":"Elbows point straight back"},{"name":"Shoulder Circles + Wall Press","sets":2,"reps":"15","rest_sec":30,"tip":"Warmdown movement"}]'
  },
  {
    'id': 'plan_pull_1',
    'day_label': 'Day B – Pull',
    'day_index': 1,
    'focus': 'Back · Biceps · Rear Delts',
    'exercises': '[{"name":"Doorframe Rows / Pull-Ups","sets":3,"reps":"10","rest_sec":60,"tip":"Full range of motion"},{"name":"Bent-Over Rows (books/bag)","sets":3,"reps":"12","rest_sec":60,"tip":"Squeeze shoulder blades together"},{"name":"Superman Hold","sets":3,"reps":"12","rest_sec":45,"tip":"Hold 2 sec at top"},{"name":"Bicep Curls (any weight)","sets":3,"reps":"15","rest_sec":45,"tip":"Slow on the way down"},{"name":"Face Pulls / Band Pull-Aparts","sets":3,"reps":"15","rest_sec":30,"tip":"Protect rotator cuff"}]'
  },
  {
    'id': 'plan_legs_2',
    'day_label': 'Day C – Legs + Core',
    'day_index': 2,
    'focus': 'Quads · Hamstrings · Glutes · Core',
    'exercises': '[{"name":"Bodyweight Squats","sets":3,"reps":"20","rest_sec":45,"tip":"Knees track over toes"},{"name":"Reverse Lunges","sets":3,"reps":"12 each","rest_sec":45,"tip":"Controlled drop, glutes squeeze up"},{"name":"Glute Bridge","sets":3,"reps":"20","rest_sec":45,"tip":"Drive hips up, hold 1 sec"},{"name":"Calf Raises (step edge)","sets":3,"reps":"20","rest_sec":30,"tip":"Full stretch at bottom"},{"name":"Plank","sets":3,"reps":"45 sec","rest_sec":45,"tip":"Imagine pulling elbows to toes"},{"name":"Bicycle Crunches","sets":3,"reps":"20","rest_sec":30,"tip":"Slow and controlled"}]'
  },
  {
    'id': 'plan_circuit_3',
    'day_label': 'Day D – Full Body Circuit',
    'day_index': 3,
    'focus': 'Full Body · Cardio Endurance',
    'exercises': '[{"name":"Burpees","sets":3,"reps":"10","rest_sec":60,"tip":"Jump fully at top, chest to floor"},{"name":"Jump Squats","sets":3,"reps":"15","rest_sec":45,"tip":"Land softly, knees slightly bent"},{"name":"Mountain Climbers","sets":3,"reps":"20 each","rest_sec":45,"tip":"Hips level, fast pace"},{"name":"Push-Up to Downward Dog","sets":3,"reps":"10","rest_sec":45,"tip":"Transition is the rep"},{"name":"Lateral Lunges","sets":3,"reps":"10 each","rest_sec":45,"tip":"Keep grounded foot flat"}]'
  },
  {
    'id': 'plan_recovery_4',
    'day_label': 'Day E – Active Recovery',
    'day_index': 4,
    'focus': 'Mobility · Flexibility · Breathwork',
    'exercises': '[{"name":"Cat-Cow Stretch","sets":1,"reps":"10 slow","rest_sec":0,"tip":"Sync breath with movement"},{"name":"Hip Flexor Stretch","sets":1,"reps":"60 sec each","rest_sec":0,"tip":"Desk workers need this most"},{"name":"Child\'s Pose","sets":1,"reps":"90 sec","rest_sec":0,"tip":"Breathe into your lower back"},{"name":"Thoracic Rotation","sets":1,"reps":"10 each","rest_sec":0,"tip":"Undo all the desk slouching"},{"name":"4-7-8 Breathing","sets":3,"reps":"4 cycles","rest_sec":0,"tip":"Inhale 4, hold 7, exhale 8"}]'
  }
];
