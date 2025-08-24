import 'package:hive/hive.dart';

part 'user_model.g.dart'; // Ini akan dibuat secara otomatis

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String password;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });
}
