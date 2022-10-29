import 'package:sqflite/sqflite.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavorite = 'favorites';

  /* initialize db and create db */
  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '${path}/favorite.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE ${_tblFavorite} (
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             pictureId TEXT,
             city TEXT,
             rating REAL
           )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  /* get db */
  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  /* add favorite restaurant to db */
  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tblFavorite, restaurant.toJson());
  }

  /* get favorite restaurant from db */
  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorite);
    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  /* get favorite restaurant based on ID restaurant from db */
  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  /* get remove favorite restaurant from db */
  Future<void> removeFavorite(String idRestaurant) async {
    final db = await database;

    await db!.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [idRestaurant],
    );
  }
}
