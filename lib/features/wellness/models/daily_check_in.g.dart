// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_check_in.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDailyCheckInCollection on Isar {
  IsarCollection<DailyCheckIn> get dailyCheckIns => this.collection();
}

const DailyCheckInSchema = CollectionSchema(
  name: r'DailyCheckIn',
  id: -527065190331744543,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'energyScore': PropertySchema(
      id: 1,
      name: r'energyScore',
      type: IsarType.byte,
    ),
    r'eveningCompleted': PropertySchema(
      id: 2,
      name: r'eveningCompleted',
      type: IsarType.bool,
    ),
    r'eveningReflection': PropertySchema(
      id: 3,
      name: r'eveningReflection',
      type: IsarType.string,
    ),
    r'moodScore': PropertySchema(
      id: 4,
      name: r'moodScore',
      type: IsarType.byte,
    ),
    r'morningCompleted': PropertySchema(
      id: 5,
      name: r'morningCompleted',
      type: IsarType.bool,
    )
  },
  estimateSize: _dailyCheckInEstimateSize,
  serialize: _dailyCheckInSerialize,
  deserialize: _dailyCheckInDeserialize,
  deserializeProp: _dailyCheckInDeserializeProp,
  idName: r'id',
  indexes: {
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: true,
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
  getId: _dailyCheckInGetId,
  getLinks: _dailyCheckInGetLinks,
  attach: _dailyCheckInAttach,
  version: '3.1.0+1',
);

int _dailyCheckInEstimateSize(
  DailyCheckIn object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.eveningReflection;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _dailyCheckInSerialize(
  DailyCheckIn object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeByte(offsets[1], object.energyScore);
  writer.writeBool(offsets[2], object.eveningCompleted);
  writer.writeString(offsets[3], object.eveningReflection);
  writer.writeByte(offsets[4], object.moodScore);
  writer.writeBool(offsets[5], object.morningCompleted);
}

DailyCheckIn _dailyCheckInDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailyCheckIn();
  object.date = reader.readDateTime(offsets[0]);
  object.energyScore = reader.readByte(offsets[1]);
  object.eveningCompleted = reader.readBool(offsets[2]);
  object.eveningReflection = reader.readStringOrNull(offsets[3]);
  object.id = id;
  object.moodScore = reader.readByte(offsets[4]);
  object.morningCompleted = reader.readBool(offsets[5]);
  return object;
}

P _dailyCheckInDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readByte(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readByte(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dailyCheckInGetId(DailyCheckIn object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dailyCheckInGetLinks(DailyCheckIn object) {
  return [];
}

void _dailyCheckInAttach(
    IsarCollection<dynamic> col, Id id, DailyCheckIn object) {
  object.id = id;
}

extension DailyCheckInByIndex on IsarCollection<DailyCheckIn> {
  Future<DailyCheckIn?> getByDate(DateTime date) {
    return getByIndex(r'date', [date]);
  }

  DailyCheckIn? getByDateSync(DateTime date) {
    return getByIndexSync(r'date', [date]);
  }

  Future<bool> deleteByDate(DateTime date) {
    return deleteByIndex(r'date', [date]);
  }

  bool deleteByDateSync(DateTime date) {
    return deleteByIndexSync(r'date', [date]);
  }

  Future<List<DailyCheckIn?>> getAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndex(r'date', values);
  }

  List<DailyCheckIn?> getAllByDateSync(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'date', values);
  }

  Future<int> deleteAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'date', values);
  }

  int deleteAllByDateSync(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'date', values);
  }

  Future<Id> putByDate(DailyCheckIn object) {
    return putByIndex(r'date', object);
  }

  Id putByDateSync(DailyCheckIn object, {bool saveLinks = true}) {
    return putByIndexSync(r'date', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDate(List<DailyCheckIn> objects) {
    return putAllByIndex(r'date', objects);
  }

  List<Id> putAllByDateSync(List<DailyCheckIn> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'date', objects, saveLinks: saveLinks);
  }
}

