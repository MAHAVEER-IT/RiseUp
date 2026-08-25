// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companion_analytics.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCompanionAnalyticsCollection on Isar {
  IsarCollection<CompanionAnalytics> get companionAnalytics =>
      this.collection();
}

const CompanionAnalyticsSchema = CollectionSchema(
  name: r'CompanionAnalytics',
  id: -2897445554050675145,
  properties: {
    r'commonNotes': PropertySchema(
      id: 0,
      name: r'commonNotes',
      type: IsarType.stringList,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'engagementScore': PropertySchema(
      id: 2,
      name: r'engagementScore',
      type: IsarType.double,
    ),
    r'englishPracticeMinutes': PropertySchema(
      id: 3,
      name: r'englishPracticeMinutes',
      type: IsarType.long,
    ),
    r'englishPracticeSessions': PropertySchema(
      id: 4,
      name: r'englishPracticeSessions',
      type: IsarType.long,
    ),
    r'favoriteActivities': PropertySchema(
      id: 5,
      name: r'favoriteActivities',
      type: IsarType.stringList,
    ),
    r'ignoredCheckIns': PropertySchema(
      id: 6,
      name: r'ignoredCheckIns',
      type: IsarType.long,
    ),
    r'lastEngagedAt': PropertySchema(
      id: 7,
      name: r'lastEngagedAt',
      type: IsarType.dateTime,
    ),
    r'topDistractions': PropertySchema(
      id: 8,
      name: r'topDistractions',
      type: IsarType.stringList,
    ),
    r'totalCheckIns': PropertySchema(
      id: 9,
      name: r'totalCheckIns',
      type: IsarType.long,
    )
  },
  estimateSize: _companionAnalyticsEstimateSize,
  serialize: _companionAnalyticsSerialize,
  deserialize: _companionAnalyticsDeserialize,
  deserializeProp: _companionAnalyticsDeserializeProp,
  idName: r'id',
  indexes: {
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _companionAnalyticsGetId,
  getLinks: _companionAnalyticsGetLinks,
  attach: _companionAnalyticsAttach,
  version: '3.1.0+1',
);

int _companionAnalyticsEstimateSize(
  CompanionAnalytics object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.commonNotes.length * 3;
  {
    for (var i = 0; i < object.commonNotes.length; i++) {
      final value = object.commonNotes[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.favoriteActivities.length * 3;
  {
    for (var i = 0; i < object.favoriteActivities.length; i++) {
      final value = object.favoriteActivities[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.topDistractions.length * 3;
  {
    for (var i = 0; i < object.topDistractions.length; i++) {
      final value = object.topDistractions[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _companionAnalyticsSerialize(
  CompanionAnalytics object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.commonNotes);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeDouble(offsets[2], object.engagementScore);
  writer.writeLong(offsets[3], object.englishPracticeMinutes);
  writer.writeLong(offsets[4], object.englishPracticeSessions);
  writer.writeStringList(offsets[5], object.favoriteActivities);
  writer.writeLong(offsets[6], object.ignoredCheckIns);
  writer.writeDateTime(offsets[7], object.lastEngagedAt);
  writer.writeStringList(offsets[8], object.topDistractions);
  writer.writeLong(offsets[9], object.totalCheckIns);
}

CompanionAnalytics _companionAnalyticsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CompanionAnalytics();
  object.commonNotes = reader.readStringList(offsets[0]) ?? [];
  object.date = reader.readDateTime(offsets[1]);
  object.engagementScore = reader.readDouble(offsets[2]);
  object.englishPracticeMinutes = reader.readLong(offsets[3]);
  object.englishPracticeSessions = reader.readLong(offsets[4]);
  object.favoriteActivities = reader.readStringList(offsets[5]) ?? [];
  object.id = id;
  object.ignoredCheckIns = reader.readLong(offsets[6]);
  object.lastEngagedAt = reader.readDateTime(offsets[7]);
  object.topDistractions = reader.readStringList(offsets[8]) ?? [];
  object.totalCheckIns = reader.readLong(offsets[9]);
  return object;
}

P _companionAnalyticsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    case 8:
      return (reader.readStringList(offset) ?? []) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _companionAnalyticsGetId(CompanionAnalytics object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _companionAnalyticsGetLinks(
    CompanionAnalytics object) {
  return [];
}

void _companionAnalyticsAttach(
    IsarCollection<dynamic> col, Id id, CompanionAnalytics object) {
  object.id = id;
}

extension CompanionAnalyticsQueryWhereSort
    on QueryBuilder<CompanionAnalytics, CompanionAnalytics, QWhere> {
  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension CompanionAnalyticsQueryWhere
    on QueryBuilder<CompanionAnalytics, CompanionAnalytics, QWhereClause> {
  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterWhereClause>
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

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterWhereClause>
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

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterWhereClause>
      dateEqualTo(DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterWhereClause>
      dateNotEqualTo(DateTime date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterWhereClause>
      dateGreaterThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [date],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterWhereClause>
      dateLessThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [],
        upper: [date],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterWhereClause>
      dateBetween(
    DateTime lowerDate,
    DateTime upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [lowerDate],
        includeLower: includeLower,
        upper: [upperDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CompanionAnalyticsQueryFilter
    on QueryBuilder<CompanionAnalytics, CompanionAnalytics, QFilterCondition> {
  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      commonNotesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commonNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      commonNotesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'commonNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      commonNotesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'commonNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      commonNotesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'commonNotes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      commonNotesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'commonNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      commonNotesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'commonNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      commonNotesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'commonNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      commonNotesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'commonNotes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      commonNotesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commonNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      commonNotesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'commonNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      commonNotesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonNotes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      commonNotesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonNotes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      commonNotesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonNotes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      commonNotesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonNotes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      commonNotesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonNotes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      commonNotesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonNotes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      engagementScoreEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'engagementScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      engagementScoreGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'engagementScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      engagementScoreLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'engagementScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      engagementScoreBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'engagementScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      englishPracticeMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'englishPracticeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      englishPracticeMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'englishPracticeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      englishPracticeMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'englishPracticeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      englishPracticeMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'englishPracticeMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      englishPracticeSessionsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'englishPracticeSessions',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      englishPracticeSessionsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'englishPracticeSessions',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      englishPracticeSessionsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'englishPracticeSessions',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      englishPracticeSessionsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'englishPracticeSessions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      favoriteActivitiesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'favoriteActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      favoriteActivitiesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'favoriteActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      favoriteActivitiesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'favoriteActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      favoriteActivitiesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'favoriteActivities',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      favoriteActivitiesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'favoriteActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      favoriteActivitiesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'favoriteActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      favoriteActivitiesElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'favoriteActivities',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      favoriteActivitiesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'favoriteActivities',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      favoriteActivitiesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'favoriteActivities',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      favoriteActivitiesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'favoriteActivities',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      favoriteActivitiesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'favoriteActivities',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      favoriteActivitiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'favoriteActivities',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      favoriteActivitiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'favoriteActivities',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      favoriteActivitiesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'favoriteActivities',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      favoriteActivitiesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'favoriteActivities',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      favoriteActivitiesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'favoriteActivities',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
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

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
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

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
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

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      ignoredCheckInsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ignoredCheckIns',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      ignoredCheckInsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ignoredCheckIns',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      ignoredCheckInsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ignoredCheckIns',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      ignoredCheckInsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ignoredCheckIns',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      lastEngagedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastEngagedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      lastEngagedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastEngagedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      lastEngagedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastEngagedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      lastEngagedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastEngagedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      topDistractionsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topDistractions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      topDistractionsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'topDistractions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      topDistractionsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'topDistractions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      topDistractionsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'topDistractions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      topDistractionsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'topDistractions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      topDistractionsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'topDistractions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      topDistractionsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'topDistractions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      topDistractionsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'topDistractions',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      topDistractionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topDistractions',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      topDistractionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'topDistractions',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      topDistractionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topDistractions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      topDistractionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topDistractions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      topDistractionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topDistractions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      topDistractionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topDistractions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      topDistractionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topDistractions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      topDistractionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topDistractions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      totalCheckInsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalCheckIns',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      totalCheckInsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalCheckIns',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      totalCheckInsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalCheckIns',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterFilterCondition>
      totalCheckInsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalCheckIns',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CompanionAnalyticsQueryObject
    on QueryBuilder<CompanionAnalytics, CompanionAnalytics, QFilterCondition> {}

extension CompanionAnalyticsQueryLinks
    on QueryBuilder<CompanionAnalytics, CompanionAnalytics, QFilterCondition> {}

extension CompanionAnalyticsQuerySortBy
    on QueryBuilder<CompanionAnalytics, CompanionAnalytics, QSortBy> {
  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      sortByEngagementScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engagementScore', Sort.asc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      sortByEngagementScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engagementScore', Sort.desc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      sortByEnglishPracticeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishPracticeMinutes', Sort.asc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      sortByEnglishPracticeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishPracticeMinutes', Sort.desc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      sortByEnglishPracticeSessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishPracticeSessions', Sort.asc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      sortByEnglishPracticeSessionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishPracticeSessions', Sort.desc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      sortByIgnoredCheckIns() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ignoredCheckIns', Sort.asc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      sortByIgnoredCheckInsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ignoredCheckIns', Sort.desc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      sortByLastEngagedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEngagedAt', Sort.asc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      sortByLastEngagedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEngagedAt', Sort.desc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      sortByTotalCheckIns() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCheckIns', Sort.asc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      sortByTotalCheckInsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCheckIns', Sort.desc);
    });
  }
}

extension CompanionAnalyticsQuerySortThenBy
    on QueryBuilder<CompanionAnalytics, CompanionAnalytics, QSortThenBy> {
  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      thenByEngagementScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engagementScore', Sort.asc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      thenByEngagementScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engagementScore', Sort.desc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      thenByEnglishPracticeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishPracticeMinutes', Sort.asc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      thenByEnglishPracticeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishPracticeMinutes', Sort.desc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      thenByEnglishPracticeSessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishPracticeSessions', Sort.asc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      thenByEnglishPracticeSessionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishPracticeSessions', Sort.desc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      thenByIgnoredCheckIns() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ignoredCheckIns', Sort.asc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      thenByIgnoredCheckInsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ignoredCheckIns', Sort.desc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      thenByLastEngagedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEngagedAt', Sort.asc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      thenByLastEngagedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEngagedAt', Sort.desc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      thenByTotalCheckIns() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCheckIns', Sort.asc);
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QAfterSortBy>
      thenByTotalCheckInsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCheckIns', Sort.desc);
    });
  }
}

extension CompanionAnalyticsQueryWhereDistinct
    on QueryBuilder<CompanionAnalytics, CompanionAnalytics, QDistinct> {
  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QDistinct>
      distinctByCommonNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'commonNotes');
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QDistinct>
      distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QDistinct>
      distinctByEngagementScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'engagementScore');
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QDistinct>
      distinctByEnglishPracticeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'englishPracticeMinutes');
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QDistinct>
      distinctByEnglishPracticeSessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'englishPracticeSessions');
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QDistinct>
      distinctByFavoriteActivities() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'favoriteActivities');
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QDistinct>
      distinctByIgnoredCheckIns() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ignoredCheckIns');
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QDistinct>
      distinctByLastEngagedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastEngagedAt');
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QDistinct>
      distinctByTopDistractions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'topDistractions');
    });
  }

  QueryBuilder<CompanionAnalytics, CompanionAnalytics, QDistinct>
      distinctByTotalCheckIns() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalCheckIns');
    });
  }
}

