class UserModel {
  final String? name;
  final String email;
  final String password;

  UserModel({
    this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Email": email,
      "Password": password,
    };
  }
}
