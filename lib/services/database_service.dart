import 'package:path/path.dart' as path;
import 'package:qr_scanner/model.dart/scann_history_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = path.join(await getDatabasesPath(), 'scan_history.db');
    final db = await openDatabase(
      dbPath,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
    CREATE TABLE scan_history (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      time TEXT NOT NULL,
      isFav INTEGER NOT NULL,
      content TEXT NOT NULL,
      image TEXT NOT NULL,
     
      category INTEGER NOT NULL
    );
  ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Add the new columns if upgrading from version 1 to 2
          await db.execute("ALTER TABLE scan_history ADD COLUMN title TEXT");
        }
      },
    );

    return db;
  }

  Future<int> insertScan(ScanHistoryModel history) async {
    final db = await database;
    int id = await db.insert(
      'scan_history',
      history.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  Future<List<ScanHistoryModel>> getHistory() async {
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query(
      'scan_history',
      orderBy: 'time DESC',
    );
    return data.map((history) => ScanHistoryModel.fromMap(history)).toList();
  }

  Future<ScanHistoryModel?> getSingleHistory(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> data =
        await db.query('scan_history', where: 'id = ?', whereArgs: [id]);
    if (data.isEmpty) return null;
    return ScanHistoryModel.fromMap(data.first);
  }

  Future<bool> updateTitle(int id, String newTitle) async {
    final db = await database;
    final count = await db.update(
      'scan_history',
      {'title': newTitle},
      where: 'id = ?',
      whereArgs: [id],
    );

    return count > 0;
  }

  Future<void> updateFav(int id, bool isFav) async {
    final db = await database;
    await db.update(
      'scan_history',
      {'isFav': isFav},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
