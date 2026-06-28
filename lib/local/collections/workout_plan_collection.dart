import 'dart:convert';
import 'package:isar/isar.dart';

part 'workout_plan_collection.g.dart';

@collection
class WorkoutPlanLocal {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String remoteId;

  late String dayLabel;
  late int dayIndex;
  late String focus;
  late String exercises; // JSON string
  late DateTime updatedAt;
  bool pendingSync = true;

  static WorkoutPlanLocal fromJson(Map<String, dynamic> json) {
    return WorkoutPlanLocal()
      ..remoteId = json['id'] as String
      ..dayLabel = json['day_label'] as String
      ..dayIndex = json['day_index'] as int
      ..focus = json['focus'] as String
      ..exercises = json['exercises'] is String 
          ? json['exercises'] as String 
          : jsonEncode(json['exercises'])
      ..updatedAt = json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String) 
          : DateTime.now()
      ..pendingSync = false;
  }
}
