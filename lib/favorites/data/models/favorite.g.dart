// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFavoriteCollection on Isar {
  IsarCollection<Favorite> get favorites => this.collection();
}

const FavoriteSchema = CollectionSchema(
  name: r'Favorite',
  id: 5577971995748139032,
  properties: {
    r'favoritedAt': PropertySchema(
      id: 0,
      name: r'favoritedAt',
      type: IsarType.dateTime,
    ),
    r'pathToImage': PropertySchema(
      id: 1,
      name: r'pathToImage',
      type: IsarType.string,
    )
  },
  estimateSize: _favoriteEstimateSize,
  serialize: _favoriteSerialize,
  deserialize: _favoriteDeserialize,
  deserializeProp: _favoriteDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _favoriteGetId,
  getLinks: _favoriteGetLinks,
  attach: _favoriteAttach,
  version: '3.1.0+1',
);

int _favoriteEstimateSize(
  Favorite object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.pathToImage.length * 3;
  return bytesCount;
}

void _favoriteSerialize(
  Favorite object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.favoritedAt);
  writer.writeString(offsets[1], object.pathToImage);
}

Favorite _favoriteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Favorite(
    favoritedAt: reader.readDateTime(offsets[0]),
    pathToImage: reader.readString(offsets[1]),
  );
  return object;
}

P _favoriteDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _favoriteGetId(Favorite object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _favoriteGetLinks(Favorite object) {
  return [];
}

void _favoriteAttach(IsarCollection<dynamic> col, Id id, Favorite object) {}

extension FavoriteQueryWhereSort on QueryBuilder<Favorite, Favorite, QWhere> {
  QueryBuilder<Favorite, Favorite, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FavoriteQueryWhere on QueryBuilder<Favorite, Favorite, QWhereClause> {
  QueryBuilder<Favorite, Favorite, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Favorite, Favorite, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterWhereClause> idBetween(
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

extension FavoriteQueryFilter
    on QueryBuilder<Favorite, Favorite, QFilterCondition> {
  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> favoritedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'favoritedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition>
      favoritedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'favoritedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> favoritedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'favoritedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> favoritedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'favoritedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> pathToImageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pathToImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition>
      pathToImageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pathToImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> pathToImageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pathToImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> pathToImageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pathToImage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> pathToImageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pathToImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> pathToImageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pathToImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> pathToImageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pathToImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> pathToImageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pathToImage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition> pathToImageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pathToImage',
        value: '',
      ));
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterFilterCondition>
      pathToImageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pathToImage',
        value: '',
      ));
    });
  }
}

extension FavoriteQueryObject
    on QueryBuilder<Favorite, Favorite, QFilterCondition> {}

extension FavoriteQueryLinks
    on QueryBuilder<Favorite, Favorite, QFilterCondition> {}

extension FavoriteQuerySortBy on QueryBuilder<Favorite, Favorite, QSortBy> {
  QueryBuilder<Favorite, Favorite, QAfterSortBy> sortByFavoritedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favoritedAt', Sort.asc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> sortByFavoritedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favoritedAt', Sort.desc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> sortByPathToImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pathToImage', Sort.asc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> sortByPathToImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pathToImage', Sort.desc);
    });
  }
}

extension FavoriteQuerySortThenBy
    on QueryBuilder<Favorite, Favorite, QSortThenBy> {
  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenByFavoritedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favoritedAt', Sort.asc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenByFavoritedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'favoritedAt', Sort.desc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenByPathToImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pathToImage', Sort.asc);
    });
  }

  QueryBuilder<Favorite, Favorite, QAfterSortBy> thenByPathToImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pathToImage', Sort.desc);
    });
  }
}

extension FavoriteQueryWhereDistinct
    on QueryBuilder<Favorite, Favorite, QDistinct> {
  QueryBuilder<Favorite, Favorite, QDistinct> distinctByFavoritedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'favoritedAt');
    });
  }

  QueryBuilder<Favorite, Favorite, QDistinct> distinctByPathToImage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pathToImage', caseSensitive: caseSensitive);
    });
  }
}

extension FavoriteQueryProperty
    on QueryBuilder<Favorite, Favorite, QQueryProperty> {
  QueryBuilder<Favorite, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Favorite, DateTime, QQueryOperations> favoritedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'favoritedAt');
    });
  }

  QueryBuilder<Favorite, String, QQueryOperations> pathToImageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pathToImage');
    });
  }
}
