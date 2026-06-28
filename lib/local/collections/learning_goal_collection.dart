import 'package:isar/isar.dart';

part 'learning_goal_collection.g.dart';

@collection
class LearningGoalLocal {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String remoteId;

  late String userId;
  late String title;
  String? description;
  late DateTime startDate;
  late int targetWeeks;
  late String status; // 'active' | 'paused' | 'completed'
  late DateTime updatedAt;
  bool pendingSync = true;

  static LearningGoalLocal fromJson(Map<String, dynamic> json) {
    return LearningGoalLocal()
      ..remoteId = json['id'] as String
      ..userId = json['user_id'] as String
      ..title = json['title'] as String
      ..description = json['description'] as String?
      ..startDate = json['start_date'] != null 
          ? DateTime.parse(json['start_date'] as String) 
          : DateTime.now()
      ..targetWeeks = json['target_weeks'] as int? ?? 16
      ..status = json['status'] as String? ?? 'active'
      ..updatedAt = json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String)
          : (json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : DateTime.now())
      ..pendingSync = false;
  }
}
