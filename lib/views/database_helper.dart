import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String dbPath = path.join(databasesPath, 'mywellbeing.db');
    return await openDatabase(dbPath, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE ProfileImage(id INTEGER PRIMARY KEY, imagePath TEXT)');
  }

  Future<int> saveImage(String imagePath) async {
    Database db = await database;
    return await db.insert('ProfileImage', {'imagePath': imagePath});
  }

  Future<String?> getImagePath() async {
    Database db = await database;
    List<Map> list = await db.query('ProfileImage', orderBy: 'id DESC', limit: 1);
    if (list.isNotEmpty) {
      return list.first['imagePath'] as String?;
    }
    return null;
  }
}
