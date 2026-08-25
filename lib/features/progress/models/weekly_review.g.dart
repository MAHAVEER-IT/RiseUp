// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_review.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWeeklyReviewCollection on Isar {
  IsarCollection<WeeklyReview> get weeklyReviews => this.collection();
}

const WeeklyReviewSchema = CollectionSchema(
  name: r'WeeklyReview',
  id: 1740939263748820166,
  properties: {
    r'aiInsights': PropertySchema(
      id: 0,
      name: r'aiInsights',
      type: IsarType.string,
    ),
    r'avgEnergy': PropertySchema(
      id: 1,
      name: r'avgEnergy',
      type: IsarType.double,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'totalFocusMinutes': PropertySchema(
      id: 3,
      name: r'totalFocusMinutes',
      type: IsarType.long,
    ),
    r'weekStartDate': PropertySchema(
      id: 4,
      name: r'weekStartDate',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _weeklyReviewEstimateSize,
  serialize: _weeklyReviewSerialize,
  deserialize: _weeklyReviewDeserialize,
  deserializeProp: _weeklyReviewDeserializeProp,
  idName: r'id',
  indexes: {
    r'weekStartDate': IndexSchema(
      id: 7906057668223877157,
      name: r'weekStartDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'weekStartDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _weeklyReviewGetId,
  getLinks: _weeklyReviewGetLinks,
  attach: _weeklyReviewAttach,
  version: '3.1.0+1',
);

int _weeklyReviewEstimateSize(
  WeeklyReview object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.aiInsights.length * 3;
  return bytesCount;
}

void _weeklyReviewSerialize(
  WeeklyReview object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.aiInsights);
  writer.writeDouble(offsets[1], object.avgEnergy);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeLong(offsets[3], object.totalFocusMinutes);
  writer.writeDateTime(offsets[4], object.weekStartDate);
}

WeeklyReview _weeklyReviewDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WeeklyReview(
    aiInsights: reader.readString(offsets[0]),
    avgEnergy: reader.readDouble(offsets[1]),
    totalFocusMinutes: reader.readLong(offsets[3]),
    weekStartDate: reader.readDateTime(offsets[4]),
  );
  object.createdAt = reader.readDateTime(offsets[2]);
  object.id = id;
  return object;
}

P _weeklyReviewDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _weeklyReviewGetId(WeeklyReview object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _weeklyReviewGetLinks(WeeklyReview object) {
  return [];
}

void _weeklyReviewAttach(
    IsarCollection<dynamic> col, Id id, WeeklyReview object) {
  object.id = id;
}

extension WeeklyReviewQueryWhereSort
    on QueryBuilder<WeeklyReview, WeeklyReview, QWhere> {
  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhere> anyWeekStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'weekStartDate'),
      );
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension WeeklyReviewQueryWhere
    on QueryBuilder<WeeklyReview, WeeklyReview, QWhereClause> {
  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause> idBetween(
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause>
      weekStartDateEqualTo(DateTime weekStartDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'weekStartDate',
        value: [weekStartDate],
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause>
      weekStartDateNotEqualTo(DateTime weekStartDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekStartDate',
              lower: [],
              upper: [weekStartDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekStartDate',
              lower: [weekStartDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekStartDate',
              lower: [weekStartDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekStartDate',
              lower: [],
              upper: [weekStartDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause>
      weekStartDateGreaterThan(
    DateTime weekStartDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'weekStartDate',
        lower: [weekStartDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause>
      weekStartDateLessThan(
    DateTime weekStartDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'weekStartDate',
        lower: [],
        upper: [weekStartDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause>
      weekStartDateBetween(
    DateTime lowerWeekStartDate,
    DateTime upperWeekStartDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'weekStartDate',
        lower: [lowerWeekStartDate],
        includeLower: includeLower,
        upper: [upperWeekStartDate],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause> createdAtEqualTo(
      DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause>
      createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause>
      createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause> createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause> createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WeeklyReviewQueryFilter
    on QueryBuilder<WeeklyReview, WeeklyReview, QFilterCondition> {
  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiInsightsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiInsights',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiInsightsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aiInsights',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiInsightsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aiInsights',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiInsightsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aiInsights',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiInsightsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aiInsights',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiInsightsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aiInsights',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiInsightsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aiInsights',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiInsightsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aiInsights',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiInsightsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiInsights',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiInsightsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aiInsights',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      avgEnergyEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avgEnergy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      avgEnergyGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avgEnergy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      avgEnergyLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avgEnergy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      avgEnergyBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avgEnergy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition> idBetween(
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      totalFocusMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalFocusMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      totalFocusMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalFocusMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      totalFocusMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalFocusMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      totalFocusMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalFocusMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      weekStartDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weekStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      weekStartDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weekStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      weekStartDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weekStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      weekStartDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weekStartDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WeeklyReviewQueryObject
    on QueryBuilder<WeeklyReview, WeeklyReview, QFilterCondition> {}

extension WeeklyReviewQueryLinks
    on QueryBuilder<WeeklyReview, WeeklyReview, QFilterCondition> {}

extension WeeklyReviewQuerySortBy
    on QueryBuilder<WeeklyReview, WeeklyReview, QSortBy> {
  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> sortByAiInsights() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiInsights', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      sortByAiInsightsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiInsights', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> sortByAvgEnergy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgEnergy', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> sortByAvgEnergyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgEnergy', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      sortByTotalFocusMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFocusMinutes', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      sortByTotalFocusMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFocusMinutes', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> sortByWeekStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStartDate', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      sortByWeekStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStartDate', Sort.desc);
    });
  }
}

extension WeeklyReviewQuerySortThenBy
    on QueryBuilder<WeeklyReview, WeeklyReview, QSortThenBy> {
  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> thenByAiInsights() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiInsights', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      thenByAiInsightsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiInsights', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> thenByAvgEnergy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgEnergy', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> thenByAvgEnergyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgEnergy', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      thenByTotalFocusMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFocusMinutes', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      thenByTotalFocusMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFocusMinutes', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> thenByWeekStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStartDate', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      thenByWeekStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStartDate', Sort.desc);
    });
  }
}

extension WeeklyReviewQueryWhereDistinct
    on QueryBuilder<WeeklyReview, WeeklyReview, QDistinct> {
  QueryBuilder<WeeklyReview, WeeklyReview, QDistinct> distinctByAiInsights(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aiInsights', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QDistinct> distinctByAvgEnergy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avgEnergy');
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QDistinct>
      distinctByTotalFocusMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalFocusMinutes');
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QDistinct>
      distinctByWeekStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekStartDate');
    });
  }
}

extension WeeklyReviewQueryProperty
    on QueryBuilder<WeeklyReview, WeeklyReview, QQueryProperty> {
  QueryBuilder<WeeklyReview, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WeeklyReview, String, QQueryOperations> aiInsightsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aiInsights');
    });
  }

  QueryBuilder<WeeklyReview, double, QQueryOperations> avgEnergyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avgEnergy');
    });
  }

  QueryBuilder<WeeklyReview, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<WeeklyReview, int, QQueryOperations>
      totalFocusMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalFocusMinutes');
    });
  }

  QueryBuilder<WeeklyReview, DateTime, QQueryOperations>
      weekStartDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekStartDate');
    });
  }
}