extension DailyCheckInQueryWhereSort
    on QueryBuilder<DailyCheckIn, DailyCheckIn, QWhere> {
  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension DailyCheckInQueryWhere
    on QueryBuilder<DailyCheckIn, DailyCheckIn, QWhereClause> {
  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterWhereClause> idBetween(
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

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterWhereClause> dateEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterWhereClause> dateNotEqualTo(
      DateTime date) {
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

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterWhereClause> dateGreaterThan(
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

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterWhereClause> dateLessThan(
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

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterWhereClause> dateBetween(
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

extension DailyCheckInQueryFilter
    on QueryBuilder<DailyCheckIn, DailyCheckIn, QFilterCondition> {
  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
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

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition> dateLessThan(
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

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition> dateBetween(
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

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      energyScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'energyScore',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      energyScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'energyScore',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      energyScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'energyScore',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      energyScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'energyScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      eveningCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eveningCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      eveningReflectionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'eveningReflection',
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      eveningReflectionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'eveningReflection',
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      eveningReflectionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eveningReflection',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      eveningReflectionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'eveningReflection',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      eveningReflectionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'eveningReflection',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      eveningReflectionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'eveningReflection',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      eveningReflectionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'eveningReflection',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      eveningReflectionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'eveningReflection',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      eveningReflectionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'eveningReflection',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      eveningReflectionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'eveningReflection',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      eveningReflectionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eveningReflection',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      eveningReflectionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'eveningReflection',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      moodScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'moodScore',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      moodScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'moodScore',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      moodScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'moodScore',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      moodScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'moodScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterFilterCondition>
      morningCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'morningCompleted',
        value: value,
      ));
    });
  }
}

extension DailyCheckInQueryObject
    on QueryBuilder<DailyCheckIn, DailyCheckIn, QFilterCondition> {}

extension DailyCheckInQueryLinks
    on QueryBuilder<DailyCheckIn, DailyCheckIn, QFilterCondition> {}

extension DailyCheckInQuerySortBy
    on QueryBuilder<DailyCheckIn, DailyCheckIn, QSortBy> {
  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy> sortByEnergyScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyScore', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy>
      sortByEnergyScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyScore', Sort.desc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy>
      sortByEveningCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eveningCompleted', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy>
      sortByEveningCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eveningCompleted', Sort.desc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy>
      sortByEveningReflection() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eveningReflection', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy>
      sortByEveningReflectionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eveningReflection', Sort.desc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy> sortByMoodScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodScore', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy> sortByMoodScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodScore', Sort.desc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy>
      sortByMorningCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'morningCompleted', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy>
      sortByMorningCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'morningCompleted', Sort.desc);
    });
  }
}

extension DailyCheckInQuerySortThenBy
    on QueryBuilder<DailyCheckIn, DailyCheckIn, QSortThenBy> {
  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy> thenByEnergyScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyScore', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy>
      thenByEnergyScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyScore', Sort.desc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy>
      thenByEveningCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eveningCompleted', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy>
      thenByEveningCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eveningCompleted', Sort.desc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy>
      thenByEveningReflection() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eveningReflection', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy>
      thenByEveningReflectionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eveningReflection', Sort.desc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy> thenByMoodScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodScore', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy> thenByMoodScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moodScore', Sort.desc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy>
      thenByMorningCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'morningCompleted', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QAfterSortBy>
      thenByMorningCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'morningCompleted', Sort.desc);
    });
  }
}

extension DailyCheckInQueryWhereDistinct
    on QueryBuilder<DailyCheckIn, DailyCheckIn, QDistinct> {
  QueryBuilder<DailyCheckIn, DailyCheckIn, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QDistinct> distinctByEnergyScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'energyScore');
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QDistinct>
      distinctByEveningCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eveningCompleted');
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QDistinct>
      distinctByEveningReflection({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eveningReflection',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QDistinct> distinctByMoodScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'moodScore');
    });
  }

  QueryBuilder<DailyCheckIn, DailyCheckIn, QDistinct>
      distinctByMorningCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'morningCompleted');
    });
  }
}

extension DailyCheckInQueryProperty
    on QueryBuilder<DailyCheckIn, DailyCheckIn, QQueryProperty> {
  QueryBuilder<DailyCheckIn, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DailyCheckIn, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<DailyCheckIn, int, QQueryOperations> energyScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'energyScore');
    });
  }

  QueryBuilder<DailyCheckIn, bool, QQueryOperations>
      eveningCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eveningCompleted');
    });
  }

  QueryBuilder<DailyCheckIn, String?, QQueryOperations>
      eveningReflectionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eveningReflection');
    });
  }

  QueryBuilder<DailyCheckIn, int, QQueryOperations> moodScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'moodScore');
    });
  }

  QueryBuilder<DailyCheckIn, bool, QQueryOperations>
      morningCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'morningCompleted');
    });
  }
}
