import 'package:isar/isar.dart';

part 'workout_log_collection.g.dart';

@collection
class WorkoutLogLocal {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String remoteId;

  late String userId;
  late int planDayIndex;
  late DateTime completedAt;
  int? durationMin;
  String? exercisesDone; // JSON string
  String? notes;
  late DateTime updatedAt;
  bool pendingSync = true;
}
