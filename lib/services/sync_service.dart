import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flowday/local/collections/health_log_collection.dart';
import 'package:flowday/local/collections/workout_log_collection.dart';
import 'package:flowday/local/collections/workout_plan_collection.dart';
import 'package:flowday/local/collections/curriculum_day_collection.dart';
import 'package:flowday/local/collections/learning_log_collection.dart';
import 'package:flowday/local/collections/learning_goal_collection.dart';
import 'package:flowday/local/collections/user_preferences_collection.dart';
import 'package:flowday/providers/isar_provider.dart';
import 'package:flowday/providers/supabase_provider.dart';

final syncServiceProvider = Provider<SyncService>((ref) {
  final isar = ref.watch(isarProvider);
  final client = ref.watch(supabaseClientProvider);
  return SyncService(isar, client);
});

class SyncService {
  final Isar _isar;
  final SupabaseClient _client;

  SyncService(this._isar, this._client);

  Future<void> syncAll(String userId) async {
    // Phase 1: Push every pending local write to Supabase
    await _pushPendingPreferences(userId);
    await _pushPendingLearningGoals(userId);
    await _pushPendingHealthLogs(userId);
    await _pushPendingWorkoutLogs(userId);
    await _pushPendingLearningLogs(userId);
    await _pushPendingCurriculumDays();

    // Phase 2: Pull remote state (only after pushes complete)
    await _pullPreferences(userId);
    await _pullLearningGoals(userId);
    await _pullWorkoutPlans();
    await _pullCurriculumDays(userId);
    await _pullLearningLogs(userId);
  }

  // Pushing pending local changes
  Future<void> _pushPendingHealthLogs(String userId) async {
    final pending = await _isar.healthLogLocals
        .filter()
        .pendingSyncEqualTo(true)
        .findAll();

    for (final log in pending) {
      try {
        final device = Platform.isAndroid || Platform.isIOS ? 'mobile' : 'desktop';
        final data = {
          'user_id': userId,
          'log_type': log.logType,
          'logged_at': log.loggedAt.toIso8601String(),
          'notes': log.notes,
          'synced_from_device': log.syncedFromDevice ?? device,
        };

        Map<String, dynamic> result;
        if (log.remoteId.isNotEmpty) {
          result = await _client.from('health_logs').update(data).eq('id', log.remoteId).select().single();
        } else {
          result = await _client.from('health_logs').insert(data).select().single();
        }

        await _isar.writeTxn(() async {
          log.remoteId = result['id'];
          log.pendingSync = false;
          await _isar.healthLogLocals.put(log);
        });
      } catch (_) {
        // Fail silently to retry next time
      }
    }
  }

  Future<void> _pushPendingWorkoutLogs(String userId) async {
    final pending = await _isar.workoutLogLocals
        .filter()
        .pendingSyncEqualTo(true)
        .findAll();

    for (final log in pending) {
      try {
        final data = {
          'user_id': userId,
          'plan_day_index': log.planDayIndex,
          'completed_at': log.completedAt.toIso8601String(),
          'duration_min': log.durationMin,
          'exercises_done': log.exercisesDone != null ? jsonDecode(log.exercisesDone!) : null,
          'notes': log.notes,
        };

        Map<String, dynamic> result;
        if (log.remoteId.isNotEmpty) {
          result = await _client.from('workout_logs').update(data).eq('id', log.remoteId).select().single();
        } else {
          result = await _client.from('workout_logs').insert(data).select().single();
        }

        await _isar.writeTxn(() async {
          log.remoteId = result['id'];
          log.pendingSync = false;
          await _isar.workoutLogLocals.put(log);
        });
      } catch (_) {
        // Retry later
      }
    }
  }

  Future<void> _pushPendingLearningLogs(String userId) async {
    final pending = await _isar.learningLogLocals
        .filter()
        .pendingSyncEqualTo(true)
        .findAll();

    for (final log in pending) {
      try {
        final data = {
          'user_id': userId,
          'curriculum_day_id': log.curriculumDayId,
          'goal_id': log.goalId,
          'logged_date': log.loggedDate.toIso8601String().substring(0, 10),
          'duration_min': log.durationMin,
          'completed': log.completed,
          'notes': log.notes,
          'difficulty': log.difficulty,
        };

        Map<String, dynamic> result;
        if (log.remoteId.isNotEmpty) {
          result = await _client.from('learning_logs').update(data).eq('id', log.remoteId).select().single();
        } else {
          result = await _client.from('learning_logs').insert(data).select().single();
        }

        await _isar.writeTxn(() async {
          log.remoteId = result['id'];
          log.pendingSync = false;
          await _isar.learningLogLocals.put(log);
        });
      } catch (_) {
        // Retry later
      }
    }
  }

