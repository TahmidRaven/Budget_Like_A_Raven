import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'income.dart';
import 'expense.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('budget.db');
    return _database!;
  }

  // Open the database
  Future<Database> _initDB(String path) async {
    final dbPath = await getDatabasesPath();
    final dbLocation = join(dbPath, path);
    return await openDatabase(dbLocation, version: 1, onCreate: _onCreate);
  }

  // Create tables
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE income(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      amount REAL
    )
    ''');

    await db.execute('''
    CREATE TABLE expense(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      amount REAL
    )
    ''');
  }

  // Insert income
  Future<void> insertIncome(Income income) async {
    final db = await database;
    await db.insert('income', income.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Insert expense
  Future<void> insertExpense(Expense expense) async {
    final db = await database;
    await db.insert('expense', expense.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get all incomes
  Future<List<Income>> getIncomes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('income');
    return List.generate(maps.length, (i) {
      return Income(
        id: maps[i]['id'],
        name: maps[i]['name'],
        amount: maps[i]['amount'],
      );
    });
  }

  // Get all expenses
  Future<List<Expense>> getExpenses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('expense');
    return List.generate(maps.length, (i) {
      return Expense(
        id: maps[i]['id'],
        name: maps[i]['name'],
        amount: maps[i]['amount'],
      );
    });
  }

  // Clear all income data
  Future<void> clearAllIncome() async {
    final db = await database;
    await db.delete('income');
  }

  // Clear all expense data
  Future<void> clearAllExpense() async {
    final db = await database;
    await db.delete('expense');
  }

  // Clear all data
  Future<void> clearAllData() async {
    await clearAllIncome();
    await clearAllExpense();
  }
}
