// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_plan_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWorkoutPlanLocalCollection on Isar {
  IsarCollection<WorkoutPlanLocal> get workoutPlanLocals => this.collection();
}

const WorkoutPlanLocalSchema = CollectionSchema(
  name: r'WorkoutPlanLocal',
  id: -8535404725118212860,
  properties: {
    r'dayIndex': PropertySchema(
      id: 0,
      name: r'dayIndex',
      type: IsarType.long,
    ),
    r'dayLabel': PropertySchema(
      id: 1,
      name: r'dayLabel',
      type: IsarType.string,
    ),
    r'exercises': PropertySchema(
      id: 2,
      name: r'exercises',
      type: IsarType.string,
    ),
    r'focus': PropertySchema(
      id: 3,
      name: r'focus',
      type: IsarType.string,
    ),
    r'pendingSync': PropertySchema(
      id: 4,
      name: r'pendingSync',
      type: IsarType.bool,
    ),
    r'remoteId': PropertySchema(
      id: 5,
      name: r'remoteId',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 6,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _workoutPlanLocalEstimateSize,
  serialize: _workoutPlanLocalSerialize,
  deserialize: _workoutPlanLocalDeserialize,
  deserializeProp: _workoutPlanLocalDeserializeProp,
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
  getId: _workoutPlanLocalGetId,
  getLinks: _workoutPlanLocalGetLinks,
  attach: _workoutPlanLocalAttach,
  version: '3.1.0+1',
);

int _workoutPlanLocalEstimateSize(
  WorkoutPlanLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dayLabel.length * 3;
  bytesCount += 3 + object.exercises.length * 3;
  bytesCount += 3 + object.focus.length * 3;
  bytesCount += 3 + object.remoteId.length * 3;
  return bytesCount;
}

void _workoutPlanLocalSerialize(
  WorkoutPlanLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.dayIndex);
  writer.writeString(offsets[1], object.dayLabel);
  writer.writeString(offsets[2], object.exercises);
  writer.writeString(offsets[3], object.focus);
  writer.writeBool(offsets[4], object.pendingSync);
  writer.writeString(offsets[5], object.remoteId);
  writer.writeDateTime(offsets[6], object.updatedAt);
}

WorkoutPlanLocal _workoutPlanLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkoutPlanLocal();
  object.dayIndex = reader.readLong(offsets[0]);
  object.dayLabel = reader.readString(offsets[1]);
  object.exercises = reader.readString(offsets[2]);
  object.focus = reader.readString(offsets[3]);
  object.id = id;
  object.pendingSync = reader.readBool(offsets[4]);
  object.remoteId = reader.readString(offsets[5]);
  object.updatedAt = reader.readDateTime(offsets[6]);
  return object;
}

