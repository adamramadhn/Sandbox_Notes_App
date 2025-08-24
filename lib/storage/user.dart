import 'package:hive/hive.dart';

part 'user.g.dart'; // Ini akan dibuat secara otomatis

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String password;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });
}