  Future<void> _pushPendingLearningGoals(String userId) async {
    final pending = await _isar.learningGoalLocals
        .filter()
        .pendingSyncEqualTo(true)
        .findAll();

    for (final log in pending) {
      try {
        final data = {
          'user_id': userId,
          'title': log.title,
          'description': log.description,
          'start_date': log.startDate.toIso8601String().substring(0, 10),
          'target_weeks': log.targetWeeks,
          'status': log.status,
        };

        Map<String, dynamic> result;
        if (log.remoteId.isNotEmpty) {
          result = await _client.from('learning_goals').update(data).eq('id', log.remoteId).select().single();
        } else {
          result = await _client.from('learning_goals').insert(data).select().single();
        }

        await _isar.writeTxn(() async {
          log.remoteId = result['id'];
          log.pendingSync = false;
          await _isar.learningGoalLocals.put(log);
        });
      } catch (_) {
        // Retry later
      }
    }
  }

  Future<void> _pushPendingPreferences(String userId) async {
    final pending = await _isar.userPreferencesLocals
        .filter()
        .pendingSyncEqualTo(true)
        .findAll();

    for (final log in pending) {
      try {
        final data = {
          'user_id': userId,
          'water_interval_min': log.waterIntervalMin,
          'break_interval_min': log.breakIntervalMin,
          'walk_interval_min': log.walkIntervalMin,
          'exercise_reminder_hour': log.exerciseReminderHour,
          'work_start_hour': log.workStartHour,
          'work_end_hour': log.workEndHour,
        };

        Map<String, dynamic> result;
        if (log.remoteId.isNotEmpty) {
          result = await _client.from('user_preferences').update(data).eq('id', log.remoteId).select().single();
        } else {
          result = await _client.from('user_preferences').insert(data).select().single();
        }

        await _isar.writeTxn(() async {
          log.remoteId = result['id'];
          log.pendingSync = false;
          await _isar.userPreferencesLocals.put(log);
        });
      } catch (_) {
        // Retry later
      }
    }
  }

  Future<void> _pushPendingCurriculumDays() async {
    final pending = await _isar.curriculumDayLocals
        .filter()
        .pendingSyncEqualTo(true)
        .findAll();

    for (final day in pending) {
      try {
        final data = {
          'goal_id': day.goalId,
          'week_number': day.weekNumber,
          'day_number': day.dayNumber,
          'topic': day.topic,
          'description': day.description,
          'practical_task': day.practicalTask,
          'resources': jsonDecode(day.resources),
          'estimated_min': day.estimatedMin,
          'calendar_date': day.calendarDate?.toIso8601String().substring(0, 10),
          'energy_level': day.energyLevel,
        };

        Map<String, dynamic> result;
        if (day.remoteId.isNotEmpty) {
          result = await _client.from('curriculum_days').update(data).eq('id', day.remoteId).select().single();
        } else {
          result = await _client.from('curriculum_days').insert(data).select().single();
        }

        await _isar.writeTxn(() async {
          day.remoteId = result['id'];
          day.pendingSync = false;
          await _isar.curriculumDayLocals.put(day);
        });
      } catch (_) {
        // Retry later
      }
    }
  }

  // Pulling remote state
  Future<void> _pullWorkoutPlans() async {
    try {
      final plans = await _client.from('workout_plans').select();
      await _isar.writeTxn(() async {
        await _isar.workoutPlanLocals.clear();
        await _isar.workoutPlanLocals.putAll(
          plans.map((p) => WorkoutPlanLocal.fromJson(p)).toList(),
        );
      });
    } catch (_) {}
  }

  Future<void> _pullPreferences(String userId) async {
    try {
      final prefs = await _client
          .from('user_preferences')
          .select()
          .eq('user_id', userId)
          .maybeSingle();
      if (prefs == null) return;
      
      final existing = await _isar.userPreferencesLocals
          .filter()
          .userIdEqualTo(userId)
          .findFirst();

      if (existing == null || existing.pendingSync == false) {
        await _isar.writeTxn(() async {
          final local = UserPreferencesLocal.fromJson(prefs);
          if (existing != null) {
            local.id = existing.id;
          }
          await _isar.userPreferencesLocals.put(local);
        });
      }
    } catch (_) {}
  }

