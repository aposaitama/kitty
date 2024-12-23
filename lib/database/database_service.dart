import 'package:kitty/database/database_config.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();
  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "kitty.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE ${DatabaseConfig.expenseTable} (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT NOT NULL,
    category TEXT NOT NULL,
    categoryIcon TEXT NOT NULL,
    categoryId INTEGER NOT NULL,
    background_color int NOT NULL,
    description TEXT,
    amount TEXT NOT NULL,
    date TEXT NOT NULL
      )
      ''');
        await db.execute('''
      CREATE TABLE ${DatabaseConfig.categoryTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_index INTEGER,
        name TEXT NOT NULL,
        icon TEXT NOT NULL,
        background_color int NOT NULL
      )
      ''');

        await db.execute('''
      CREATE TABLE ${DatabaseConfig.categoryIconsTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        iconPath TEXT NOT NULL,
        background_color int NOT NULL
      )
      ''');
        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Groceries.svg",
          "background_color": 0xFFC8E6C9
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Cafe.svg",
          "background_color": 0xFFFFECB3
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Electronics.svg",
          "background_color": 0xFFFFCDD2
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Gifts.svg",
          "background_color": 0xFFE1BEE7
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Health.svg",
          "background_color": 0xFFF8BBD0
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Transportation.svg",
          "background_color": 0xFFB2EBF2
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Laundry.svg",
          "background_color": 0xFFB3E5FC
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Party.svg",
          "background_color": 0xFFBBDEFB
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Liquor.svg",
          "background_color": 0xFFDCEDC8
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Fuel.svg",
          "background_color": 0xFFD7CCC8
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Restaurant.svg",
          "background_color": 0xFFE6EE9C
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Sport.svg",
          "background_color": 0xFFB39DDB
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Maintenance.svg",
          "background_color": 0xFFF0F4C3
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Education.svg",
          "background_color": 0xFFCFD8DC
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Self development.svg",
          "background_color": 0xFFFFCCBC
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Money.svg",
          "background_color": 0xFFFFE0B2
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Institute.svg",
          "background_color": 0xFFFFF9C4
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Donate.svg",
          "background_color": 0xFFFFECB3
        });

        await db.insert(DatabaseConfig.categoryIconsTable, {
          "iconPath": "assets/icons/category_icons/Savings.svg",
          "background_color": 0xFFFFECB3
        });
      },
    );
    return database;
  }
}
