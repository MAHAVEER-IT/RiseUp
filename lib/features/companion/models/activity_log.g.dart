// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetActivityLogCollection on Isar {
  IsarCollection<ActivityLog> get activityLogs => this.collection();
}

const ActivityLogSchema = CollectionSchema(
  name: r'ActivityLog',
  id: -3240605868618876905,
  properties: {
    r'activity': PropertySchema(
      id: 0,
      name: r'activity',
      type: IsarType.byte,
      enumMap: _ActivityLogactivityEnumValueMap,
    ),
    r'additionalNote': PropertySchema(
      id: 1,
      name: r'additionalNote',
      type: IsarType.string,
    ),
    r'aiEncouragement': PropertySchema(
      id: 2,
      name: r'aiEncouragement',
      type: IsarType.string,
    ),
    r'aiFocusGuidance': PropertySchema(
      id: 3,
      name: r'aiFocusGuidance',
      type: IsarType.string,
    ),
    r'aiResponseGenerated': PropertySchema(
      id: 4,
      name: r'aiResponseGenerated',
      type: IsarType.bool,
    ),
    r'aiSuggestion': PropertySchema(
      id: 5,
      name: r'aiSuggestion',
      type: IsarType.string,
    ),
    r'energyLevel': PropertySchema(
      id: 6,
      name: r'energyLevel',
      type: IsarType.long,
    ),
    r'moodRating': PropertySchema(
      id: 7,
      name: r'moodRating',
      type: IsarType.long,
    ),
    r'timestamp': PropertySchema(
      id: 8,
      name: r'timestamp',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _activityLogEstimateSize,
  serialize: _activityLogSerialize,
  deserialize: _activityLogDeserialize,
  deserializeProp: _activityLogDeserializeProp,
  idName: r'id',
  indexes: {
    r'timestamp': IndexSchema(
      id: 1852253767416892198,
      name: r'timestamp',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'timestamp',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _activityLogGetId,
  getLinks: _activityLogGetLinks,
  attach: _activityLogAttach,
  version: '3.1.0+1',
);

int _activityLogEstimateSize(
  ActivityLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.additionalNote;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.aiEncouragement;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.aiFocusGuidance;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.aiSuggestion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _activityLogSerialize(
  ActivityLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.activity.index);
  writer.writeString(offsets[1], object.additionalNote);
  writer.writeString(offsets[2], object.aiEncouragement);
  writer.writeString(offsets[3], object.aiFocusGuidance);
  writer.writeBool(offsets[4], object.aiResponseGenerated);
  writer.writeString(offsets[5], object.aiSuggestion);
  writer.writeLong(offsets[6], object.energyLevel);
  writer.writeLong(offsets[7], object.moodRating);
  writer.writeDateTime(offsets[8], object.timestamp);
}

ActivityLog _activityLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ActivityLog();
  object.activity =
      _ActivityLogactivityValueEnumMap[reader.readByteOrNull(offsets[0])] ??
          ActivityType.inLecture;
  object.additionalNote = reader.readStringOrNull(offsets[1]);
  object.aiEncouragement = reader.readStringOrNull(offsets[2]);
  object.aiFocusGuidance = reader.readStringOrNull(offsets[3]);
  object.aiResponseGenerated = reader.readBool(offsets[4]);
  object.aiSuggestion = reader.readStringOrNull(offsets[5]);
  object.energyLevel = reader.readLongOrNull(offsets[6]);
  object.id = id;
  object.moodRating = reader.readLongOrNull(offsets[7]);
  object.timestamp = reader.readDateTime(offsets[8]);
  return object;
}

P _activityLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_ActivityLogactivityValueEnumMap[reader.readByteOrNull(offset)] ??
          ActivityType.inLecture) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ActivityLogactivityEnumValueMap = {
  'inLecture': 0,
  'studying': 1,
  'dsa': 2,
  'dbms': 3,
  'englishPractice': 4,
  'projectWork': 5,
  'takingBreak': 6,
  'instagram': 7,
  'youtube': 8,
  'feelingTired': 9,
  'feelingLow': 10,
  'other': 11,
};
const _ActivityLogactivityValueEnumMap = {
  0: ActivityType.inLecture,
  1: ActivityType.studying,
  2: ActivityType.dsa,
  3: ActivityType.dbms,
  4: ActivityType.englishPractice,
  5: ActivityType.projectWork,
  6: ActivityType.takingBreak,
  7: ActivityType.instagram,
  8: ActivityType.youtube,
  9: ActivityType.feelingTired,
  10: ActivityType.feelingLow,
  11: ActivityType.other,
};

Id _activityLogGetId(ActivityLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _activityLogGetLinks(ActivityLog object) {
  return [];
}

void _activityLogAttach(
    IsarCollection<dynamic> col, Id id, ActivityLog object) {
  object.id = id;
}

extension ActivityLogQueryWhereSort
    on QueryBuilder<ActivityLog, ActivityLog, QWhere> {
  QueryBuilder<ActivityLog, ActivityLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterWhere> anyTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'timestamp'),
      );
    });
  }
}

