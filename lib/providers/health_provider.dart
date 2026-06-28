import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:flowday/local/collections/health_log_collection.dart';
import 'package:flowday/providers/isar_provider.dart';
import 'package:flowday/providers/auth_provider.dart';
import 'package:flowday/services/sync_service.dart';
import 'package:flowday/services/notification_service.dart';

final todayHealthLogsProvider = StreamProvider<List<HealthLogLocal>>((ref) {
  final isar = ref.watch(isarProvider);
  final today = DateTime.now();
  final start = DateTime(today.year, today.month, today.day);
  final end = DateTime(today.year, today.month, today.day, 23, 59, 59);

  return isar.healthLogLocals
      .filter()
      .loggedAtBetween(start, end)
      .watch(fireImmediately: true);
});

final healthActionsProvider = Provider((ref) {
  final isar = ref.watch(isarProvider);
  final user = ref.watch(currentUserProvider);
  final syncService = ref.read(syncServiceProvider);
  final notificationService = ref.read(notificationServiceProvider);

  return HealthActions(isar, user?.id, syncService, notificationService);
});

class HealthActions {
  final Isar _isar;
  final String? _userId;
  final SyncService _syncService;
  final NotificationService _notificationService;

  HealthActions(this._isar, this._userId, this._syncService, this._notificationService);

  Future<void> logMetric(String type, {String? notes}) async {
    if (_userId == null) return;

    final log = HealthLogLocal()
      ..remoteId = ''
      ..userId = _userId!
      ..logType = type
      ..loggedAt = DateTime.now()
      ..notes = notes
      ..updatedAt = DateTime.now()
      ..pendingSync = true;

    await _isar.writeTxn(() async {
      await _isar.healthLogLocals.put(log);
    });

    // Fire background sync
    _syncService.pushHealthLog(_userId!);

    // Notify companion pet
    String message = 'Logged $type! Keep it up!';
    if (type == 'water') {
      message = 'Gulp gulp! Water logged! 💧';
    } else if (type == 'break') {
      message = 'Resting time! Break logged! ☕';
    } else if (type == 'walk') {
      message = 'Nice steps! Walk logged! 🚶';
    }
    _notificationService.triggerPetNotification(message, 'happy');
  }
}
