import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user_model.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._init();
  static Database? _database;

  DbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('kopia_raya_insani.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        phone TEXT NOT NULL,
        password TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  // Register User
  // Returns: user id if success, -1 if email already exists
  Future<int> registerUser(UserModel user) async {
    final db = await instance.database;

    // Check if email already registered
    final existingUser = await getUserByEmail(user.email);
    if (existingUser != null) {
      return -1; // Duplicate Email
    }

    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Login User
  Future<UserModel?> loginUser(String email, String password) async {
    final db = await instance.database;
    final normalizedEmail = email.trim().toLowerCase();

    final result = await db.query(
      'users',
      where: 'LOWER(email) = ? AND password = ?',
      whereArgs: [normalizedEmail, password],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  // Get User by Email
  Future<UserModel?> getUserByEmail(String email) async {
    final db = await instance.database;
    final normalizedEmail = email.trim().toLowerCase();

    final result = await db.query(
      'users',
      where: 'LOWER(email) = ?',
      whereArgs: [normalizedEmail],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  // Get All Users (Utility)
  Future<List<UserModel>> getAllUsers() async {
    final db = await instance.database;
    final result = await db.query('users', orderBy: 'id DESC');
    return result.map((map) => UserModel.fromMap(map)).toList();
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}
