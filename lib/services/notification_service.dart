import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flowday/local/collections/pet_event_collection.dart';
import 'package:flowday/local/collections/user_preferences_collection.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flowday/services/presence_service.dart';
import 'package:flowday/local/collections/health_log_collection.dart';
import 'package:flowday/services/sync_service.dart';
import 'package:flowday/providers/isar_provider.dart';
import 'package:flowday/providers/auth_provider.dart';
import 'package:isar/isar.dart';

import 'package:window_manager/window_manager.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  final ns = NotificationService();
  final ps = ref.watch(presenceServiceProvider);
  ns.attachPresence(ps);

  ref.listen(currentUserProvider, (_, user) {
    if (user != null) {
      final isar = ref.read(isarProvider);
      final syncService = ref.read(syncServiceProvider);
      ns.initDependencies(isar: isar, syncService: syncService, userId: user.id);
    }
  }, fireImmediately: true);

  return ns;
});

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  PresenceService? _presenceService;
  Isar? _isar;
  SyncService? _syncService;
  String? _userId;

  Timer? _petReminderTimer;
  final Map<String, DateTime> _lastTriggeredReminders = {};

  void attachPresence(PresenceService ps) => _presenceService = ps;
  
  void initDependencies({required Isar isar, required SyncService syncService, required String userId}) {
    _isar = isar;
    _syncService = syncService;
    _userId = userId;
    startPetReminderChecking();
  }

  void startPetReminderChecking() {
    _petReminderTimer?.cancel();
    _petReminderTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkAndTriggerPetReminders();
    });
    // Run once after 5 seconds to check reminders on startup
    Timer(const Duration(seconds: 5), () {
      _checkAndTriggerPetReminders();
    });
  }

  Future<void> _checkAndTriggerPetReminders() async {
    if (_isar == null || _userId == null) return;
    
    try {
      final prefs = await _isar!.userPreferencesLocals.filter().userIdEqualTo(_userId!).findFirst();
      if (prefs == null) return;

      final now = DateTime.now();
      final startOfToday = DateTime(now.year, now.month, now.day);
      
      // Helper function to check interval-based reminders
      Future<void> checkIntervalReminder(String logType, int intervalMin, String message, String animation) async {
        if (intervalMin <= 0) return;
        
        final lastLog = await _isar!.healthLogLocals
            .filter()
            .userIdEqualTo(_userId!)
            .and()
            .logTypeEqualTo(logType)
            .sortByLoggedAtDesc()
            .findFirst();
            
        DateTime lastActionTime = lastLog?.loggedAt ?? now.subtract(Duration(minutes: intervalMin));
        
        final lastTriggered = _lastTriggeredReminders[logType];
        if (lastTriggered != null && lastTriggered.isAfter(lastActionTime)) {
          lastActionTime = lastTriggered;
        }
        
        if (now.difference(lastActionTime).inMinutes >= intervalMin) {
          await triggerPetNotification(message, animation);
          _lastTriggeredReminders[logType] = now;
        }
      }

      // Check Water
      await checkIntervalReminder('water', prefs.waterIntervalMin, 'Time to drink water! 💧 Stay hydrated!', 'water_reminder');

      // Check Walk
      await checkIntervalReminder('walk', prefs.walkIntervalMin, 'Time to stretch and walk around! 🚶', 'walk_reminder');

      // Check Break/Rest
      await checkIntervalReminder('break', prefs.breakIntervalMin, 'Time to take a screen break! ☕', 'break_reminder');

      // Daily Exercise check (exerciseReminderHour)
      final exerciseHour = prefs.exerciseReminderHour;
      final lastExerciseTrigger = _lastTriggeredReminders['exercise'];
      final exerciseTriggeredToday = lastExerciseTrigger != null &&
          lastExerciseTrigger.year == now.year &&
          lastExerciseTrigger.month == now.month &&
          lastExerciseTrigger.day == now.day;
          
      if (now.hour >= exerciseHour && !exerciseTriggeredToday) {
        final todayWorkoutLog = await _isar!.healthLogLocals
            .filter()
            .userIdEqualTo(_userId!)
            .and()
            .logTypeEqualTo('workout')
            .and()
            .loggedAtGreaterThan(startOfToday)
            .findFirst();
            
        if (todayWorkoutLog == null) {
          await triggerPetNotification('Time for your daily workout! 💪 Let\'s exercise!', 'workout_reminder');
          _lastTriggeredReminders['exercise'] = now;
        }
      }

      // Daily Study/Work check (workStartHour)
      final studyStartHour = prefs.workStartHour;
      final lastStudyTrigger = _lastTriggeredReminders['study'];
      final studyTriggeredToday = lastStudyTrigger != null &&
          lastStudyTrigger.year == now.year &&
          lastStudyTrigger.month == now.month &&
          lastStudyTrigger.day == now.day;
          
      if (now.hour >= studyStartHour && now.hour < prefs.workEndHour && !studyTriggeredToday) {
        await triggerPetNotification('Study time starts now! 📚 Focus and do your best!', 'study_reminder');
        _lastTriggeredReminders['study'] = now;
      }

    } catch (e) {
      debugPrint('Error checking pet reminders: $e');
    }
  }

  Future<void> initialize() async {
    tz.initializeTimeZones();
    
    const AndroidInitializationSettings android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios, macOS: ios),
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    _startMainAppSocketServer();
  }

  void _startMainAppSocketServer() async {
    try {
      final server = await ServerSocket.bind('127.0.0.1', 50506);
      debugPrint('Main App Socket Server listening on port 50506');
      server.listen((Socket client) {
        client.listen((List<int> data) async {
          try {
            final payload = utf8.decode(data);
            final map = jsonDecode(payload);
            if (map['action'] == 'reset_intervals') {
              debugPrint('Received reset_intervals command from FlowCat');
              await resetReminders();
            } else if (map['action'] == 'show_main_app') {
              debugPrint('Received show_main_app command from FlowCat');
              await windowManager.show();
              await windowManager.focus();
            }
          } catch (e) {
            debugPrint('Error parsing command from FlowCat: $e');
          }
        });
      });
    } catch (e) {
      debugPrint('Failed to start Main App socket server (already running/bound): $e');
    }
  }

  Future<void> resetReminders() async {
    if (_isar == null || _userId == null) return;

    try {
      // Find current user preferences
      final prefs = await _isar!.userPreferencesLocals.filter().userIdEqualTo(_userId!).findFirst();
      if (prefs != null) {
        await cancelAll();
        await scheduleWaterReminder(prefs.waterIntervalMin);
        await scheduleBreakReminder(prefs.breakIntervalMin);
        await scheduleWalkReminder(prefs.walkIntervalMin);
        debugPrint('Rescheduled reminders: Water (${prefs.waterIntervalMin}m), Break (${prefs.breakIntervalMin}m), Walk (${prefs.walkIntervalMin}m)');
        
        // Push a success status back to pet window
        triggerPetNotification('All reminder intervals reset! ⏰', 'happy');
      }
    } catch (e) {
      debugPrint('Error resetting reminders: $e');
    }
  }

  bool _canFire() => _presenceService?.shouldFireNotification ?? true;

  Future<void> scheduleWaterReminder(int intervalMinutes) async {
    if (!_canFire()) return;

    final androidDetails = AndroidNotificationDetails(
      'water_channel', 'Water Reminders',
      channelDescription: 'Reminders to stay hydrated',
      importance: Importance.max,
      priority: Priority.high,
      actions: <AndroidNotificationAction>[
        const AndroidNotificationAction('done_water', '✓ Done'),
        const AndroidNotificationAction('snooze_water', '⏰ Snooze 10 min'),
      ],
    );

    const iosDetails = DarwinNotificationDetails(
      categoryIdentifier: 'water_category',
    );

    await _plugin.zonedSchedule(
      1001,
      'Drink Water 💧',
      'Time to take a sip and log your water intake.',
      tz.TZDateTime.now(tz.local).add(Duration(minutes: intervalMinutes)),
      NotificationDetails(android: androidDetails, iOS: iosDetails, macOS: iosDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleBreakReminder(int intervalMinutes) async {
    if (!_canFire()) return;

    final androidDetails = AndroidNotificationDetails(
      'break_channel', 'Break Reminders',
      channelDescription: 'Reminders to take short breaks from screens',
      importance: Importance.max,
      priority: Priority.high,
      actions: <AndroidNotificationAction>[
        const AndroidNotificationAction('done_break', '✓ Done'),
        const AndroidNotificationAction('snooze_break', '⏰ Snooze 10 min'),
      ],
    );

    const iosDetails = DarwinNotificationDetails(
      categoryIdentifier: 'break_category',
    );

    await _plugin.zonedSchedule(
      1002,
      'Take a Break ☕',
      'Step away from your screen. Rest your eyes for a moment.',
      tz.TZDateTime.now(tz.local).add(Duration(minutes: intervalMinutes)),
      NotificationDetails(android: androidDetails, iOS: iosDetails, macOS: iosDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleWalkReminder(int intervalMinutes) async {
    if (!_canFire()) return;

    final androidDetails = AndroidNotificationDetails(
      'walk_channel', 'Walk Reminders',
      channelDescription: 'Reminders to walk around',
      importance: Importance.max,
      priority: Priority.high,
      actions: <AndroidNotificationAction>[
        const AndroidNotificationAction('done_walk', '✓ Done'),
        const AndroidNotificationAction('snooze_walk', '⏰ Snooze 10 min'),
      ],
    );

    const iosDetails = DarwinNotificationDetails(
      categoryIdentifier: 'walk_category',
    );

    await _plugin.zonedSchedule(
      1003,
      'Walk Around 🚶',
      'Stand up, stretch your legs, and walk for a few minutes.',
      tz.TZDateTime.now(tz.local).add(Duration(minutes: intervalMinutes)),
      NotificationDetails(android: androidDetails, iOS: iosDetails, macOS: iosDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleExerciseReminder(int hour) async {
    // Exercise reminders fire regardless of active device (requested behaviour)
    final androidDetails = const AndroidNotificationDetails(
      'exercise_channel', 'Exercise Reminders',
      channelDescription: 'Daily evening workout reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      categoryIdentifier: 'exercise_category',
    );

    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, 0);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      1004,
      'Time to Train! 💪',
      'Evening workout session is waiting. Start your daily routine.',
      scheduledDate,
      NotificationDetails(android: androidDetails, iOS: iosDetails, macOS: iosDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> showLearningNudge() async {
    final androidDetails = const AndroidNotificationDetails(
      'learning_channel', 'Learning Reminders',
      channelDescription: 'Nudges to study your daily topic',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    await _plugin.zonedSchedule(
      1005,
      'Ready to Learn? 📚',
      'You finished your workout! Set aside some time for your learning curriculum.',
      tz.TZDateTime.now(tz.local).add(const Duration(minutes: 5)),
      NotificationDetails(android: androidDetails, iOS: iosDetails, macOS: iosDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelAll() async => await _plugin.cancelAll();

  void _onNotificationTap(NotificationResponse response) {
    final actionId = response.actionId;
    if (actionId == null) return;

    if (actionId.startsWith('done_')) {
      final type = actionId.replaceFirst('done_', '');
      _logAndNavigate(type);
    } else if (actionId.startsWith('snooze_')) {
      final type = actionId.replaceFirst('snooze_', '');
      _rescheduleSnooze(type);
    }
  }

  Future<void> _rescheduleSnooze(String type) async {
    debugPrint('Rescheduling snooze for 10 minutes: $type');
    if (type == 'water') {
      await scheduleWaterReminder(10);
    } else if (type == 'break') {
      await scheduleBreakReminder(10);
    } else if (type == 'walk') {
      await scheduleWalkReminder(10);
    }
  }

  Future<void> _logAndNavigate(String type) async {
    if (_isar == null || _userId == null) return;

    final log = HealthLogLocal()
      ..remoteId = ''
      ..userId = _userId!
      ..logType = type
      ..loggedAt = DateTime.now()
      ..updatedAt = DateTime.now()
      ..pendingSync = true;

    await _isar!.writeTxn(() async {
      await _isar!.healthLogLocals.put(log);
    });

    if (_syncService != null) {
      _syncService!.pushHealthLog(_userId!);
    }
    
    // Auto-trigger pet event when logged via notification click
    triggerPetNotification('Logged $type! 🌟', 'happy');
  }

  Future<void> triggerPetNotification(String msg, String animation) async {
    if (_isar == null) return;

    final event = PetEventLocal()
      ..message = msg
      ..animation = animation
      ..createdAt = DateTime.now();

    try {
      await _isar!.writeTxn(() async {
        await _isar!.petEventLocals.put(event);
      });
    } catch (e) {
      debugPrint('Error writing pet event to main Isar: $e');
    }

    // Attempt to broadcast over TCP loopback to the separate FlowCat pet window
    try {
      final socket = await Socket.connect('127.0.0.1', 50505, timeout: const Duration(milliseconds: 500));
      final payload = jsonEncode({
        'message': msg,
        'animation': animation,
        'createdAt': event.createdAt.toIso8601String(),
      });
      socket.write(payload);
      await socket.flush();
      await socket.close();
      debugPrint('Broadcasted pet notification to FlowCat window socket: $msg');
    } catch (e) {
      // Catch silently if pet window is closed
      debugPrint('FlowCat companion window is not listening: $e');
    }
  }
}
