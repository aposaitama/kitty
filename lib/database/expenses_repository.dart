import 'package:kitty/database/database_config.dart';
import 'package:kitty/database/database_service.dart';
import 'package:kitty/models/categories/categories.dart';
import 'package:kitty/models/expense/expense.dart';

class ExpensesRepository {
  final db = DatabaseService.instance;

  Future<void> addExpense(Expense expense) async {
    final database = await db.database;

    await database.insert('Expense', {
      'background_color': expense.backgroundColor,
      'type': expense.type,
      'category': expense.category,
      'categoryIcon': expense.categoryIcon,
      'categoryId': expense.categoryId,
      'description': expense.description,
      'amount': expense.amount,
      'date': expense.date.toIso8601String(),
    });
  }

  Future<List<Expense>> getAllExpenses() async {
    final database = await db.database;
    final List<Map<String, dynamic>> maps = await database.query('Expense');

    return List.generate(maps.length, (i) {
      return Expense(
        backgroundColor: maps[i]['background_color'],
        type: maps[i]['type'],
        category: maps[i]['category'],
        categoryIcon: maps[i]['categoryIcon'],
        categoryId: maps[i]['categoryId'],
        description: maps[i]['description'],
        amount: maps[i]['amount'],
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }

  Future<List<Expense>> getElemByCategory(List<String> categoryName) async {
    final database = await db.database;
    final List<Map<String, dynamic>> maps = await database.query(
      'Expense',
      where: 'category IN (${categoryName.map((_) => '?').join(', ')})',
      whereArgs: categoryName, // передаємо список як окремі параметри
    );
    return List.generate(maps.length, (i) {
      return Expense(
        type: maps[i]['type'],
        category: maps[i]['category'],
        categoryIcon: maps[i]['categoryIcon'],
        categoryId: maps[i]['categoryId'],
        description: maps[i]['description'],
        amount: maps[i]['amount'],
        date: DateTime.parse(maps[i]['date']),
        backgroundColor: maps[i]['background_color'],
      );
    });
  }

  Future<Categories?> getCategoryInfo(int categoryId) async {
    final database = await db.database;

    final List<Map<String, dynamic>> maps = await database.query(
      DatabaseConfig.categoryTable,
      where: 'id = ?',
      whereArgs: [categoryId],
    );

    if (maps.isNotEmpty) {
      return Categories.fromJson(maps.first);
    }

    return null;
  }

  Map<String, List<Expense>> groupExpensesByDate(List<Expense> expenses) {
    final now = DateTime.now();
    Map<String, List<Expense>> grouped = {};

    for (var expense in expenses) {
      final difference = now.difference(expense.date).inDays;

      String groupKey;

      if (difference == 0) {
        groupKey = "TODAY";
      } else if (difference == 1) {
        groupKey = "YESTERDAY";
      } else {
        groupKey = "$difference days ago";
      }

      if (grouped[groupKey] == null) {
        grouped[groupKey] = [];
      }

      grouped[groupKey]!.add(expense);
    }

    return grouped;
  }
}
