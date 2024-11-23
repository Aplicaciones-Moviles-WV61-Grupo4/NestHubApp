import 'package:nesthub/favorite/app_database.dart';
import 'package:nesthub/favorite/favorite_model.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDao {
  static const String tableName = 'favorites';
  final AppDatabase _appDatabase = AppDatabase();

  Future<Database> get _database async => await _appDatabase.openDb();

  Future<void> insert(FavoriteModel favorite) async {
    final db = await _database;
    await db.insert(
      tableName,
      favorite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(int id) async {
    // Modificado para eliminar por id
    final db = await _database;
    await db.delete(
      tableName,
      where:
          'id = ?', // Usamos el campo 'id' para eliminar el favorito específico
      whereArgs: [id],
    );
  }

  Future<List<FavoriteModel>> fetchAll() async {
    final db = await _database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return FavoriteModel.fromMap(maps[i]);
    });
  }

  Future<bool> isFavorite(int userId) async {
    final db = await _database;
    final result = await db.query(
      tableName,
      where: 'userId = ?',
      whereArgs: [userId],
      limit: 1,
    );
    return result.isNotEmpty;
  }
}
