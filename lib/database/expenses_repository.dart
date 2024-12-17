import 'package:kitty/database/database_service.dart';
import 'package:kitty/models/categories/categories.dart';
import 'package:kitty/models/expense/expense.dart';

class ExpensesRepository {
  final db = DatabaseService.instance;

  Future<void> addExpense(Expense expense) async {
    final database = await db.database;

    await database.insert('Expense', {
      'type': expense.type,
      'category': expense.category,
      'categoryIcon': expense.categoryIcon,
      'description': expense.description,
      'amount': expense.amount,
      'date': expense.date.toIso8601String(),
    });
  }

  Future<void> addCategory(Categories category) async {
    final database = await db.database;

    await database.insert('Categories', {
      'name': category.name,
      'icon': category.iconPath,
    });
  }

  Future<List<Categories>> getAllCategories() async {
    final database = await db.database;
    final List<Map<String, dynamic>> maps = await database.query('Categories');

    return List.generate(maps.length, (i) {
      return Categories(
        name: maps[i]['name'],
        iconPath: maps[i]['icon'],
      );
    });
  }

  Future<List<Expense>> getAllExpenses() async {
    final database = await db.database;
    final List<Map<String, dynamic>> maps = await database.query('Expense');

    return List.generate(maps.length, (i) {
      return Expense(
        type: maps[i]['type'],
        category: maps[i]['category'],
        categoryIcon: maps[i]['categoryIcon'],
        description: maps[i]['description'],
        amount: maps[i]['amount'],
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }
}
