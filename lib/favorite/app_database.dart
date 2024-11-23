import 'package:nesthub/features/local/domain/local.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  final int version = 2;
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
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db
              .execute('ALTER TABLE $favoriteTable RENAME TO old_favorites;');

          await db.execute('''
       CREATE TABLE $favoriteTable (
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         userId INTEGER,
         district TEXT,
         street TEXT,
         title TEXT,
         city TEXT,
         price INTEGER,
         photoUrl TEXT,
         descriptionMessage TEXT,
         localCategoryId INTEGER
       );
     ''');

          await db.execute('''
       INSERT INTO $favoriteTable (userId, district, street, title, city, price, photoUrl, descriptionMessage, localCategoryId)
       SELECT userId, district, street, title, city, price, photoUrl, descriptionMessage, localCategoryId
       FROM old_favorites;
     ''');

          await db.execute('DROP TABLE old_favorites;');
        }
      },
    );
    return _db!;
  }

  Future<void> insertFavorite(Local local) async {
    final db = await openDb();

    await db.insert(
      favoriteTable,
      local.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
