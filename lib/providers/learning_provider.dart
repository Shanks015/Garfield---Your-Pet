import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:flowday/local/collections/learning_goal_collection.dart';
import 'package:flowday/local/collections/curriculum_day_collection.dart';
import 'package:flowday/local/collections/learning_log_collection.dart';
import 'package:flowday/providers/isar_provider.dart';
import 'package:flowday/providers/auth_provider.dart';
import 'package:flowday/services/sync_service.dart';
import 'package:flowday/services/notification_service.dart';

final activeGoalProvider = StreamProvider<LearningGoalLocal?>((ref) {
  final isar = ref.watch(isarProvider);
  return isar.learningGoalLocals
      .filter()
      .statusEqualTo('active')
      .watch(fireImmediately: true)
      .map((list) => list.isEmpty ? null : list.first);
});

final curriculumDaysProvider = StreamProvider<List<CurriculumDayLocal>>((ref) {
  final isar = ref.watch(isarProvider);
  final activeGoal = ref.watch(activeGoalProvider).valueOrNull;
  if (activeGoal == null) {
    return const Stream.empty();
  }

  final goalKey = activeGoal.remoteId.isNotEmpty ? activeGoal.remoteId : activeGoal.id.toString();
  return isar.curriculumDayLocals
      .filter()
      .goalIdEqualTo(goalKey)
      .sortByWeekNumber()
      .thenByDayNumber()
      .watch(fireImmediately: true);
});

final learningLogsProvider = StreamProvider<List<LearningLogLocal>>((ref) {
  final isar = ref.watch(isarProvider);
  final activeGoal = ref.watch(activeGoalProvider).valueOrNull;
  if (activeGoal == null) {
    return const Stream.empty();
  }

  final goalKey = activeGoal.remoteId.isNotEmpty ? activeGoal.remoteId : activeGoal.id.toString();
  return isar.learningLogLocals
      .filter()
      .goalIdEqualTo(goalKey)
      .sortByLoggedDateDesc()
      .watch(fireImmediately: true);
});

final learningActionsProvider = Provider((ref) {
  final isar = ref.watch(isarProvider);
  final user = ref.watch(currentUserProvider);
  final syncService = ref.read(syncServiceProvider);
  final notificationService = ref.read(notificationServiceProvider);

  return LearningActions(isar, user?.id, syncService, notificationService);
});

class LearningActions {
  final Isar _isar;
  final String? _userId;
  final SyncService _syncService;
  final NotificationService _notificationService;

  LearningActions(this._isar, this._userId, this._syncService, this._notificationService);

  Future<LearningGoalLocal?> createGoal({
    required String title,
    String? description,
    required int targetWeeks,
  }) async {
    if (_userId == null) return null;

    final goal = LearningGoalLocal()
      ..remoteId = ''
      ..userId = _userId!
      ..title = title
      ..description = description
      ..startDate = DateTime.now()
      ..targetWeeks = targetWeeks
      ..status = 'active'
      ..updatedAt = DateTime.now()
      ..pendingSync = true;

    // Set any pre-existing active goals to completed or paused
    await _isar.writeTxn(() async {
      final activeGoals = await _isar.learningGoalLocals
          .filter()
          .statusEqualTo('active')
          .findAll();
      for (final active in activeGoals) {
        active.status = 'completed';
        active.updatedAt = DateTime.now();
        active.pendingSync = true;
        await _isar.learningGoalLocals.put(active);
      }
      await _isar.learningGoalLocals.put(goal);
    });

    // Background push
    _syncService.syncAll(_userId!);

    // Trigger companion pet notification
    _notificationService.triggerPetNotification('New goal created: $title! 📚 Ready to study!', 'alert');

    return goal;
  }

  Future<void> logLearningSession({
    required String curriculumDayId,
    required String goalId,
    required int durationMin,
    required bool completed,
    String? notes,
    String? difficulty,
  }) async {
    if (_userId == null) return;

    final log = LearningLogLocal()
      ..remoteId = ''
      ..userId = _userId!
      ..curriculumDayId = curriculumDayId
      ..goalId = goalId
      ..loggedDate = DateTime.now()
      ..durationMin = durationMin
      ..completed = completed
      ..notes = notes;
      
    log.difficulty = difficulty;
    log.updatedAt = DateTime.now();
    log.pendingSync = true;

    await _isar.writeTxn(() async {
      await _isar.learningLogLocals.put(log);
    });

    // Background push
    _syncService.pushLearningLog(_userId!);

    // Trigger companion pet notification
    _notificationService.triggerPetNotification('Session logged! Knowledge points +1! 🧠', 'happy');
  }
}
