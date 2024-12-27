import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String login;

  @HiveField(1)
  final String password;

  UserModel({required this.login, required this.password});
}
