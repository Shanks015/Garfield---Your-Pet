import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flowday/providers/supabase_provider.dart';

final supabaseServiceProvider = Provider<SupabaseService>((ref) {
  return SupabaseService(ref.watch(supabaseClientProvider));
});

class SupabaseService {
  final SupabaseClient _client;
  SupabaseService(this._client);

  Future<Map<String, dynamic>?> fetchPreferences(String userId) async {
    return await _client
        .from('user_preferences')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
  }

  Future<void> upsertPreferences(Map<String, dynamic> prefs) async {
    await _client.from('user_preferences').upsert(prefs);
  }

  Future<void> pushHealthLog(Map<String, dynamic> log) async {
    await _client.from('health_logs').upsert(log);
  }

  Future<List<Map<String, dynamic>>> fetchWorkoutPlans() async {
    final list = await _client.from('workout_plans').select();
    return List<Map<String, dynamic>>.from(list);
  }

  Future<void> pushWorkoutLog(Map<String, dynamic> log) async {
    await _client.from('workout_logs').upsert(log);
  }

  Future<Map<String, dynamic>?> fetchActiveGoal(String userId) async {
    return await _client
        .from('learning_goals')
        .select()
        .eq('user_id', userId)
        .eq('status', 'active')
        .maybeSingle();
  }

  Future<void> saveGoal(Map<String, dynamic> goal) async {
    await _client.from('learning_goals').upsert(goal);
  }

  Future<void> saveCurriculumDays(List<Map<String, dynamic>> days) async {
    await _client.from('curriculum_days').upsert(days);
  }

  Future<List<Map<String, dynamic>>> fetchCurriculumDays(String goalId) async {
    final list = await _client
        .from('curriculum_days')
        .select()
        .eq('goal_id', goalId);
    return List<Map<String, dynamic>>.from(list);
  }

  Future<void> pushLearningLog(Map<String, dynamic> log) async {
    await _client.from('learning_logs').upsert(log);
  }
}
