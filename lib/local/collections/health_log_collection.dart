import 'package:isar/isar.dart';

part 'health_log_collection.g.dart';

@collection
class HealthLogLocal {
  Id id = Isar.autoIncrement;
  
  @Index(unique: true, replace: true)
  late String remoteId;      // Supabase UUID, empty string until synced
  
  late String userId;
  late String logType;       // 'water' | 'break' | 'walk' | 'exercise'
  late DateTime loggedAt;
  String? notes;
  String? syncedFromDevice;  // 'desktop' or 'mobile'
  late DateTime updatedAt;   // set to DateTime.now() on every local write
  bool pendingSync = true;   // cleared to false only after Supabase confirms the push
}