extension ActivityLogQueryWhere
    on QueryBuilder<ActivityLog, ActivityLog, QWhereClause> {
  QueryBuilder<ActivityLog, ActivityLog, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ActivityLog, ActivityLog, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterWhereClause> idBetween(
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

  QueryBuilder<ActivityLog, ActivityLog, QAfterWhereClause> timestampEqualTo(
      DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'timestamp',
        value: [timestamp],
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterWhereClause> timestampNotEqualTo(
      DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [],
              upper: [timestamp],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [timestamp],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [timestamp],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [],
              upper: [timestamp],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterWhereClause>
      timestampGreaterThan(
    DateTime timestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [timestamp],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterWhereClause> timestampLessThan(
    DateTime timestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [],
        upper: [timestamp],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterWhereClause> timestampBetween(
    DateTime lowerTimestamp,
    DateTime upperTimestamp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [lowerTimestamp],
        includeLower: includeLower,
        upper: [upperTimestamp],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ActivityLogQueryFilter
    on QueryBuilder<ActivityLog, ActivityLog, QFilterCondition> {
  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition> activityEqualTo(
      ActivityType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activity',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      activityGreaterThan(
    ActivityType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activity',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      activityLessThan(
    ActivityType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activity',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition> activityBetween(
    ActivityType lower,
    ActivityType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      additionalNoteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'additionalNote',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      additionalNoteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'additionalNote',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      additionalNoteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'additionalNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      additionalNoteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'additionalNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      additionalNoteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'additionalNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      additionalNoteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'additionalNote',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      additionalNoteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'additionalNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      additionalNoteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'additionalNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      additionalNoteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'additionalNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      additionalNoteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'additionalNote',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      additionalNoteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'additionalNote',
        value: '',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      additionalNoteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'additionalNote',
        value: '',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiEncouragementIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'aiEncouragement',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiEncouragementIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'aiEncouragement',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiEncouragementEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiEncouragement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiEncouragementGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aiEncouragement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiEncouragementLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aiEncouragement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiEncouragementBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aiEncouragement',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiEncouragementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aiEncouragement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiEncouragementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aiEncouragement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiEncouragementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aiEncouragement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiEncouragementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aiEncouragement',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiEncouragementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiEncouragement',
        value: '',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiEncouragementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aiEncouragement',
        value: '',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiFocusGuidanceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'aiFocusGuidance',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiFocusGuidanceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'aiFocusGuidance',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiFocusGuidanceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiFocusGuidance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiFocusGuidanceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aiFocusGuidance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiFocusGuidanceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aiFocusGuidance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiFocusGuidanceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aiFocusGuidance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiFocusGuidanceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aiFocusGuidance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiFocusGuidanceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aiFocusGuidance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiFocusGuidanceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aiFocusGuidance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiFocusGuidanceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aiFocusGuidance',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiFocusGuidanceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiFocusGuidance',
        value: '',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiFocusGuidanceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aiFocusGuidance',
        value: '',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiResponseGeneratedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiResponseGenerated',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiSuggestionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'aiSuggestion',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiSuggestionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'aiSuggestion',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiSuggestionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiSuggestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiSuggestionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aiSuggestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiSuggestionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aiSuggestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiSuggestionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aiSuggestion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiSuggestionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aiSuggestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiSuggestionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aiSuggestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiSuggestionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aiSuggestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiSuggestionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aiSuggestion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiSuggestionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiSuggestion',
        value: '',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      aiSuggestionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aiSuggestion',
        value: '',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      energyLevelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'energyLevel',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      energyLevelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'energyLevel',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      energyLevelEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'energyLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      energyLevelGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'energyLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      energyLevelLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'energyLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      energyLevelBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'energyLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      moodRatingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'moodRating',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      moodRatingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'moodRating',
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      moodRatingEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'moodRating',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      moodRatingGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'moodRating',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      moodRatingLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'moodRating',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      moodRatingBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'moodRating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ActivityLogQueryObject
    on QueryBuilder<ActivityLog, ActivityLog, QFilterCondition> {}

extension ActivityLogQueryLinks
    on QueryBuilder<ActivityLog, ActivityLog, QFilterCondition> {}

extension ActivityLogQuerySortBy
    on QueryBuilder<ActivityLog, ActivityLog, QSortBy> {
  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> sortByActivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activity', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> sortByActivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activity', Sort.desc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> sortByAdditionalNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalNote', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy>
      sortByAdditionalNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalNote', Sort.desc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> sortByAiEncouragement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiEncouragement', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy>
      sortByAiEncouragementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiEncouragement', Sort.desc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> sortByAiFocusGuidance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiFocusGuidance', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy>
      sortByAiFocusGuidanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiFocusGuidance', Sort.desc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy>
      sortByAiResponseGenerated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiResponseGenerated', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy>
      sortByAiResponseGeneratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiResponseGenerated', Sort.desc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> sortByAiSuggestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiSuggestion', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy>
      sortByAiSuggestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiSuggestion', Sort.desc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> sortByEnergyLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyLevel', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> sortByEnergyLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyLevel', Sort.desc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> sortByMoodRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodRating', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> sortByMoodRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodRating', Sort.desc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension ActivityLogQuerySortThenBy
    on QueryBuilder<ActivityLog, ActivityLog, QSortThenBy> {
  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> thenByActivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activity', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> thenByActivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activity', Sort.desc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> thenByAdditionalNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalNote', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy>
      thenByAdditionalNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalNote', Sort.desc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> thenByAiEncouragement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiEncouragement', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy>
      thenByAiEncouragementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiEncouragement', Sort.desc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> thenByAiFocusGuidance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiFocusGuidance', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy>
      thenByAiFocusGuidanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiFocusGuidance', Sort.desc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy>
      thenByAiResponseGenerated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiResponseGenerated', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy>
      thenByAiResponseGeneratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiResponseGenerated', Sort.desc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> thenByAiSuggestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiSuggestion', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy>
      thenByAiSuggestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiSuggestion', Sort.desc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> thenByEnergyLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyLevel', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> thenByEnergyLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyLevel', Sort.desc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> thenByMoodRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodRating', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> thenByMoodRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodRating', Sort.desc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QAfterSortBy> thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension ActivityLogQueryWhereDistinct
    on QueryBuilder<ActivityLog, ActivityLog, QDistinct> {
  QueryBuilder<ActivityLog, ActivityLog, QDistinct> distinctByActivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activity');
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QDistinct> distinctByAdditionalNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'additionalNote',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QDistinct> distinctByAiEncouragement(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aiEncouragement',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QDistinct> distinctByAiFocusGuidance(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aiFocusGuidance',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QDistinct>
      distinctByAiResponseGenerated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aiResponseGenerated');
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QDistinct> distinctByAiSuggestion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aiSuggestion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QDistinct> distinctByEnergyLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'energyLevel');
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QDistinct> distinctByMoodRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'moodRating');
    });
  }

  QueryBuilder<ActivityLog, ActivityLog, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension ActivityLogQueryProperty
    on QueryBuilder<ActivityLog, ActivityLog, QQueryProperty> {
  QueryBuilder<ActivityLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ActivityLog, ActivityType, QQueryOperations> activityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activity');
    });
  }

  QueryBuilder<ActivityLog, String?, QQueryOperations>
      additionalNoteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'additionalNote');
    });
  }

  QueryBuilder<ActivityLog, String?, QQueryOperations>
      aiEncouragementProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aiEncouragement');
    });
  }

  QueryBuilder<ActivityLog, String?, QQueryOperations>
      aiFocusGuidanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aiFocusGuidance');
    });
  }

  QueryBuilder<ActivityLog, bool, QQueryOperations>
      aiResponseGeneratedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aiResponseGenerated');
    });
  }

  QueryBuilder<ActivityLog, String?, QQueryOperations> aiSuggestionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aiSuggestion');
    });
  }

  QueryBuilder<ActivityLog, int?, QQueryOperations> energyLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'energyLevel');
    });
  }

  QueryBuilder<ActivityLog, int?, QQueryOperations> moodRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'moodRating');
    });
  }

  QueryBuilder<ActivityLog, DateTime, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}
