import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:flowday/local/collections/user_preferences_collection.dart';
import 'package:flowday/providers/isar_provider.dart';
import 'package:flowday/providers/auth_provider.dart';
import 'package:flowday/services/sync_service.dart';

final userPreferencesProvider = StreamProvider<UserPreferencesLocal?>((ref) {
  final isar = ref.watch(isarProvider);
  final user = ref.watch(currentUserProvider);
  if (user == null) {
    return const Stream.empty();
  }

  return isar.userPreferencesLocals
      .filter()
      .userIdEqualTo(user.id)
      .watch(fireImmediately: true)
      .map((list) => list.isEmpty ? null : list.first);
});

final preferencesActionsProvider = Provider((ref) {
  final isar = ref.watch(isarProvider);
  final user = ref.watch(currentUserProvider);
  final syncService = ref.read(syncServiceProvider);

  return PreferencesActions(isar, user?.id, syncService);
});

class PreferencesActions {
  final Isar _isar;
  final String? _userId;
  final SyncService _syncService;

  PreferencesActions(this._isar, this._userId, this._syncService);

  Future<void> seedDefaultPreferences() async {
    if (_userId == null) return;

    final existing = await _isar.userPreferencesLocals
        .filter()
        .userIdEqualTo(_userId!)
        .findFirst();

    if (existing == null) {
      final prefs = UserPreferencesLocal()
        ..remoteId = ''
        ..userId = _userId!
        ..waterIntervalMin = 45
        ..breakIntervalMin = 60
        ..walkIntervalMin = 90
        ..exerciseReminderHour = 18
        ..workStartHour = 9
        ..workEndHour = 18
        ..updatedAt = DateTime.now()
        ..pendingSync = true;

      await _isar.writeTxn(() async {
        await _isar.userPreferencesLocals.put(prefs);
      });

      _syncService.pushPreferences(_userId!);
    }
  }

  Future<void> updatePreferences({
    required int waterIntervalMin,
    required int breakIntervalMin,
    required int walkIntervalMin,
    required int exerciseReminderHour,
    required int workStartHour,
    required int workEndHour,
  }) async {
    if (_userId == null) return;

    var prefs = await _isar.userPreferencesLocals
        .filter()
        .userIdEqualTo(_userId!)
        .findFirst();

    prefs ??= UserPreferencesLocal()
      ..remoteId = ''
      ..userId = _userId!;

    prefs
      ..waterIntervalMin = waterIntervalMin
      ..breakIntervalMin = breakIntervalMin
      ..walkIntervalMin = walkIntervalMin
      ..exerciseReminderHour = exerciseReminderHour
      ..workStartHour = workStartHour
      ..workEndHour = workEndHour
      ..updatedAt = DateTime.now()
      ..pendingSync = true;

    await _isar.writeTxn(() async {
      await _isar.userPreferencesLocals.put(prefs!);
    });

    _syncService.pushPreferences(_userId!);
  }
}
