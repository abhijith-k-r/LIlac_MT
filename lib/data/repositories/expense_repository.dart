import 'package:lilac_mt/data/models/expense_model.dart';
import 'package:sqflite/sqflite.dart';

import '../database/app_database.dart';

class ExpenseRepository {
  ExpenseRepository({AppDatabase? appDatabase})
    : _appDatabase = appDatabase ?? AppDatabase.instance;

  final AppDatabase _appDatabase;

  Future<List<ExpenseModel>> getExpenses() async {
    final db = await _appDatabase.database;

    final rows = await db.query('expenses', orderBy: 'date DESC, id DESC');

    return rows.map(ExpenseModel.fromMap).toList();
  }

  Future<int> addExpense(ExpenseModel expense) async {
    _validate(expense);

    final db = await _appDatabase.database;
    final values = expense.toMap()..remove('id');

    return db.insert(
      'expenses',
      values,
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<int> updateExpense(ExpenseModel expense) async {
    _validate(expense);

    if (expense.id == null) {
      throw ArgumentError('Expense ID is required for updating.');
    }

    final db = await _appDatabase.database;
    final values = expense.toMap()..remove('id');

    return db.update(
      'expenses',
      values,
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<int> deleteExpense(int id) async {
    final db = await _appDatabase.database;

    return db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }

  Future<double> getTotalExpenses() async {
    final db = await _appDatabase.database;

    final result = await db.rawQuery(
      'SELECT COALESCE(SUM(amount), 0) AS total FROM expenses',
    );

    return (result.first['total'] as num).toDouble();
  }

  void _validate(ExpenseModel expense) {
    if (expense.title.trim().isEmpty) {
      throw ArgumentError('Expense title is required.');
    }

    if (!expense.amount.isFinite || expense.amount <= 0) {
      throw ArgumentError('Amount must be greater than zero.');
    }

    if (expense.category.trim().isEmpty) {
      throw ArgumentError('Expense category is required.');
    }
  }
}
