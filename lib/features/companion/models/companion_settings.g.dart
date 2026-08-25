// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companion_settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCompanionSettingsCollection on Isar {
  IsarCollection<CompanionSettings> get companionSettings => this.collection();
}

const CompanionSettingsSchema = CollectionSchema(
  name: r'CompanionSettings',
  id: -6481141160710101724,
  properties: {
    r'autoReduceFrequencyOnIgnore': PropertySchema(
      id: 0,
      name: r'autoReduceFrequencyOnIgnore',
      type: IsarType.bool,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'enableWeeklyInsights': PropertySchema(
      id: 2,
      name: r'enableWeeklyInsights',
      type: IsarType.bool,
    ),
    r'minimumGapBetweenCheckInsMinutes': PropertySchema(
      id: 3,
      name: r'minimumGapBetweenCheckInsMinutes',
      type: IsarType.long,
    ),
    r'mode': PropertySchema(
      id: 4,
      name: r'mode',
      type: IsarType.string,
    ),
    r'notificationsEnabled': PropertySchema(
      id: 5,
      name: r'notificationsEnabled',
      type: IsarType.bool,
    ),
    r'quietHoursEnabled': PropertySchema(
      id: 6,
      name: r'quietHoursEnabled',
      type: IsarType.bool,
    ),
    r'quietHoursEnd': PropertySchema(
      id: 7,
      name: r'quietHoursEnd',
      type: IsarType.long,
    ),
    r'quietHoursStart': PropertySchema(
      id: 8,
      name: r'quietHoursStart',
      type: IsarType.long,
    ),
    r'soundEnabled': PropertySchema(
      id: 9,
      name: r'soundEnabled',
      type: IsarType.bool,
    ),
    r'trackEnergy': PropertySchema(
      id: 10,
      name: r'trackEnergy',
      type: IsarType.bool,
    ),
    r'trackMood': PropertySchema(
      id: 11,
      name: r'trackMood',
      type: IsarType.bool,
    ),
    r'updatedAt': PropertySchema(
      id: 12,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'useFormalTone': PropertySchema(
      id: 13,
      name: r'useFormalTone',
      type: IsarType.bool,
    ),
    r'vibrationEnabled': PropertySchema(
      id: 14,
      name: r'vibrationEnabled',
      type: IsarType.bool,
    )
  },
  estimateSize: _companionSettingsEstimateSize,
  serialize: _companionSettingsSerialize,
  deserialize: _companionSettingsDeserialize,
  deserializeProp: _companionSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _companionSettingsGetId,
  getLinks: _companionSettingsGetLinks,
  attach: _companionSettingsAttach,
  version: '3.1.0+1',
);

int _companionSettingsEstimateSize(
  CompanionSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.mode.length * 3;
  return bytesCount;
}

void _companionSettingsSerialize(
  CompanionSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.autoReduceFrequencyOnIgnore);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeBool(offsets[2], object.enableWeeklyInsights);
  writer.writeLong(offsets[3], object.minimumGapBetweenCheckInsMinutes);
  writer.writeString(offsets[4], object.mode);
  writer.writeBool(offsets[5], object.notificationsEnabled);
  writer.writeBool(offsets[6], object.quietHoursEnabled);
  writer.writeLong(offsets[7], object.quietHoursEnd);
  writer.writeLong(offsets[8], object.quietHoursStart);
  writer.writeBool(offsets[9], object.soundEnabled);
  writer.writeBool(offsets[10], object.trackEnergy);
  writer.writeBool(offsets[11], object.trackMood);
  writer.writeDateTime(offsets[12], object.updatedAt);
  writer.writeBool(offsets[13], object.useFormalTone);
  writer.writeBool(offsets[14], object.vibrationEnabled);
}

CompanionSettings _companionSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CompanionSettings();
  object.autoReduceFrequencyOnIgnore = reader.readBool(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.enableWeeklyInsights = reader.readBool(offsets[2]);
  object.id = id;
  object.minimumGapBetweenCheckInsMinutes = reader.readLong(offsets[3]);
  object.mode = reader.readString(offsets[4]);
  object.notificationsEnabled = reader.readBool(offsets[5]);
  object.quietHoursEnabled = reader.readBool(offsets[6]);
  object.quietHoursEnd = reader.readLong(offsets[7]);
  object.quietHoursStart = reader.readLong(offsets[8]);
  object.soundEnabled = reader.readBool(offsets[9]);
  object.trackEnergy = reader.readBool(offsets[10]);
  object.trackMood = reader.readBool(offsets[11]);
  object.updatedAt = reader.readDateTime(offsets[12]);
  object.useFormalTone = reader.readBool(offsets[13]);
  object.vibrationEnabled = reader.readBool(offsets[14]);
  return object;
}

P _companionSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readDateTime(offset)) as P;
    case 13:
      return (reader.readBool(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _companionSettingsGetId(CompanionSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _companionSettingsGetLinks(
    CompanionSettings object) {
  return [];
}

void _companionSettingsAttach(
    IsarCollection<dynamic> col, Id id, CompanionSettings object) {
  object.id = id;
}

extension CompanionSettingsQueryWhereSort
    on QueryBuilder<CompanionSettings, CompanionSettings, QWhere> {
  QueryBuilder<CompanionSettings, CompanionSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CompanionSettingsQueryWhere
    on QueryBuilder<CompanionSettings, CompanionSettings, QWhereClause> {
  QueryBuilder<CompanionSettings, CompanionSettings, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterWhereClause>
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

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterWhereClause>
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
}

extension CompanionSettingsQueryFilter
    on QueryBuilder<CompanionSettings, CompanionSettings, QFilterCondition> {
  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      autoReduceFrequencyOnIgnoreEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autoReduceFrequencyOnIgnore',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
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

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
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

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
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

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      enableWeeklyInsightsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enableWeeklyInsights',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
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

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
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

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
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

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      minimumGapBetweenCheckInsMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minimumGapBetweenCheckInsMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      minimumGapBetweenCheckInsMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minimumGapBetweenCheckInsMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      minimumGapBetweenCheckInsMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minimumGapBetweenCheckInsMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      minimumGapBetweenCheckInsMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minimumGapBetweenCheckInsMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      modeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      modeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      modeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      modeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      modeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      modeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      modeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      modeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      modeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mode',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      modeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mode',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      notificationsEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationsEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      quietHoursEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quietHoursEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      quietHoursEndEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quietHoursEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      quietHoursEndGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quietHoursEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      quietHoursEndLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quietHoursEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      quietHoursEndBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quietHoursEnd',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      quietHoursStartEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quietHoursStart',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      quietHoursStartGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quietHoursStart',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      quietHoursStartLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quietHoursStart',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      quietHoursStartBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quietHoursStart',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      soundEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soundEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      trackEnergyEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackEnergy',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      trackMoodEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackMood',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
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

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
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

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
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

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      useFormalToneEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'useFormalTone',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterFilterCondition>
      vibrationEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vibrationEnabled',
        value: value,
      ));
    });
  }
}

