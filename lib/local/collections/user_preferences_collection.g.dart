// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserPreferencesLocalCollection on Isar {
  IsarCollection<UserPreferencesLocal> get userPreferencesLocals =>
      this.collection();
}

const UserPreferencesLocalSchema = CollectionSchema(
  name: r'UserPreferencesLocal',
  id: 336453321354397120,
  properties: {
    r'breakIntervalMin': PropertySchema(
      id: 0,
      name: r'breakIntervalMin',
      type: IsarType.long,
    ),
    r'exerciseReminderHour': PropertySchema(
      id: 1,
      name: r'exerciseReminderHour',
      type: IsarType.long,
    ),
    r'pendingSync': PropertySchema(
      id: 2,
      name: r'pendingSync',
      type: IsarType.bool,
    ),
    r'remoteId': PropertySchema(
      id: 3,
      name: r'remoteId',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 4,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'userId': PropertySchema(
      id: 5,
      name: r'userId',
      type: IsarType.string,
    ),
    r'walkIntervalMin': PropertySchema(
      id: 6,
      name: r'walkIntervalMin',
      type: IsarType.long,
    ),
    r'waterIntervalMin': PropertySchema(
      id: 7,
      name: r'waterIntervalMin',
      type: IsarType.long,
    ),
    r'workEndHour': PropertySchema(
      id: 8,
      name: r'workEndHour',
      type: IsarType.long,
    ),
    r'workStartHour': PropertySchema(
      id: 9,
      name: r'workStartHour',
      type: IsarType.long,
    )
  },
  estimateSize: _userPreferencesLocalEstimateSize,
  serialize: _userPreferencesLocalSerialize,
  deserialize: _userPreferencesLocalDeserialize,
  deserializeProp: _userPreferencesLocalDeserializeProp,
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
  getId: _userPreferencesLocalGetId,
  getLinks: _userPreferencesLocalGetLinks,
  attach: _userPreferencesLocalAttach,
  version: '3.1.0+1',
);

int _userPreferencesLocalEstimateSize(
  UserPreferencesLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.remoteId.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _userPreferencesLocalSerialize(
  UserPreferencesLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.breakIntervalMin);
  writer.writeLong(offsets[1], object.exerciseReminderHour);
  writer.writeBool(offsets[2], object.pendingSync);
  writer.writeString(offsets[3], object.remoteId);
  writer.writeDateTime(offsets[4], object.updatedAt);
  writer.writeString(offsets[5], object.userId);
  writer.writeLong(offsets[6], object.walkIntervalMin);
  writer.writeLong(offsets[7], object.waterIntervalMin);
  writer.writeLong(offsets[8], object.workEndHour);
  writer.writeLong(offsets[9], object.workStartHour);
}

UserPreferencesLocal _userPreferencesLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserPreferencesLocal();
  object.breakIntervalMin = reader.readLong(offsets[0]);
  object.exerciseReminderHour = reader.readLong(offsets[1]);
  object.id = id;
  object.pendingSync = reader.readBool(offsets[2]);
  object.remoteId = reader.readString(offsets[3]);
  object.updatedAt = reader.readDateTime(offsets[4]);
  object.userId = reader.readString(offsets[5]);
  object.walkIntervalMin = reader.readLong(offsets[6]);
  object.waterIntervalMin = reader.readLong(offsets[7]);
  object.workEndHour = reader.readLong(offsets[8]);
  object.workStartHour = reader.readLong(offsets[9]);
  return object;
}

