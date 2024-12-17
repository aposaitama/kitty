import 'package:kitty/database/database_config.dart';
import 'package:kitty/database/database_service.dart';
import 'package:kitty/models/categories/categories.dart';
import 'package:kitty/models/expense/expense.dart';

class ExpensesRepository {
  final db = DatabaseService.instance;

  Future<void> addExpense(Expense expense) async {
    final database = await db.database;

    await database.insert(DatabaseConfig.expenseTable, {
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

    await database.insert(DatabaseConfig.categoryTable, {
      'name': category.name,
      'icon': category.iconPath,
    });
  }

  Future<List<Categories>> getAllCategories() async {
    final database = await db.database;
    final List<Map<String, dynamic>> maps = await database.query('Categories');

    return List.generate(maps.length, (i) {
      return Categories.fromJson(
          // name: maps[i]['name'],
          // iconPath: maps[i]['icon'],
          maps[i]);
    });
  }

  Future<List<Expense>> getAllExpenses() async {
    final database = await db.database;
    final List<Map<String, dynamic>> maps = await database.query('Expense');

    return List.generate(maps.length, (i) {
      return Expense.fromJson(maps[i]);
    });
  }
}
