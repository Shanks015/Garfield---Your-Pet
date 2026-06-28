import 'package:isar/isar.dart';

part 'user_preferences_collection.g.dart';

@collection
class UserPreferencesLocal {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String remoteId;

  late String userId;
  late int waterIntervalMin;
  late int breakIntervalMin;
  late int walkIntervalMin;
  late int exerciseReminderHour;
  late int workStartHour;
  late int workEndHour;
  late DateTime updatedAt;
  bool pendingSync = true;

  static UserPreferencesLocal fromJson(Map<String, dynamic> json) {
    return UserPreferencesLocal()
      ..remoteId = json['id'] as String
      ..userId = json['user_id'] as String
      ..waterIntervalMin = json['water_interval_min'] as int? ?? 45
      ..breakIntervalMin = json['break_interval_min'] as int? ?? 60
      ..walkIntervalMin = json['walk_interval_min'] as int? ?? 90
      ..exerciseReminderHour = json['exercise_reminder_hour'] as int? ?? 18
      ..workStartHour = json['work_start_hour'] as int? ?? 9
      ..workEndHour = json['work_end_hour'] as int? ?? 18
      ..updatedAt = json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String)
          : (json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : DateTime.now())
      ..pendingSync = false;
  }
}
