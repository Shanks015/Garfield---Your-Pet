import 'dart:convert';
import 'package:isar/isar.dart';

part 'curriculum_day_collection.g.dart';

@collection
class CurriculumDayLocal {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String remoteId;

  @Index()
  late String goalId;

  late int weekNumber;
  late int dayNumber;
  late String topic;
  late String description;
  late String practicalTask;
  late String resources; // JSON string
  late int estimatedMin;
  DateTime? calendarDate;
  String? energyLevel; // 'high' | 'normal' | 'low'
  late DateTime updatedAt;
  bool pendingSync = true;

  static CurriculumDayLocal fromJson(Map<String, dynamic> json, {String? goalId}) {
    return CurriculumDayLocal()
      ..remoteId = json['id'] as String? ?? ''
      ..goalId = goalId ?? (json['goal_id'] as String? ?? '')
      ..weekNumber = json['week_number'] as int
      ..dayNumber = json['day_number'] as int
      ..topic = json['topic'] as String
      ..description = json['description'] as String
      ..practicalTask = json['practical_task'] as String
      ..resources = json['resources'] is String 
          ? json['resources'] as String 
          : jsonEncode(json['resources'])
      ..estimatedMin = json['estimated_min'] as int? ?? 60
      ..calendarDate = json['calendar_date'] != null 
          ? DateTime.parse(json['calendar_date'] as String) 
          : null
      ..energyLevel = json['energy_level'] as String?
      ..updatedAt = json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String)
          : (json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : DateTime.now())
      ..pendingSync = false;
  }
}
