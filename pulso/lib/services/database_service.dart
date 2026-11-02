import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._();
  DatabaseService._();

  late Database _db;

  Future<void> init() async {
    final path = join(await getDatabasesPath(), 'pulso.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE records (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type TEXT NOT NULL,
            value TEXT,
            energy INTEGER,
            timestamp INTEGER NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE settings (
            key TEXT PRIMARY KEY,
            value TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertRecord(String type, {String? value, int? energy}) async {
    await _db.insert('records', {
      'type': type,
      'value': value,
      'energy': energy,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<Map<String, dynamic>>> getRecords(String type) async {
    return await _db.query('records', where: 'type = ?', whereArgs: [type], orderBy: 'timestamp DESC');
  }

  Future<int> getWaterTotal() async {
    final result = await _db.rawQuery('SELECT SUM(CAST(value AS INTEGER)) as total FROM records WHERE type = ?', ['water']);
    return (result.first['total'] as int?) ?? 0;
  }

  Future<int> getCount(String type) async {
    final result = await _db.rawQuery('SELECT COUNT(*) as count FROM records WHERE type = ?', [type]);
    return (result.first['count'] as int?) ?? 0;
  }
}
