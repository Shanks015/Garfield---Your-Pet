import 'package:isar/isar.dart';

part 'pet_event_collection.g.dart';

@collection
class PetEventLocal {
  Id id = Isar.autoIncrement;
  late String message;
  late DateTime createdAt;
  late String animation;
}
