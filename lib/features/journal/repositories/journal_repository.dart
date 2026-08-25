import 'package:isar/isar.dart';
import '../models/reflection.dart';

class JournalRepository {
  final Isar isar;

  JournalRepository(this.isar);

  Future<void> saveReflection(Reflection reflection) async {
    await isar.writeTxn(() async {
      await isar.reflections.put(reflection);
    });
  }

  Future<Reflection?> getReflectionForDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    return await isar.reflections.where().dateEqualTo(startOfDay).findFirst();
  }

  Future<List<Reflection>> getReflectionsForLastDays(int days) async {
    final startDate = DateTime.now().subtract(Duration(days: days));
    return await isar.reflections
        .filter()
        .dateGreaterThan(startDate)
        .sortByDateDesc()
        .findAll();
  }
}
