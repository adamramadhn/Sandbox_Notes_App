class UserModel {
  final String id;
  final String email;
  final String name;
  final String password;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['password'] = password;
    return data;
  }
}