P _userPreferencesLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userPreferencesLocalGetId(UserPreferencesLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userPreferencesLocalGetLinks(
    UserPreferencesLocal object) {
  return [];
}

void _userPreferencesLocalAttach(
    IsarCollection<dynamic> col, Id id, UserPreferencesLocal object) {
  object.id = id;
}

extension UserPreferencesLocalByIndex on IsarCollection<UserPreferencesLocal> {
  Future<UserPreferencesLocal?> getByRemoteId(String remoteId) {
    return getByIndex(r'remoteId', [remoteId]);
  }

  UserPreferencesLocal? getByRemoteIdSync(String remoteId) {
    return getByIndexSync(r'remoteId', [remoteId]);
  }

  Future<bool> deleteByRemoteId(String remoteId) {
    return deleteByIndex(r'remoteId', [remoteId]);
  }

  bool deleteByRemoteIdSync(String remoteId) {
    return deleteByIndexSync(r'remoteId', [remoteId]);
  }

  Future<List<UserPreferencesLocal?>> getAllByRemoteId(
      List<String> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'remoteId', values);
  }

  List<UserPreferencesLocal?> getAllByRemoteIdSync(
      List<String> remoteIdValues) {
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

  Future<Id> putByRemoteId(UserPreferencesLocal object) {
    return putByIndex(r'remoteId', object);
  }

  Id putByRemoteIdSync(UserPreferencesLocal object, {bool saveLinks = true}) {
    return putByIndexSync(r'remoteId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRemoteId(List<UserPreferencesLocal> objects) {
    return putAllByIndex(r'remoteId', objects);
  }

  List<Id> putAllByRemoteIdSync(List<UserPreferencesLocal> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'remoteId', objects, saveLinks: saveLinks);
  }
}

extension UserPreferencesLocalQueryWhereSort
    on QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QWhere> {
  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserPreferencesLocalQueryWhere
    on QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QWhereClause> {
  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterWhereClause>
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterWhereClause>
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterWhereClause>
      remoteIdEqualTo(String remoteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'remoteId',
        value: [remoteId],
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterWhereClause>
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

extension UserPreferencesLocalQueryFilter on QueryBuilder<UserPreferencesLocal,
    UserPreferencesLocal, QFilterCondition> {
  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> breakIntervalMinEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'breakIntervalMin',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> breakIntervalMinGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'breakIntervalMin',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> breakIntervalMinLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'breakIntervalMin',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> breakIntervalMinBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'breakIntervalMin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> exerciseReminderHourEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseReminderHour',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> exerciseReminderHourGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exerciseReminderHour',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> exerciseReminderHourLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exerciseReminderHour',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> exerciseReminderHourBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exerciseReminderHour',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> pendingSyncEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pendingSync',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> remoteIdEqualTo(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> remoteIdGreaterThan(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> remoteIdLessThan(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> remoteIdBetween(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> remoteIdStartsWith(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> remoteIdEndsWith(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
          QAfterFilterCondition>
      remoteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
          QAfterFilterCondition>
      remoteIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'remoteId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'remoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> updatedAtGreaterThan(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> updatedAtLessThan(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> updatedAtBetween(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> userIdEqualTo(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> userIdGreaterThan(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> userIdLessThan(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> userIdBetween(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> userIdStartsWith(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> userIdEndsWith(
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

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
          QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
          QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> walkIntervalMinEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'walkIntervalMin',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> walkIntervalMinGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'walkIntervalMin',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> walkIntervalMinLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'walkIntervalMin',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> walkIntervalMinBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'walkIntervalMin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> waterIntervalMinEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waterIntervalMin',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> waterIntervalMinGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'waterIntervalMin',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> waterIntervalMinLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'waterIntervalMin',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> waterIntervalMinBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'waterIntervalMin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> workEndHourEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workEndHour',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> workEndHourGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'workEndHour',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> workEndHourLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'workEndHour',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> workEndHourBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'workEndHour',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> workStartHourEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workStartHour',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> workStartHourGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'workStartHour',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> workStartHourLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'workStartHour',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal,
      QAfterFilterCondition> workStartHourBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'workStartHour',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserPreferencesLocalQueryObject on QueryBuilder<UserPreferencesLocal,
    UserPreferencesLocal, QFilterCondition> {}

extension UserPreferencesLocalQueryLinks on QueryBuilder<UserPreferencesLocal,
    UserPreferencesLocal, QFilterCondition> {}

extension UserPreferencesLocalQuerySortBy
    on QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QSortBy> {
  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByBreakIntervalMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakIntervalMin', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByBreakIntervalMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakIntervalMin', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByExerciseReminderHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseReminderHour', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByExerciseReminderHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseReminderHour', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByPendingSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByPendingSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByWalkIntervalMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkIntervalMin', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByWalkIntervalMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkIntervalMin', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByWaterIntervalMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterIntervalMin', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByWaterIntervalMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterIntervalMin', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByWorkEndHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workEndHour', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByWorkEndHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workEndHour', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByWorkStartHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workStartHour', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      sortByWorkStartHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workStartHour', Sort.desc);
    });
  }
}

extension UserPreferencesLocalQuerySortThenBy
    on QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QSortThenBy> {
  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByBreakIntervalMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakIntervalMin', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByBreakIntervalMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakIntervalMin', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByExerciseReminderHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseReminderHour', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByExerciseReminderHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exerciseReminderHour', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByPendingSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByPendingSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingSync', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByWalkIntervalMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkIntervalMin', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByWalkIntervalMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'walkIntervalMin', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByWaterIntervalMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterIntervalMin', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByWaterIntervalMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterIntervalMin', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByWorkEndHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workEndHour', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByWorkEndHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workEndHour', Sort.desc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByWorkStartHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workStartHour', Sort.asc);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QAfterSortBy>
      thenByWorkStartHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workStartHour', Sort.desc);
    });
  }
}

extension UserPreferencesLocalQueryWhereDistinct
    on QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QDistinct> {
  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QDistinct>
      distinctByBreakIntervalMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'breakIntervalMin');
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QDistinct>
      distinctByExerciseReminderHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exerciseReminderHour');
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QDistinct>
      distinctByPendingSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pendingSync');
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QDistinct>
      distinctByRemoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QDistinct>
      distinctByWalkIntervalMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'walkIntervalMin');
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QDistinct>
      distinctByWaterIntervalMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waterIntervalMin');
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QDistinct>
      distinctByWorkEndHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workEndHour');
    });
  }

  QueryBuilder<UserPreferencesLocal, UserPreferencesLocal, QDistinct>
      distinctByWorkStartHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workStartHour');
    });
  }
}

extension UserPreferencesLocalQueryProperty on QueryBuilder<
    UserPreferencesLocal, UserPreferencesLocal, QQueryProperty> {
  QueryBuilder<UserPreferencesLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserPreferencesLocal, int, QQueryOperations>
      breakIntervalMinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'breakIntervalMin');
    });
  }

  QueryBuilder<UserPreferencesLocal, int, QQueryOperations>
      exerciseReminderHourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exerciseReminderHour');
    });
  }

  QueryBuilder<UserPreferencesLocal, bool, QQueryOperations>
      pendingSyncProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pendingSync');
    });
  }

  QueryBuilder<UserPreferencesLocal, String, QQueryOperations>
      remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteId');
    });
  }

  QueryBuilder<UserPreferencesLocal, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<UserPreferencesLocal, String, QQueryOperations>
      userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<UserPreferencesLocal, int, QQueryOperations>
      walkIntervalMinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'walkIntervalMin');
    });
  }

  QueryBuilder<UserPreferencesLocal, int, QQueryOperations>
      waterIntervalMinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waterIntervalMin');
    });
  }

  QueryBuilder<UserPreferencesLocal, int, QQueryOperations>
      workEndHourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workEndHour');
    });
  }

  QueryBuilder<UserPreferencesLocal, int, QQueryOperations>
      workStartHourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workStartHour');
    });
  }
}