  Future<void> _pullLearningGoals(String userId) async {
    try {
      final goals = await _client
          .from('learning_goals')
          .select()
          .eq('user_id', userId);

      await _isar.writeTxn(() async {
        for (final remote in goals) {
          final existing = await _isar.learningGoalLocals
              .filter()
              .remoteIdEqualTo(remote['id'] as String)
              .findFirst();
          
          if (existing == null) {
            await _isar.learningGoalLocals.put(LearningGoalLocal.fromJson(remote));
          } else if (existing.pendingSync == false) {
            await _isar.learningGoalLocals.put(LearningGoalLocal.fromJson(remote)..id = existing.id);
          }
        }
      });
    } catch (_) {}
  }

  Future<void> _pullLearningLogs(String userId) async {
    try {
      final logs = await _client
          .from('learning_logs')
          .select()
          .eq('user_id', userId);

      await _isar.writeTxn(() async {
        for (final remote in logs) {
          final existing = await _isar.learningLogLocals
              .filter()
              .remoteIdEqualTo(remote['id'] as String)
              .findFirst();

          if (existing == null) {
            final local = LearningLogLocal()
              ..remoteId = remote['id']
              ..userId = remote['user_id']
              ..curriculumDayId = remote['curriculum_day_id']
              ..goalId = remote['goal_id']
              ..loggedDate = DateTime.parse(remote['logged_date'])
              ..durationMin = remote['duration_min'] as int? ?? 0
              ..completed = remote['completed'] as bool? ?? false
              ..notes = remote['notes']
              ..difficulty = remote['difficulty']
              ..updatedAt = DateTime.parse(remote['updated_at'] ?? remote['created_at'])
              ..pendingSync = false;
            await _isar.learningLogLocals.put(local);
          }
        }
      });
    } catch (_) {}
  }

  Future<void> _pullCurriculumDays(String userId) async {
    try {
      final goalResult = await _client
          .from('learning_goals')
          .select()
          .eq('user_id', userId)
          .eq('status', 'active')
          .maybeSingle();
      if (goalResult == null) return;

      final serverDays = await _client
          .from('curriculum_days')
          .select()
          .eq('goal_id', goalResult['id']);

      await _isar.writeTxn(() async {
        for (final serverDay in serverDays) {
          final serverTs = DateTime.parse(
            serverDay['updated_at'] ?? serverDay['created_at'],
          );

          final existing = await _isar.curriculumDayLocals
              .filter()
              .goalIdEqualTo(goalResult['id'] as String)
              .weekNumberEqualTo(serverDay['week_number'] as int)
              .dayNumberEqualTo(serverDay['day_number'] as int)
              .findFirst();

          if (existing == null) {
            await _isar.curriculumDayLocals.put(CurriculumDayLocal.fromJson(serverDay));
          } else if (existing.pendingSync == false && serverTs.isAfter(existing.updatedAt)) {
            await _isar.curriculumDayLocals.put(CurriculumDayLocal.fromJson(serverDay)..id = existing.id);
          }
        }
      });
    } catch (_) {}
  }

  // Public triggers to sync single items immediately in background
  Future<void> pushPreferences(String userId) async {
    await _pushPendingPreferences(userId);
  }

  Future<void> pushHealthLog(String userId) async {
    await _pushPendingHealthLogs(userId);
  }

  Future<void> pushWorkoutLog(String userId) async {
    await _pushPendingWorkoutLogs(userId);
  }

  Future<void> pushLearningLog(String userId) async {
    await _pushPendingLearningLogs(userId);
  }

  Future<void> pushCurriculumDay(CurriculumDayLocal day) async {
    try {
      final data = {
        'goal_id': day.goalId,
        'week_number': day.weekNumber,
        'day_number': day.dayNumber,
        'topic': day.topic,
        'description': day.description,
        'practical_task': day.practicalTask,
        'resources': jsonDecode(day.resources),
        'estimated_min': day.estimatedMin,
        'calendar_date': day.calendarDate?.toIso8601String().substring(0, 10),
        'energy_level': day.energyLevel,
      };

      Map<String, dynamic> result;
      if (day.remoteId.isNotEmpty) {
        result = await _client.from('curriculum_days').update(data).eq('id', day.remoteId).select().single();
      } else {
        result = await _client.from('curriculum_days').insert(data).select().single();
      }

      await _isar.writeTxn(() async {
        day.remoteId = result['id'];
        day.pendingSync = false;
        await _isar.curriculumDayLocals.put(day);
      });
    } catch (_) {}
  }
}
