import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  final int version = 1;
  final String databaseName = 'nesthub_database.db';
  final String favoriteTable = 'favorites';

  Database? _db;

  Future<Database> openDb() async {
    _db ??= await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: version,
      onCreate: (db, version) async {
        String query = '''
          CREATE TABLE $favoriteTable (
            userId INTEGER PRIMARY KEY,
            district TEXT,
            street TEXT,
            title TEXT,
            city TEXT,
            price INTEGER,
            photoUrl TEXT,
            descriptionMessage TEXT,
            localCategoryId INTEGER
          )
        ''';
        await db.execute(query);
      },
    );
    return _db as Database;
  }
}