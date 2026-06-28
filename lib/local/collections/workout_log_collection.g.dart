// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_log_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWorkoutLogLocalCollection on Isar {
  IsarCollection<WorkoutLogLocal> get workoutLogLocals => this.collection();
}

const WorkoutLogLocalSchema = CollectionSchema(
  name: r'WorkoutLogLocal',
  id: 1209875899708416989,
  properties: {
    r'completedAt': PropertySchema(
      id: 0,
      name: r'completedAt',
      type: IsarType.dateTime,
    ),
    r'durationMin': PropertySchema(
      id: 1,
      name: r'durationMin',
      type: IsarType.long,
    ),
    r'exercisesDone': PropertySchema(
      id: 2,
      name: r'exercisesDone',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 3,
      name: r'notes',
      type: IsarType.string,
    ),
    r'pendingSync': PropertySchema(
      id: 4,
      name: r'pendingSync',
      type: IsarType.bool,
    ),
    r'planDayIndex': PropertySchema(
      id: 5,
      name: r'planDayIndex',
      type: IsarType.long,
    ),
    r'remoteId': PropertySchema(
      id: 6,
      name: r'remoteId',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 7,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'userId': PropertySchema(
      id: 8,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _workoutLogLocalEstimateSize,
  serialize: _workoutLogLocalSerialize,
  deserialize: _workoutLogLocalDeserialize,
  deserializeProp: _workoutLogLocalDeserializeProp,
  idName: r'id',
  indexes: {
    r'remoteId': IndexSchema(
      id: 6301175856541681032,
      name: r'remoteId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'remoteId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _workoutLogLocalGetId,
  getLinks: _workoutLogLocalGetLinks,
  attach: _workoutLogLocalAttach,
  version: '3.1.0+1',
);

int _workoutLogLocalEstimateSize(
  WorkoutLogLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.exercisesDone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.remoteId.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _workoutLogLocalSerialize(
  WorkoutLogLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.completedAt);
  writer.writeLong(offsets[1], object.durationMin);
  writer.writeString(offsets[2], object.exercisesDone);
  writer.writeString(offsets[3], object.notes);
  writer.writeBool(offsets[4], object.pendingSync);
  writer.writeLong(offsets[5], object.planDayIndex);
  writer.writeString(offsets[6], object.remoteId);
  writer.writeDateTime(offsets[7], object.updatedAt);
  writer.writeString(offsets[8], object.userId);
}

WorkoutLogLocal _workoutLogLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkoutLogLocal();
  object.completedAt = reader.readDateTime(offsets[0]);
  object.durationMin = reader.readLongOrNull(offsets[1]);
  object.exercisesDone = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.notes = reader.readStringOrNull(offsets[3]);
  object.pendingSync = reader.readBool(offsets[4]);
  object.planDayIndex = reader.readLong(offsets[5]);
  object.remoteId = reader.readString(offsets[6]);
  object.updatedAt = reader.readDateTime(offsets[7]);
  object.userId = reader.readString(offsets[8]);
  return object;
}

P _workoutLogLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _workoutLogLocalGetId(WorkoutLogLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _workoutLogLocalGetLinks(WorkoutLogLocal object) {
  return [];
}

void _workoutLogLocalAttach(
    IsarCollection<dynamic> col, Id id, WorkoutLogLocal object) {
  object.id = id;
}

extension WorkoutLogLocalByIndex on IsarCollection<WorkoutLogLocal> {
  Future<WorkoutLogLocal?> getByRemoteId(String remoteId) {
    return getByIndex(r'remoteId', [remoteId]);
  }

  WorkoutLogLocal? getByRemoteIdSync(String remoteId) {
    return getByIndexSync(r'remoteId', [remoteId]);
  }

  Future<bool> deleteByRemoteId(String remoteId) {
    return deleteByIndex(r'remoteId', [remoteId]);
  }

  bool deleteByRemoteIdSync(String remoteId) {
    return deleteByIndexSync(r'remoteId', [remoteId]);
  }

  Future<List<WorkoutLogLocal?>> getAllByRemoteId(List<String> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'remoteId', values);
  }

  List<WorkoutLogLocal?> getAllByRemoteIdSync(List<String> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'remoteId', values);
  }

  Future<int> deleteAllByRemoteId(List<String> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'remoteId', values);
  }

  int deleteAllByRemoteIdSync(List<String> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'remoteId', values);
  }

  Future<Id> putByRemoteId(WorkoutLogLocal object) {
    return putByIndex(r'remoteId', object);
  }

  Id putByRemoteIdSync(WorkoutLogLocal object, {bool saveLinks = true}) {
    return putByIndexSync(r'remoteId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRemoteId(List<WorkoutLogLocal> objects) {
    return putAllByIndex(r'remoteId', objects);
  }

  List<Id> putAllByRemoteIdSync(List<WorkoutLogLocal> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'remoteId', objects, saveLinks: saveLinks);
  }
}

extension WorkoutLogLocalQueryWhereSort
    on QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QWhere> {
  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WorkoutLogLocalQueryWhere
    on QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QWhereClause> {
  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterWhereClause>
      remoteIdEqualTo(String remoteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'remoteId',
        value: [remoteId],
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterWhereClause>
      remoteIdNotEqualTo(String remoteId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [],
              upper: [remoteId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [remoteId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [remoteId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteId',
              lower: [],
              upper: [remoteId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension WorkoutLogLocalQueryFilter
    on QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QFilterCondition> {
  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      completedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      completedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      completedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      completedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      durationMinIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'durationMin',
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      durationMinIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'durationMin',
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      durationMinEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationMin',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      durationMinGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationMin',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      durationMinLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationMin',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      durationMinBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationMin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      exercisesDoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'exercisesDone',
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      exercisesDoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'exercisesDone',
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      exercisesDoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exercisesDone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      exercisesDoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exercisesDone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      exercisesDoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exercisesDone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      exercisesDoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exercisesDone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      exercisesDoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'exercisesDone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      exercisesDoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'exercisesDone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      exercisesDoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'exercisesDone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      exercisesDoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'exercisesDone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      exercisesDoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exercisesDone',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      exercisesDoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exercisesDone',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      pendingSyncEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pendingSync',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      planDayIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'planDayIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      planDayIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'planDayIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      planDayIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'planDayIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      planDayIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'planDayIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      remoteIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      remoteIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      remoteIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      remoteIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remoteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      remoteIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      remoteIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      remoteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      remoteIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'remoteId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'remoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension WorkoutLogLocalQueryObject
    on QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QFilterCondition> {}

extension WorkoutLogLocalQueryLinks
    on QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QFilterCondition> {}

extension WorkoutLogLocalQuerySortBy
    on QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QSortBy> {
  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      sortByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      sortByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      sortByDurationMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMin', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      sortByDurationMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMin', Sort.desc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      sortByExercisesDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exercisesDone', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      sortByExercisesDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exercisesDone', Sort.desc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      sortByPendingSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      sortByPendingSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.desc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      sortByPlanDayIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planDayIndex', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      sortByPlanDayIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planDayIndex', Sort.desc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      sortByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      sortByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension WorkoutLogLocalQuerySortThenBy
    on QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QSortThenBy> {
  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      thenByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      thenByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      thenByDurationMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMin', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      thenByDurationMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMin', Sort.desc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      thenByExercisesDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exercisesDone', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      thenByExercisesDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exercisesDone', Sort.desc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      thenByPendingSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      thenByPendingSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.desc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      thenByPlanDayIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planDayIndex', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      thenByPlanDayIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'planDayIndex', Sort.desc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      thenByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      thenByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension WorkoutLogLocalQueryWhereDistinct
    on QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QDistinct> {
  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QDistinct>
      distinctByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedAt');
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QDistinct>
      distinctByDurationMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationMin');
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QDistinct>
      distinctByExercisesDone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exercisesDone',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QDistinct>
      distinctByPendingSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pendingSync');
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QDistinct>
      distinctByPlanDayIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'planDayIndex');
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QDistinct> distinctByRemoteId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension WorkoutLogLocalQueryProperty
    on QueryBuilder<WorkoutLogLocal, WorkoutLogLocal, QQueryProperty> {
  QueryBuilder<WorkoutLogLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WorkoutLogLocal, DateTime, QQueryOperations>
      completedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedAt');
    });
  }

  QueryBuilder<WorkoutLogLocal, int?, QQueryOperations> durationMinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationMin');
    });
  }

  QueryBuilder<WorkoutLogLocal, String?, QQueryOperations>
      exercisesDoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exercisesDone');
    });
  }

  QueryBuilder<WorkoutLogLocal, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<WorkoutLogLocal, bool, QQueryOperations> pendingSyncProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pendingSync');
    });
  }

  QueryBuilder<WorkoutLogLocal, int, QQueryOperations> planDayIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'planDayIndex');
    });
  }

  QueryBuilder<WorkoutLogLocal, String, QQueryOperations> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteId');
    });
  }

  QueryBuilder<WorkoutLogLocal, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<WorkoutLogLocal, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
