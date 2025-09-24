class User {
  final String email;
  final String password;
  final String role; // "user" atau "admin"

  User({
    required this.email,
    required this.password,
    required this.role,
  });
}
