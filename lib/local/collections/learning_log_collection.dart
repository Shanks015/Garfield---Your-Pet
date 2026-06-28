import 'package:isar/isar.dart';

part 'learning_log_collection.g.dart';

@collection
class LearningLogLocal {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String remoteId;

  late String userId;
  String? curriculumDayId;
  late String goalId;
  late DateTime loggedDate;
  late int durationMin;
  late bool completed;
  String? notes;
  String? difficulty; // 'easy' | 'right' | 'hard'
  late DateTime updatedAt;
  bool pendingSync = true;
}
