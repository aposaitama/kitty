import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:kitty/database/hive/hive_repository.dart';
import 'package:kitty/database/hive/hive_service.dart';
import 'package:kitty/models/user/user.dart';
import 'package:kitty/pages/auth_pages/biometrics/biometrics_auth_services.dart';

enum AuthState {
  initial,
  authenticated,
  unauthenticated,
  error,
  passwordRequired,
  profileUpdated,
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(AuthState.initial);

  final Box<UserModel> _userBox = Hive.box<UserModel>(HiveService.usersBoxName);
  final BiometricAuthService _biometricAuthService = BiometricAuthService();

  void register(String login, String password, String confirmPassword,
      String email) async {
    if (password != confirmPassword) {
      emit(AuthState.error);
      return;
    }

    final userExists = _userBox.values.any((user) => user.login == login);

    if (userExists) {
      emit(AuthState.error);
    } else {
      _userBox.add(
        UserModel(login: login, password: password, email: email),
      );
      final authBox = Hive.box('auth');
      authBox.put('isLoggedIn', true);
      authBox.put('userLogin', login);
      emit(AuthState.authenticated);
    }
  }

  void deleteUser() {
    final authBox = Hive.box('auth');
    final userLogin = authBox.get('userLogin');

    final userKey = _userBox.keys.firstWhere(
      (key) => _userBox.get(key)?.login == userLogin,
      orElse: () => null,
    );

    if (userKey != null) {
      _userBox.delete(userKey);
      authBox.delete('isLoggedIn');
      authBox.delete('userLogin');
      emit(AuthState.unauthenticated);
    }

    print(userKey);
  }

  UserModel? getCurrentUser() {
    final authBox = Hive.box('auth');
    final userLogin = authBox.get('userLogin');

    if (userLogin != null) {
      final user = _userBox.values.firstWhere(
        (user) => user.login == userLogin,
      );
      return user;
    }

    return null;
  }

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

  void logout() {
    final authBox = Hive.box('auth');

    authBox.delete('isLoggedIn');
    authBox.delete('userLogin');
    emit(AuthState.unauthenticated);
  }

  void biometricAuth() async {
    bool isAuthenticated = await _biometricAuthService.authenticate();

    if (isAuthenticated) {
      final authBox = Hive.box('auth');
      final userLogin = authBox.get('userLogin');

      if (userLogin != null) {
        final user = getCurrentUser();
        if (user != null) {
          emit(AuthState.authenticated);
        } else {
          emit(AuthState.unauthenticated);
        }
      } else {
        emit(AuthState.unauthenticated);
      }
    } else {
      emit(AuthState.unauthenticated);
    }
  }

  void checkAuthStatus() async {
    final authBox = Hive.box('auth');
    final isLoggedIn = authBox.get('isLoggedIn', defaultValue: false);

    if (isLoggedIn) {
      emit(AuthState.passwordRequired);
    } else {
      emit(AuthState.unauthenticated);
    }
  }

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
    final userKey = _userBox.keys.firstWhere(
      (key) => _userBox.get(key)?.login == user.login,
      orElse: () => null,
    );

    if (userKey != null) {
      _userBox.put(userKey, user);
    }
    emit(AuthState.profileUpdated);
  }
}