P _workoutPlanLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _workoutPlanLocalGetId(WorkoutPlanLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _workoutPlanLocalGetLinks(WorkoutPlanLocal object) {
  return [];
}

void _workoutPlanLocalAttach(
    IsarCollection<dynamic> col, Id id, WorkoutPlanLocal object) {
  object.id = id;
}

extension WorkoutPlanLocalByIndex on IsarCollection<WorkoutPlanLocal> {
  Future<WorkoutPlanLocal?> getByRemoteId(String remoteId) {
    return getByIndex(r'remoteId', [remoteId]);
  }

  WorkoutPlanLocal? getByRemoteIdSync(String remoteId) {
    return getByIndexSync(r'remoteId', [remoteId]);
  }

  Future<bool> deleteByRemoteId(String remoteId) {
    return deleteByIndex(r'remoteId', [remoteId]);
  }

  bool deleteByRemoteIdSync(String remoteId) {
    return deleteByIndexSync(r'remoteId', [remoteId]);
  }

  Future<List<WorkoutPlanLocal?>> getAllByRemoteId(
      List<String> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'remoteId', values);
  }

  List<WorkoutPlanLocal?> getAllByRemoteIdSync(List<String> remoteIdValues) {
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

  Future<Id> putByRemoteId(WorkoutPlanLocal object) {
    return putByIndex(r'remoteId', object);
  }

  Id putByRemoteIdSync(WorkoutPlanLocal object, {bool saveLinks = true}) {
    return putByIndexSync(r'remoteId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRemoteId(List<WorkoutPlanLocal> objects) {
    return putAllByIndex(r'remoteId', objects);
  }

  List<Id> putAllByRemoteIdSync(List<WorkoutPlanLocal> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'remoteId', objects, saveLinks: saveLinks);
  }
}

extension WorkoutPlanLocalQueryWhereSort
    on QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QWhere> {
  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WorkoutPlanLocalQueryWhere
    on QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QWhereClause> {
  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterWhereClause>
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

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterWhereClause> idBetween(
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

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterWhereClause>
      remoteIdEqualTo(String remoteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'remoteId',
        value: [remoteId],
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterWhereClause>
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

extension WorkoutPlanLocalQueryFilter
    on QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QFilterCondition> {
  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      dayIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dayIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      dayIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dayIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      dayIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dayIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      dayIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dayIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      dayLabelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dayLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      dayLabelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dayLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      dayLabelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dayLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      dayLabelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dayLabel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      dayLabelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dayLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      dayLabelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dayLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      dayLabelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dayLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      dayLabelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dayLabel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      dayLabelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dayLabel',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      dayLabelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dayLabel',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      exercisesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exercises',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      exercisesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exercises',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      exercisesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exercises',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      exercisesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exercises',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      exercisesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'exercises',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      exercisesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'exercises',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      exercisesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'exercises',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      exercisesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'exercises',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      exercisesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exercises',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      exercisesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exercises',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      focusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'focus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      focusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'focus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      focusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'focus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      focusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'focus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      focusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'focus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      focusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'focus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      focusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'focus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      focusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'focus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      focusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'focus',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      focusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'focus',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
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

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
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

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
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

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      pendingSyncEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pendingSync',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
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

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
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

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
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

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
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

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
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

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
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

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      remoteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      remoteIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'remoteId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'remoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
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

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
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

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterFilterCondition>
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
}

extension WorkoutPlanLocalQueryObject
    on QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QFilterCondition> {}

extension WorkoutPlanLocalQueryLinks
    on QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QFilterCondition> {}

extension WorkoutPlanLocalQuerySortBy
    on QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QSortBy> {
  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      sortByDayIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayIndex', Sort.asc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      sortByDayIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayIndex', Sort.desc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      sortByDayLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayLabel', Sort.asc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      sortByDayLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayLabel', Sort.desc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      sortByExercises() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exercises', Sort.asc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      sortByExercisesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exercises', Sort.desc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy> sortByFocus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'focus', Sort.asc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      sortByFocusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'focus', Sort.desc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      sortByPendingSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.asc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      sortByPendingSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.desc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      sortByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      sortByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension WorkoutPlanLocalQuerySortThenBy
    on QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QSortThenBy> {
  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      thenByDayIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayIndex', Sort.asc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      thenByDayIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayIndex', Sort.desc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      thenByDayLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayLabel', Sort.asc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      thenByDayLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayLabel', Sort.desc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      thenByExercises() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exercises', Sort.asc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      thenByExercisesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exercises', Sort.desc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy> thenByFocus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'focus', Sort.asc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      thenByFocusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'focus', Sort.desc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      thenByPendingSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.asc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      thenByPendingSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.desc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      thenByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      thenByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension WorkoutPlanLocalQueryWhereDistinct
    on QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QDistinct> {
  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QDistinct>
      distinctByDayIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayIndex');
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QDistinct>
      distinctByDayLabel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayLabel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QDistinct>
      distinctByExercises({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exercises', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QDistinct> distinctByFocus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'focus', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QDistinct>
      distinctByPendingSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pendingSync');
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QDistinct>
      distinctByRemoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension WorkoutPlanLocalQueryProperty
    on QueryBuilder<WorkoutPlanLocal, WorkoutPlanLocal, QQueryProperty> {
  QueryBuilder<WorkoutPlanLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WorkoutPlanLocal, int, QQueryOperations> dayIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayIndex');
    });
  }

  QueryBuilder<WorkoutPlanLocal, String, QQueryOperations> dayLabelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayLabel');
    });
  }

  QueryBuilder<WorkoutPlanLocal, String, QQueryOperations> exercisesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exercises');
    });
  }

  QueryBuilder<WorkoutPlanLocal, String, QQueryOperations> focusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'focus');
    });
  }

  QueryBuilder<WorkoutPlanLocal, bool, QQueryOperations> pendingSyncProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pendingSync');
    });
  }

  QueryBuilder<WorkoutPlanLocal, String, QQueryOperations> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteId');
    });
  }

  QueryBuilder<WorkoutPlanLocal, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
