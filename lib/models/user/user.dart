import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String login;

  @HiveField(1)
  final String password;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? icon;

  UserModel(
      {required this.login, required this.password, this.email, this.icon});
}
