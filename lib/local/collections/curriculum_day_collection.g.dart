// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curriculum_day_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCurriculumDayLocalCollection on Isar {
  IsarCollection<CurriculumDayLocal> get curriculumDayLocals =>
      this.collection();
}

const CurriculumDayLocalSchema = CollectionSchema(
  name: r'CurriculumDayLocal',
  id: -7372787842026129746,
  properties: {
    r'calendarDate': PropertySchema(
      id: 0,
      name: r'calendarDate',
      type: IsarType.dateTime,
    ),
    r'dayNumber': PropertySchema(
      id: 1,
      name: r'dayNumber',
      type: IsarType.long,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'energyLevel': PropertySchema(
      id: 3,
      name: r'energyLevel',
      type: IsarType.string,
    ),
    r'estimatedMin': PropertySchema(
      id: 4,
      name: r'estimatedMin',
      type: IsarType.long,
    ),
    r'goalId': PropertySchema(
      id: 5,
      name: r'goalId',
      type: IsarType.string,
    ),
    r'pendingSync': PropertySchema(
      id: 6,
      name: r'pendingSync',
      type: IsarType.bool,
    ),
    r'practicalTask': PropertySchema(
      id: 7,
      name: r'practicalTask',
      type: IsarType.string,
    ),
    r'remoteId': PropertySchema(
      id: 8,
      name: r'remoteId',
      type: IsarType.string,
    ),
    r'resources': PropertySchema(
      id: 9,
      name: r'resources',
      type: IsarType.string,
    ),
    r'topic': PropertySchema(
      id: 10,
      name: r'topic',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 11,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'weekNumber': PropertySchema(
      id: 12,
      name: r'weekNumber',
      type: IsarType.long,
    )
  },
  estimateSize: _curriculumDayLocalEstimateSize,
  serialize: _curriculumDayLocalSerialize,
  deserialize: _curriculumDayLocalDeserialize,
  deserializeProp: _curriculumDayLocalDeserializeProp,
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
    ),
    r'goalId': IndexSchema(
      id: 2738626632585230611,
      name: r'goalId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'goalId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _curriculumDayLocalGetId,
  getLinks: _curriculumDayLocalGetLinks,
  attach: _curriculumDayLocalAttach,
  version: '3.1.0+1',
);

int _curriculumDayLocalEstimateSize(
  CurriculumDayLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  {
    final value = object.energyLevel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.goalId.length * 3;
  bytesCount += 3 + object.practicalTask.length * 3;
  bytesCount += 3 + object.remoteId.length * 3;
  bytesCount += 3 + object.resources.length * 3;
  bytesCount += 3 + object.topic.length * 3;
  return bytesCount;
}

void _curriculumDayLocalSerialize(
  CurriculumDayLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.calendarDate);
  writer.writeLong(offsets[1], object.dayNumber);
  writer.writeString(offsets[2], object.description);
  writer.writeString(offsets[3], object.energyLevel);
  writer.writeLong(offsets[4], object.estimatedMin);
  writer.writeString(offsets[5], object.goalId);
  writer.writeBool(offsets[6], object.pendingSync);
  writer.writeString(offsets[7], object.practicalTask);
  writer.writeString(offsets[8], object.remoteId);
  writer.writeString(offsets[9], object.resources);
  writer.writeString(offsets[10], object.topic);
  writer.writeDateTime(offsets[11], object.updatedAt);
  writer.writeLong(offsets[12], object.weekNumber);
}

CurriculumDayLocal _curriculumDayLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CurriculumDayLocal();
  object.calendarDate = reader.readDateTimeOrNull(offsets[0]);
  object.dayNumber = reader.readLong(offsets[1]);
  object.description = reader.readString(offsets[2]);
  object.energyLevel = reader.readStringOrNull(offsets[3]);
  object.estimatedMin = reader.readLong(offsets[4]);
  object.goalId = reader.readString(offsets[5]);
  object.id = id;
  object.pendingSync = reader.readBool(offsets[6]);
  object.practicalTask = reader.readString(offsets[7]);
  object.remoteId = reader.readString(offsets[8]);
  object.resources = reader.readString(offsets[9]);
  object.topic = reader.readString(offsets[10]);
  object.updatedAt = reader.readDateTime(offsets[11]);
  object.weekNumber = reader.readLong(offsets[12]);
  return object;
}

P _curriculumDayLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readDateTime(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _curriculumDayLocalGetId(CurriculumDayLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _curriculumDayLocalGetLinks(
    CurriculumDayLocal object) {
  return [];
}

void _curriculumDayLocalAttach(
    IsarCollection<dynamic> col, Id id, CurriculumDayLocal object) {
  object.id = id;
}

extension CurriculumDayLocalByIndex on IsarCollection<CurriculumDayLocal> {
  Future<CurriculumDayLocal?> getByRemoteId(String remoteId) {
    return getByIndex(r'remoteId', [remoteId]);
  }

  CurriculumDayLocal? getByRemoteIdSync(String remoteId) {
    return getByIndexSync(r'remoteId', [remoteId]);
  }

  Future<bool> deleteByRemoteId(String remoteId) {
    return deleteByIndex(r'remoteId', [remoteId]);
  }

  bool deleteByRemoteIdSync(String remoteId) {
    return deleteByIndexSync(r'remoteId', [remoteId]);
  }

  Future<List<CurriculumDayLocal?>> getAllByRemoteId(
      List<String> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'remoteId', values);
  }

  List<CurriculumDayLocal?> getAllByRemoteIdSync(List<String> remoteIdValues) {
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

  Future<Id> putByRemoteId(CurriculumDayLocal object) {
    return putByIndex(r'remoteId', object);
  }

  Id putByRemoteIdSync(CurriculumDayLocal object, {bool saveLinks = true}) {
    return putByIndexSync(r'remoteId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRemoteId(List<CurriculumDayLocal> objects) {
    return putAllByIndex(r'remoteId', objects);
  }

  List<Id> putAllByRemoteIdSync(List<CurriculumDayLocal> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'remoteId', objects, saveLinks: saveLinks);
  }
}

extension CurriculumDayLocalQueryWhereSort
    on QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QWhere> {
  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CurriculumDayLocalQueryWhere
    on QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QWhereClause> {
  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterWhereClause>
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

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterWhereClause>
      remoteIdEqualTo(String remoteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'remoteId',
        value: [remoteId],
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterWhereClause>
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

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterWhereClause>
      goalIdEqualTo(String goalId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'goalId',
        value: [goalId],
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterWhereClause>
      goalIdNotEqualTo(String goalId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalId',
              lower: [],
              upper: [goalId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalId',
              lower: [goalId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalId',
              lower: [goalId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalId',
              lower: [],
              upper: [goalId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CurriculumDayLocalQueryFilter
    on QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QFilterCondition> {
  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      calendarDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'calendarDate',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      calendarDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'calendarDate',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      calendarDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calendarDate',
        value: value,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      calendarDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'calendarDate',
        value: value,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      calendarDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'calendarDate',
        value: value,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      calendarDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'calendarDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      dayNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dayNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      dayNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dayNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      dayNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dayNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      dayNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dayNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      energyLevelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'energyLevel',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      energyLevelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'energyLevel',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      energyLevelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'energyLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      energyLevelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'energyLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      energyLevelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'energyLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      energyLevelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'energyLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      energyLevelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'energyLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      energyLevelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'energyLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      energyLevelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'energyLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      energyLevelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'energyLevel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      energyLevelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'energyLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      energyLevelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'energyLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      estimatedMinEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estimatedMin',
        value: value,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      estimatedMinGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estimatedMin',
        value: value,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      estimatedMinLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estimatedMin',
        value: value,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      estimatedMinBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estimatedMin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      goalIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      goalIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      goalIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      goalIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goalId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      goalIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'goalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      goalIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'goalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      goalIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'goalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      goalIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'goalId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      goalIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalId',
        value: '',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      goalIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'goalId',
        value: '',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
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

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
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

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
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

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      pendingSyncEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pendingSync',
        value: value,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      practicalTaskEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'practicalTask',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      practicalTaskGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'practicalTask',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      practicalTaskLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'practicalTask',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      practicalTaskBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'practicalTask',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      practicalTaskStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'practicalTask',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      practicalTaskEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'practicalTask',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      practicalTaskContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'practicalTask',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      practicalTaskMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'practicalTask',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      practicalTaskIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'practicalTask',
        value: '',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      practicalTaskIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'practicalTask',
        value: '',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
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

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
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

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
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

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
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

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
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

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
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

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      remoteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      remoteIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'remoteId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'remoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      resourcesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resources',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      resourcesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'resources',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      resourcesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'resources',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      resourcesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'resources',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      resourcesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'resources',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      resourcesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'resources',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      resourcesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'resources',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      resourcesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'resources',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      resourcesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resources',
        value: '',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      resourcesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'resources',
        value: '',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      topicEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      topicGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'topic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      topicLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'topic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      topicBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'topic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      topicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'topic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      topicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'topic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      topicContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'topic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      topicMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'topic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      topicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topic',
        value: '',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      topicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'topic',
        value: '',
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
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

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
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

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
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

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      weekNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weekNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      weekNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weekNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      weekNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weekNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterFilterCondition>
      weekNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weekNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CurriculumDayLocalQueryObject
    on QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QFilterCondition> {}

extension CurriculumDayLocalQueryLinks
    on QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QFilterCondition> {}

extension CurriculumDayLocalQuerySortBy
    on QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QSortBy> {
  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByCalendarDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calendarDate', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByCalendarDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calendarDate', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByDayNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayNumber', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByDayNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayNumber', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByEnergyLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyLevel', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByEnergyLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyLevel', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByEstimatedMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedMin', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByEstimatedMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedMin', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByGoalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalId', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByGoalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalId', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByPendingSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByPendingSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByPracticalTask() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'practicalTask', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByPracticalTaskDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'practicalTask', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByResources() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resources', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByResourcesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resources', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByTopic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topic', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByTopicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topic', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByWeekNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekNumber', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      sortByWeekNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekNumber', Sort.desc);
    });
  }
}

extension CurriculumDayLocalQuerySortThenBy
    on QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QSortThenBy> {
  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByCalendarDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calendarDate', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByCalendarDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calendarDate', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByDayNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayNumber', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByDayNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayNumber', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByEnergyLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyLevel', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByEnergyLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyLevel', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByEstimatedMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedMin', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByEstimatedMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedMin', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByGoalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalId', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByGoalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalId', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByPendingSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByPendingSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByPracticalTask() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'practicalTask', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByPracticalTaskDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'practicalTask', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByResources() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resources', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByResourcesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resources', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByTopic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topic', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByTopicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topic', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByWeekNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekNumber', Sort.asc);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QAfterSortBy>
      thenByWeekNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekNumber', Sort.desc);
    });
  }
}

extension CurriculumDayLocalQueryWhereDistinct
    on QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QDistinct> {
  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QDistinct>
      distinctByCalendarDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calendarDate');
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QDistinct>
      distinctByDayNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayNumber');
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QDistinct>
      distinctByEnergyLevel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'energyLevel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QDistinct>
      distinctByEstimatedMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estimatedMin');
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QDistinct>
      distinctByGoalId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QDistinct>
      distinctByPendingSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pendingSync');
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QDistinct>
      distinctByPracticalTask({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'practicalTask',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QDistinct>
      distinctByRemoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QDistinct>
      distinctByResources({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'resources', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QDistinct>
      distinctByTopic({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'topic', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QDistinct>
      distinctByWeekNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekNumber');
    });
  }
}

extension CurriculumDayLocalQueryProperty
    on QueryBuilder<CurriculumDayLocal, CurriculumDayLocal, QQueryProperty> {
  QueryBuilder<CurriculumDayLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CurriculumDayLocal, DateTime?, QQueryOperations>
      calendarDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calendarDate');
    });
  }

  QueryBuilder<CurriculumDayLocal, int, QQueryOperations> dayNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayNumber');
    });
  }

  QueryBuilder<CurriculumDayLocal, String, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<CurriculumDayLocal, String?, QQueryOperations>
      energyLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'energyLevel');
    });
  }

  QueryBuilder<CurriculumDayLocal, int, QQueryOperations>
      estimatedMinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estimatedMin');
    });
  }

  QueryBuilder<CurriculumDayLocal, String, QQueryOperations> goalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalId');
    });
  }

  QueryBuilder<CurriculumDayLocal, bool, QQueryOperations>
      pendingSyncProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pendingSync');
    });
  }

  QueryBuilder<CurriculumDayLocal, String, QQueryOperations>
      practicalTaskProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'practicalTask');
    });
  }

  QueryBuilder<CurriculumDayLocal, String, QQueryOperations>
      remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteId');
    });
  }

  QueryBuilder<CurriculumDayLocal, String, QQueryOperations>
      resourcesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'resources');
    });
  }

  QueryBuilder<CurriculumDayLocal, String, QQueryOperations> topicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'topic');
    });
  }

  QueryBuilder<CurriculumDayLocal, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<CurriculumDayLocal, int, QQueryOperations> weekNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekNumber');
    });
  }
}
