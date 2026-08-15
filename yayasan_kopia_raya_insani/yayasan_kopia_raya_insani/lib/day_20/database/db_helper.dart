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

  // Update User Profile
  Future<bool> updateUserProfile({
    required String oldEmail,
    required String fullName,
    required String newEmail,
    required String phone,
  }) async {
    final db = await instance.database;
    final normalizedOldEmail = oldEmail.trim().toLowerCase();
    final normalizedNewEmail = newEmail.trim().toLowerCase();

    // Check if changing email and new email already belongs to another user
    if (normalizedOldEmail != normalizedNewEmail) {
      final existingUser = await getUserByEmail(normalizedNewEmail);
      if (existingUser != null) {
        return false; // Email already in use by another user
      }
    }

    final count = await db.update(
      'users',
      {
        'fullName': fullName,
        'email': normalizedNewEmail,
        'phone': phone.trim(),
      },
      where: 'LOWER(email) = ?',
      whereArgs: [normalizedOldEmail],
    );

    return count > 0;
  }

  // Update User Password
  Future<bool> updateUserPassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    final db = await instance.database;
    final normalizedEmail = email.trim().toLowerCase();

    // Verify old password
    final user = await loginUser(normalizedEmail, oldPassword);
    if (user == null) {
      return false; // Invalid old password
    }

    final count = await db.update(
      'users',
      {'password': newPassword},
      where: 'LOWER(email) = ?',
      whereArgs: [normalizedEmail],
    );

    return count > 0;
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
