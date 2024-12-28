import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:kitty/models/user/user.dart';
import 'package:kitty/pages/auth_pages/biometrics/biometrics_auth_services.dart';

enum AuthState {
  initial,
  authenticated,
  unauthenticated,
  error,
  passwordRequired
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial);

  final Box<UserModel> _userBox = Hive.box<UserModel>('users');
  final BiometricAuthService _biometricAuthService = BiometricAuthService();

  // Метод для реєстрації
  void register(String login, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      emit(AuthState.error);
      return;
    }

    final userExists = _userBox.values.any((user) => user.login == login);

    if (userExists) {
      emit(AuthState.error);
    } else {
      _userBox.add(UserModel(login: login, password: password));
      final authBox = Hive.box('auth');
      authBox.put('isLoggedIn', true);
      authBox.put('userLogin', login);
      emit(AuthState.authenticated);
    }
  }

  UserModel? getCurrentUser() {
    final authBox = Hive.box('auth');
    final userLogin = authBox.get('userLogin'); // Отримуємо логін користувача

    if (userLogin != null) {
      // Шукаємо користувача в боксі users за логіном
      final user = _userBox.values.firstWhere(
        (user) => user.login == userLogin,
      );
      return user;
    }

    return null; // Якщо userLogin відсутній, повертаємо null
  }

  // Метод для логіну через пароль
  void login(String login, String password) async {
    try {
      final user = _userBox.values.firstWhere(
        (user) => user.login == login && user.password == password,
      );
      final authBox = Hive.box('auth');
      authBox.put('isLoggedIn', true);
      authBox.put('userLogin', user.login);
      emit(AuthState.authenticated);
    } catch (e) {
      emit(AuthState.unauthenticated);
    }
  }

  // Метод для виходу
  void logout() {
    final authBox = Hive.box('auth');
    authBox.delete('isLoggedIn');
    authBox.delete('userLogin');
    emit(AuthState.unauthenticated);
  }

  void biometricAuth() async {
    bool isAuthenticated = await _biometricAuthService.authenticate();
    print('Biometric authentication result: $isAuthenticated');
    if (isAuthenticated) {
      emit(AuthState.authenticated);
    }
  }

  // Метод для перевірки стану автентифікації
  void checkAuthStatus() async {
    final authBox = Hive.box('auth');
    final isLoggedIn = authBox.get('isLoggedIn', defaultValue: false);

    print('Is logged in: $isLoggedIn'); // Додаємо лог для перевірки

    if (isLoggedIn) {
      emit(AuthState.passwordRequired);
      print('State changed to Authenticated');
    } else {
      emit(AuthState.unauthenticated);
      print('State changed to Unauthenticated');
    }
  }

  // Метод для підтвердження пароля
  void submitPassword(String login, String password) {
    try {
      final user = _userBox.values.firstWhere(
        (user) => user.login == login && user.password == password,
      );
      final authBox = Hive.box('auth');
      authBox.put('isLoggedIn', true);
      authBox.put('userLogin', user.login);
      emit(AuthState.authenticated);
    } catch (e) {
      emit(AuthState.unauthenticated);
    }
  }

  void updateUser(UserModel user) {
    _userBox.put(user.login, user);
    print(
        'User updated: ${user.login}'); // Лог для підтвердження оновлення користувача
    print('Updated user icon: ${user.icon}'); // Лог для перевірки шляху іконки
  }
}