extension CompanionSettingsQueryObject
    on QueryBuilder<CompanionSettings, CompanionSettings, QFilterCondition> {}

extension CompanionSettingsQueryLinks
    on QueryBuilder<CompanionSettings, CompanionSettings, QFilterCondition> {}

extension CompanionSettingsQuerySortBy
    on QueryBuilder<CompanionSettings, CompanionSettings, QSortBy> {
  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByAutoReduceFrequencyOnIgnore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoReduceFrequencyOnIgnore', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByAutoReduceFrequencyOnIgnoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoReduceFrequencyOnIgnore', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByEnableWeeklyInsights() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enableWeeklyInsights', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByEnableWeeklyInsightsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enableWeeklyInsights', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByMinimumGapBetweenCheckInsMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minimumGapBetweenCheckInsMinutes', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByMinimumGapBetweenCheckInsMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minimumGapBetweenCheckInsMinutes', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByNotificationsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByQuietHoursEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursEnabled', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByQuietHoursEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursEnabled', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByQuietHoursEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursEnd', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByQuietHoursEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursEnd', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByQuietHoursStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursStart', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByQuietHoursStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursStart', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortBySoundEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEnabled', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortBySoundEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEnabled', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByTrackEnergy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackEnergy', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByTrackEnergyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackEnergy', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByTrackMood() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackMood', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByTrackMoodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackMood', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByUseFormalTone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useFormalTone', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByUseFormalToneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useFormalTone', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByVibrationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrationEnabled', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      sortByVibrationEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrationEnabled', Sort.desc);
    });
  }
}

