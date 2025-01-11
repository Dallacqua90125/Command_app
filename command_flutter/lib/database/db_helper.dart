import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'comandas.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE comandas(id INTEGER PRIMARY KEY, descricao TEXT, valor REAL)',
        );
      },
      version: 1,
    );
  }

  static Future<void> addComanda(String descricao, double valor) async {
    final db = await initializeDatabase();
    await db.insert(
      'comandas',
      {'descricao': descricao, 'valor': valor},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
