import 'package:hive_flutter/hive_flutter.dart';
import 'package:kitty/models/user/user.dart';

class HiveService {
  static const String usersBoxName = 'users';
  static const String authBoxName = 'auth';

  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox<UserModel>(usersBoxName);
    await Hive.openBox(authBoxName);
  }

  static Box<UserModel> get usersBox => Hive.box<UserModel>(usersBoxName);
  static Box get authBox => Hive.box(authBoxName);

  static Future<void> clearBox(String boxName) async {
    await Hive.box(boxName).clear();
  }

  static Future<void> deleteBox(String boxName) async {
    await Hive.deleteBoxFromDisk(boxName);
  }
}
