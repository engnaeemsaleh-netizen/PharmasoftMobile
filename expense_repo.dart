
import 'package:sqflite/sqflite.dart';
import '../data/app_db.dart';
import '../models/expense.dart';

class ExpenseRepo {
  final AppDb _dbProvider = AppDb();

  Future<int> insert(Expense e) async {
    final db = await _dbProvider.database;
    return db.insert('expenses', e.toMap()..remove('id'));
  }

  Future<int> delete(int id) async {
    final db = await _dbProvider.database;
    return db.delete('expenses', where: 'id=?', whereArgs: [id]);
  }

  Future<List<Expense>> between(String fromIso, String toIso) async {
    final db = await _dbProvider.database;
    final rows = await db.query(
      'expenses',
      where: 'ts BETWEEN ? AND ?',
      whereArgs: [fromIso, toIso],
      orderBy: 'ts DESC',
    );
    return rows.map((m) => Expense.fromMap(m)).toList();
  }

  Future<List<Expense>> all() async {
    final db = await _dbProvider.database;
    final rows = await db.query('expenses', orderBy: 'ts DESC');
    return rows.map((m) => Expense.fromMap(m)).toList();
  }
}
