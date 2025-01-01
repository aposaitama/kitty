import 'package:hive/hive.dart';
import 'package:kitty/models/user/user.dart';

class AuthRepository {
  final Box<UserModel> _userBox = Hive.box<UserModel>('users');
  final Box _authBox = Hive.box('auth');

  Future<bool> isUserExists(String login) async {
    return _userBox.values.any((user) => user.login == login);
  }

  Future<void> addUser(UserModel user) async {
    await _userBox.add(user);
  }

  Future<void> setAuthStatus(bool isLoggedIn, String? login) async {
    await _authBox.put('isLoggedIn', isLoggedIn);
    if (login != null) {
      await _authBox.put('userLogin', login);
    }
  }

  UserModel? getUserByLogin(String login) {
    return _userBox.values.firstWhere(
      (user) => user.login == login,
    );
  }

  Future<void> deleteUser(String login) async {
    final userKey = _userBox.keys.firstWhere(
      (key) => _userBox.get(key)?.login == login,
      orElse: () => null,
    );
    if (userKey != null) {
      await _userBox.delete(userKey);
    }
  }

  Future<void> clearAuthStatus() async {
    await _authBox.delete('isLoggedIn');
    await _authBox.delete('userLogin');
  }

  bool isLoggedIn() {
    return _authBox.get('isLoggedIn', defaultValue: false) as bool;
  }

  String? getCurrentUserLogin() {
    return _authBox.get('userLogin');
  }
}