extension CompanionSettingsQuerySortThenBy
    on QueryBuilder<CompanionSettings, CompanionSettings, QSortThenBy> {
  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByAutoReduceFrequencyOnIgnore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoReduceFrequencyOnIgnore', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByAutoReduceFrequencyOnIgnoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoReduceFrequencyOnIgnore', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByEnableWeeklyInsights() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enableWeeklyInsights', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByEnableWeeklyInsightsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enableWeeklyInsights', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByMinimumGapBetweenCheckInsMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minimumGapBetweenCheckInsMinutes', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByMinimumGapBetweenCheckInsMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minimumGapBetweenCheckInsMinutes', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByNotificationsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByQuietHoursEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursEnabled', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByQuietHoursEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursEnabled', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByQuietHoursEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursEnd', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByQuietHoursEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursEnd', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByQuietHoursStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursStart', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByQuietHoursStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursStart', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenBySoundEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEnabled', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenBySoundEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEnabled', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByTrackEnergy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackEnergy', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByTrackEnergyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackEnergy', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByTrackMood() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackMood', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByTrackMoodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackMood', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByUseFormalTone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useFormalTone', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByUseFormalToneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useFormalTone', Sort.desc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByVibrationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrationEnabled', Sort.asc);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QAfterSortBy>
      thenByVibrationEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrationEnabled', Sort.desc);
    });
  }
}

extension CompanionSettingsQueryWhereDistinct
    on QueryBuilder<CompanionSettings, CompanionSettings, QDistinct> {
  QueryBuilder<CompanionSettings, CompanionSettings, QDistinct>
      distinctByAutoReduceFrequencyOnIgnore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'autoReduceFrequencyOnIgnore');
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QDistinct>
      distinctByEnableWeeklyInsights() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enableWeeklyInsights');
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QDistinct>
      distinctByMinimumGapBetweenCheckInsMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minimumGapBetweenCheckInsMinutes');
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QDistinct> distinctByMode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QDistinct>
      distinctByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationsEnabled');
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QDistinct>
      distinctByQuietHoursEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quietHoursEnabled');
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QDistinct>
      distinctByQuietHoursEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quietHoursEnd');
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QDistinct>
      distinctByQuietHoursStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quietHoursStart');
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QDistinct>
      distinctBySoundEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soundEnabled');
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QDistinct>
      distinctByTrackEnergy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackEnergy');
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QDistinct>
      distinctByTrackMood() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackMood');
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QDistinct>
      distinctByUseFormalTone() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'useFormalTone');
    });
  }

  QueryBuilder<CompanionSettings, CompanionSettings, QDistinct>
      distinctByVibrationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vibrationEnabled');
    });
  }
}

extension CompanionSettingsQueryProperty
    on QueryBuilder<CompanionSettings, CompanionSettings, QQueryProperty> {
  QueryBuilder<CompanionSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CompanionSettings, bool, QQueryOperations>
      autoReduceFrequencyOnIgnoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autoReduceFrequencyOnIgnore');
    });
  }

  QueryBuilder<CompanionSettings, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CompanionSettings, bool, QQueryOperations>
      enableWeeklyInsightsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enableWeeklyInsights');
    });
  }

  QueryBuilder<CompanionSettings, int, QQueryOperations>
      minimumGapBetweenCheckInsMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minimumGapBetweenCheckInsMinutes');
    });
  }

  QueryBuilder<CompanionSettings, String, QQueryOperations> modeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mode');
    });
  }

  QueryBuilder<CompanionSettings, bool, QQueryOperations>
      notificationsEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationsEnabled');
    });
  }

  QueryBuilder<CompanionSettings, bool, QQueryOperations>
      quietHoursEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quietHoursEnabled');
    });
  }

  QueryBuilder<CompanionSettings, int, QQueryOperations>
      quietHoursEndProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quietHoursEnd');
    });
  }

  QueryBuilder<CompanionSettings, int, QQueryOperations>
      quietHoursStartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quietHoursStart');
    });
  }

  QueryBuilder<CompanionSettings, bool, QQueryOperations>
      soundEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soundEnabled');
    });
  }

  QueryBuilder<CompanionSettings, bool, QQueryOperations>
      trackEnergyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackEnergy');
    });
  }

  QueryBuilder<CompanionSettings, bool, QQueryOperations> trackMoodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackMood');
    });
  }

  QueryBuilder<CompanionSettings, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<CompanionSettings, bool, QQueryOperations>
      useFormalToneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'useFormalTone');
    });
  }

  QueryBuilder<CompanionSettings, bool, QQueryOperations>
      vibrationEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vibrationEnabled');
    });
  }
}
