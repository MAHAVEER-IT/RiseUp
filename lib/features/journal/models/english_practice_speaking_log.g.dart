// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'english_practice_speaking_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEnglishPracticeSpeakingLogCollection on Isar {
  IsarCollection<EnglishPracticeSpeakingLog> get englishPracticeSpeakingLogs =>
      this.collection();
}

const EnglishPracticeSpeakingLogSchema = CollectionSchema(
  name: r'EnglishPracticeSpeakingLog',
  id: -3108887792513429886,
  properties: {
    r'comprensionRating': PropertySchema(
      id: 0,
      name: r'comprensionRating',
      type: IsarType.long,
    ),
    r'confidenceRating': PropertySchema(
      id: 1,
      name: r'confidenceRating',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'durationMinutes': PropertySchema(
      id: 3,
      name: r'durationMinutes',
      type: IsarType.long,
    ),
    r'fluencyRating': PropertySchema(
      id: 4,
      name: r'fluencyRating',
      type: IsarType.long,
    ),
    r'medium': PropertySchema(
      id: 5,
      name: r'medium',
      type: IsarType.byte,
      enumMap: _EnglishPracticeSpeakingLogmediumEnumValueMap,
    ),
    r'notes': PropertySchema(
      id: 6,
      name: r'notes',
      type: IsarType.string,
    ),
    r'streakDays': PropertySchema(
      id: 7,
      name: r'streakDays',
      type: IsarType.long,
    ),
    r'timestamp': PropertySchema(
      id: 8,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'topic': PropertySchema(
      id: 9,
      name: r'topic',
      type: IsarType.string,
    )
  },
  estimateSize: _englishPracticeSpeakingLogEstimateSize,
  serialize: _englishPracticeSpeakingLogSerialize,
  deserialize: _englishPracticeSpeakingLogDeserialize,
  deserializeProp: _englishPracticeSpeakingLogDeserializeProp,
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
  getId: _englishPracticeSpeakingLogGetId,
  getLinks: _englishPracticeSpeakingLogGetLinks,
  attach: _englishPracticeSpeakingLogAttach,
  version: '3.1.0+1',
);

int _englishPracticeSpeakingLogEstimateSize(
  EnglishPracticeSpeakingLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.topic;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _englishPracticeSpeakingLogSerialize(
  EnglishPracticeSpeakingLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.comprensionRating);
  writer.writeLong(offsets[1], object.confidenceRating);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeLong(offsets[3], object.durationMinutes);
  writer.writeLong(offsets[4], object.fluencyRating);
  writer.writeByte(offsets[5], object.medium.index);
  writer.writeString(offsets[6], object.notes);
  writer.writeLong(offsets[7], object.streakDays);
  writer.writeDateTime(offsets[8], object.timestamp);
  writer.writeString(offsets[9], object.topic);
}

EnglishPracticeSpeakingLog _englishPracticeSpeakingLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EnglishPracticeSpeakingLog(
    comprensionRating: reader.readLongOrNull(offsets[0]),
    confidenceRating: reader.readLongOrNull(offsets[1]),
    durationMinutes: reader.readLong(offsets[3]),
    fluencyRating: reader.readLongOrNull(offsets[4]),
    medium: _EnglishPracticeSpeakingLogmediumValueEnumMap[
            reader.readByteOrNull(offsets[5])] ??
        PracticeMedium.conversation,
    notes: reader.readStringOrNull(offsets[6]),
    streakDays: reader.readLongOrNull(offsets[7]) ?? 0,
    timestamp: reader.readDateTime(offsets[8]),
    topic: reader.readStringOrNull(offsets[9]),
  );
  object.createdAt = reader.readDateTime(offsets[2]);
  object.id = id;
  return object;
}

P _englishPracticeSpeakingLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (_EnglishPracticeSpeakingLogmediumValueEnumMap[
              reader.readByteOrNull(offset)] ??
          PracticeMedium.conversation) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _EnglishPracticeSpeakingLogmediumEnumValueMap = {
  'conversation': 0,
  'videoCall': 1,
  'voiceRecording': 2,
  'monologue': 3,
  'classroom': 4,
  'other': 5,
};
const _EnglishPracticeSpeakingLogmediumValueEnumMap = {
  0: PracticeMedium.conversation,
  1: PracticeMedium.videoCall,
  2: PracticeMedium.voiceRecording,
  3: PracticeMedium.monologue,
  4: PracticeMedium.classroom,
  5: PracticeMedium.other,
};

Id _englishPracticeSpeakingLogGetId(EnglishPracticeSpeakingLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _englishPracticeSpeakingLogGetLinks(
    EnglishPracticeSpeakingLog object) {
  return [];
}

void _englishPracticeSpeakingLogAttach(
    IsarCollection<dynamic> col, Id id, EnglishPracticeSpeakingLog object) {
  object.id = id;
}

extension EnglishPracticeSpeakingLogQueryWhereSort on QueryBuilder<
    EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog, QWhere> {
  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhere> anyTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'timestamp'),
      );
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension EnglishPracticeSpeakingLogQueryWhere on QueryBuilder<
    EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog, QWhereClause> {
  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhereClause> idBetween(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhereClause> timestampEqualTo(DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'timestamp',
        value: [timestamp],
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhereClause> timestampNotEqualTo(DateTime timestamp) {
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhereClause> timestampGreaterThan(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhereClause> timestampLessThan(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhereClause> timestampBetween(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhereClause> createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhereClause> createdAtNotEqualTo(DateTime createdAt) {
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhereClause> createdAtGreaterThan(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhereClause> createdAtLessThan(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterWhereClause> createdAtBetween(
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

extension EnglishPracticeSpeakingLogQueryFilter on QueryBuilder<
    EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog, QFilterCondition> {
  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> comprensionRatingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'comprensionRating',
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> comprensionRatingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'comprensionRating',
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> comprensionRatingEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'comprensionRating',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> comprensionRatingGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'comprensionRating',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> comprensionRatingLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'comprensionRating',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> comprensionRatingBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'comprensionRating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> confidenceRatingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'confidenceRating',
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> confidenceRatingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'confidenceRating',
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> confidenceRatingEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'confidenceRating',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> confidenceRatingGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'confidenceRating',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> confidenceRatingLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'confidenceRating',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> confidenceRatingBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'confidenceRating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> durationMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> durationMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> durationMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> durationMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> fluencyRatingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fluencyRating',
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> fluencyRatingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fluencyRating',
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> fluencyRatingEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fluencyRating',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> fluencyRatingGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fluencyRating',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> fluencyRatingLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fluencyRating',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> fluencyRatingBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fluencyRating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> mediumEqualTo(PracticeMedium value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'medium',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> mediumGreaterThan(
    PracticeMedium value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'medium',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> mediumLessThan(
    PracticeMedium value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'medium',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> mediumBetween(
    PracticeMedium lower,
    PracticeMedium upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'medium',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> notesEqualTo(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> notesGreaterThan(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> notesLessThan(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> notesBetween(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> notesStartsWith(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> notesEndsWith(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
          QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
          QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> streakDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> streakDaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'streakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> streakDaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'streakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> streakDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'streakDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> timestampGreaterThan(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> timestampLessThan(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> timestampBetween(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> topicIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'topic',
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> topicIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'topic',
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> topicEqualTo(
    String? value, {
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> topicGreaterThan(
    String? value, {
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> topicLessThan(
    String? value, {
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> topicBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> topicStartsWith(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> topicEndsWith(
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

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
          QAfterFilterCondition>
      topicContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'topic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
          QAfterFilterCondition>
      topicMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'topic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> topicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topic',
        value: '',
      ));
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterFilterCondition> topicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'topic',
        value: '',
      ));
    });
  }
}

extension EnglishPracticeSpeakingLogQueryObject on QueryBuilder<
    EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog, QFilterCondition> {}

extension EnglishPracticeSpeakingLogQueryLinks on QueryBuilder<
    EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog, QFilterCondition> {}

extension EnglishPracticeSpeakingLogQuerySortBy on QueryBuilder<
    EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog, QSortBy> {
  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByComprensionRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comprensionRating', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByComprensionRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comprensionRating', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByConfidenceRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceRating', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByConfidenceRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceRating', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMinutes', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMinutes', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByFluencyRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fluencyRating', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByFluencyRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fluencyRating', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByMedium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medium', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByMediumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medium', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakDays', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByStreakDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakDays', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByTopic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topic', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> sortByTopicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topic', Sort.desc);
    });
  }
}

extension EnglishPracticeSpeakingLogQuerySortThenBy on QueryBuilder<
    EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog, QSortThenBy> {
  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByComprensionRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comprensionRating', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByComprensionRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comprensionRating', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByConfidenceRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceRating', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByConfidenceRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceRating', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMinutes', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMinutes', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByFluencyRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fluencyRating', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByFluencyRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fluencyRating', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByMedium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medium', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByMediumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medium', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakDays', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByStreakDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streakDays', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByTopic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topic', Sort.asc);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QAfterSortBy> thenByTopicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topic', Sort.desc);
    });
  }
}

extension EnglishPracticeSpeakingLogQueryWhereDistinct on QueryBuilder<
    EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog, QDistinct> {
  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QDistinct> distinctByComprensionRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comprensionRating');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QDistinct> distinctByConfidenceRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'confidenceRating');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QDistinct> distinctByDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationMinutes');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QDistinct> distinctByFluencyRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fluencyRating');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QDistinct> distinctByMedium() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'medium');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QDistinct> distinctByNotes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QDistinct> distinctByStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'streakDays');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog,
      QDistinct> distinctByTopic({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'topic', caseSensitive: caseSensitive);
    });
  }
}

extension EnglishPracticeSpeakingLogQueryProperty on QueryBuilder<
    EnglishPracticeSpeakingLog, EnglishPracticeSpeakingLog, QQueryProperty> {
  QueryBuilder<EnglishPracticeSpeakingLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, int?, QQueryOperations>
      comprensionRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comprensionRating');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, int?, QQueryOperations>
      confidenceRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'confidenceRating');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, int, QQueryOperations>
      durationMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationMinutes');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, int?, QQueryOperations>
      fluencyRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fluencyRating');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, PracticeMedium, QQueryOperations>
      mediumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'medium');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, String?, QQueryOperations>
      notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, int, QQueryOperations>
      streakDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'streakDays');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, DateTime, QQueryOperations>
      timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<EnglishPracticeSpeakingLog, String?, QQueryOperations>
      topicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'topic');
    });
  }
}
