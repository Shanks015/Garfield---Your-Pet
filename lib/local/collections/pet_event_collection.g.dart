// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_event_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPetEventLocalCollection on Isar {
  IsarCollection<PetEventLocal> get petEventLocals => this.collection();
}

const PetEventLocalSchema = CollectionSchema(
  name: r'PetEventLocal',
  id: 1378276970649859053,
  properties: {
    r'animation': PropertySchema(
      id: 0,
      name: r'animation',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'message': PropertySchema(
      id: 2,
      name: r'message',
      type: IsarType.string,
    )
  },
  estimateSize: _petEventLocalEstimateSize,
  serialize: _petEventLocalSerialize,
  deserialize: _petEventLocalDeserialize,
  deserializeProp: _petEventLocalDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _petEventLocalGetId,
  getLinks: _petEventLocalGetLinks,
  attach: _petEventLocalAttach,
  version: '3.1.0+1',
);

int _petEventLocalEstimateSize(
  PetEventLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.animation.length * 3;
  bytesCount += 3 + object.message.length * 3;
  return bytesCount;
}

void _petEventLocalSerialize(
  PetEventLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.animation);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.message);
}

PetEventLocal _petEventLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PetEventLocal();
  object.animation = reader.readString(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.id = id;
  object.message = reader.readString(offsets[2]);
  return object;
}

P _petEventLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _petEventLocalGetId(PetEventLocal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _petEventLocalGetLinks(PetEventLocal object) {
  return [];
}

void _petEventLocalAttach(
    IsarCollection<dynamic> col, Id id, PetEventLocal object) {
  object.id = id;
}

extension PetEventLocalQueryWhereSort
    on QueryBuilder<PetEventLocal, PetEventLocal, QWhere> {
  QueryBuilder<PetEventLocal, PetEventLocal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PetEventLocalQueryWhere
    on QueryBuilder<PetEventLocal, PetEventLocal, QWhereClause> {
  QueryBuilder<PetEventLocal, PetEventLocal, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterWhereClause> idBetween(
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
}

extension PetEventLocalQueryFilter
    on QueryBuilder<PetEventLocal, PetEventLocal, QFilterCondition> {
  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      animationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'animation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      animationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'animation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      animationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'animation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      animationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'animation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      animationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'animation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      animationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'animation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      animationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'animation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      animationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'animation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      animationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'animation',
        value: '',
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      animationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'animation',
        value: '',
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
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

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      messageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      messageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      messageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      messageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'message',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      messageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      messageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      messageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      messageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'message',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterFilterCondition>
      messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'message',
        value: '',
      ));
    });
  }
}

extension PetEventLocalQueryObject
    on QueryBuilder<PetEventLocal, PetEventLocal, QFilterCondition> {}

extension PetEventLocalQueryLinks
    on QueryBuilder<PetEventLocal, PetEventLocal, QFilterCondition> {}

extension PetEventLocalQuerySortBy
    on QueryBuilder<PetEventLocal, PetEventLocal, QSortBy> {
  QueryBuilder<PetEventLocal, PetEventLocal, QAfterSortBy> sortByAnimation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animation', Sort.asc);
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterSortBy>
      sortByAnimationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animation', Sort.desc);
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterSortBy> sortByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterSortBy> sortByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }
}

extension PetEventLocalQuerySortThenBy
    on QueryBuilder<PetEventLocal, PetEventLocal, QSortThenBy> {
  QueryBuilder<PetEventLocal, PetEventLocal, QAfterSortBy> thenByAnimation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animation', Sort.asc);
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterSortBy>
      thenByAnimationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'animation', Sort.desc);
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterSortBy> thenByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QAfterSortBy> thenByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }
}

extension PetEventLocalQueryWhereDistinct
    on QueryBuilder<PetEventLocal, PetEventLocal, QDistinct> {
  QueryBuilder<PetEventLocal, PetEventLocal, QDistinct> distinctByAnimation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'animation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<PetEventLocal, PetEventLocal, QDistinct> distinctByMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message', caseSensitive: caseSensitive);
    });
  }
}

extension PetEventLocalQueryProperty
    on QueryBuilder<PetEventLocal, PetEventLocal, QQueryProperty> {
  QueryBuilder<PetEventLocal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PetEventLocal, String, QQueryOperations> animationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'animation');
    });
  }

  QueryBuilder<PetEventLocal, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<PetEventLocal, String, QQueryOperations> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message');
    });
  }
}
