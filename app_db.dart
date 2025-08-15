
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDb {
  static final AppDb _instance = AppDb._internal();
  factory AppDb() => _instance;
  AppDb._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = join(dir.path, 'pharmasoft.db');
    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await _createV1(db);
      },
      onUpgrade: (db, oldV, newV) async {
        // handle future migrations here
      },
    );
  }

  Future<void> _createV1(Database db) async {
    // Items
    await db.execute('''
      CREATE TABLE items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        barcode TEXT,
        sku TEXT,
        unit TEXT,
        price_sale REAL NOT NULL DEFAULT 0,
        price_purchase REAL NOT NULL DEFAULT 0,
        qty REAL NOT NULL DEFAULT 0,
        exp_date TEXT
      );
    ''');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_items_barcode ON items(barcode);');

    // Expenses
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        amount REAL NOT NULL DEFAULT 0,
        ts TEXT NOT NULL
      );
    ''');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_expenses_ts ON expenses(ts);');
  }
}