extension CompanionAnalyticsQueryProperty
    on QueryBuilder<CompanionAnalytics, CompanionAnalytics, QQueryProperty> {
  QueryBuilder<CompanionAnalytics, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CompanionAnalytics, List<String>, QQueryOperations>
      commonNotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'commonNotes');
    });
  }

  QueryBuilder<CompanionAnalytics, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<CompanionAnalytics, double, QQueryOperations>
      engagementScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'engagementScore');
    });
  }

  QueryBuilder<CompanionAnalytics, int, QQueryOperations>
      englishPracticeMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'englishPracticeMinutes');
    });
  }

  QueryBuilder<CompanionAnalytics, int, QQueryOperations>
      englishPracticeSessionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'englishPracticeSessions');
    });
  }

  QueryBuilder<CompanionAnalytics, List<String>, QQueryOperations>
      favoriteActivitiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'favoriteActivities');
    });
  }

  QueryBuilder<CompanionAnalytics, int, QQueryOperations>
      ignoredCheckInsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ignoredCheckIns');
    });
  }

  QueryBuilder<CompanionAnalytics, DateTime, QQueryOperations>
      lastEngagedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastEngagedAt');
    });
  }

  QueryBuilder<CompanionAnalytics, List<String>, QQueryOperations>
      topDistractionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'topDistractions');
    });
  }

  QueryBuilder<CompanionAnalytics, int, QQueryOperations>
      totalCheckInsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalCheckIns');
    });
  }
}
