
import 'package:sqflite/sqflite.dart';
import '../data/app_db.dart';
import '../models/item.dart';

class ItemRepo {
  final AppDb _dbProvider = AppDb();

  Future<int> insert(Item item) async {
    final db = await _dbProvider.database;
    return db.insert('items', item.toMap()..remove('id'));
  }

  Future<int> update(Item item) async {
    final db = await _dbProvider.database;
    return db.update('items', item.toMap()..remove('id'), where: 'id=?', whereArgs: [item.id]);
  }

  Future<int> delete(int id) async {
    final db = await _dbProvider.database;
    return db.delete('items', where: 'id=?', whereArgs: [id]);
  }

  Future<List<Item>> all({String? query}) async {
    final db = await _dbProvider.database;
    List<Map<String, dynamic>> rows;
    if (query != null && query.trim().isNotEmpty) {
      final q = '%${query.trim()}%';
      rows = await db.query('items', where: 'name LIKE ? OR barcode LIKE ? OR sku LIKE ?', whereArgs: [q, q, q], orderBy: 'name ASC');
    } else {
      rows = await db.query('items', orderBy: 'name ASC');
    }
    return rows.map((m) => Item.fromMap(m)).toList();
  }

  Future<Item?> byId(int id) async {
    final db = await _dbProvider.database;
    final rows = await db.query('items', where: 'id=?', whereArgs: [id], limit: 1);
    if (rows.isEmpty) return null;
    return Item.fromMap(rows.first);
  }
}
