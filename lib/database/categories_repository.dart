import 'package:kitty/database/database_config.dart';
import 'package:kitty/database/database_service.dart';
import 'package:kitty/models/categories/categories.dart';
import 'package:kitty/models/categories_icon/categoriesicon.dart';

class CategoriesRepository {
  final db = DatabaseService.instance;

  Future<void> addCategory(Categories category) async {
    final database = await db.database;

    await database.insert(DatabaseConfig.categoryTable, {
      'name': category.name,
      'icon': category.iconPath,
      'order_index': category.order_index,
      'background_color': category.backgroundColor
    });
  }

  Future<List<Categories>> getAllCategories() async {
    final database = await db.database;
    final List<Map<String, dynamic>> maps = await database
        .query(DatabaseConfig.categoryTable, orderBy: 'order_index ASC');

    return List.generate(maps.length, (i) {
      return Categories(
          id: maps[i]['id'],
          backgroundColor: maps[i]['background_color'],
          name: maps[i]['name'],
          iconPath: maps[i]['icon'],
          order_index: maps[i]['order_index']);
    });
  }

  Future<List<CategoriesIcon>> getAllCategoriesIcons() async {
    final database = await db.database;
    final List<Map<String, dynamic>> maps = await database.query(
      DatabaseConfig.categoryIconsTable,
    );

    return List.generate(maps.length, (i) {
      return CategoriesIcon(
          backgroundColor: maps[i]['background_color'],
          iconPath: maps[i]['iconPath']);
    });
  }

  Future<int> getNextOrderIndex() async {
    final database = await db.database;
    final result = await database
        .rawQuery('SELECT MAX(order_index) as maxIndex FROM Categories');

    //add +1 no text categ
    if (result.isNotEmpty && result.first['maxIndex'] != null) {
      return (result.first['maxIndex'] as int) + 1;
    } else {
      return 0; //if the table is empty
    }
  }

  Future<void> updateOrder(List<Categories> updatedCategories) async {
    final database = await db.database;

    for (int i = 0; i < updatedCategories.length; i++) {
      final category = updatedCategories[i];
      await database.update(
        DatabaseConfig.categoryTable,
        {'order_index': i},
        where: 'name = ? AND icon = ?',
        whereArgs: [category.name, category.iconPath],
      );
    }
  }
}
