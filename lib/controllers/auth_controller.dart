import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../utils/prefs_helper.dart';
import '../views/dashboard/dashboard_admin_page.dart';
import '../views/dashboard_user_page.dart';

class AuthController {
  // Dummy data untuk contoh login
  final List<User> _users = [
    User(email: "admin", password: "admin123", role: "admin"),
    User(email: "user", password: "user123", role: "user"),
  ];

  // Jadikan Future agar bisa di-await
  Future<void> login(BuildContext context, String email, String password) async {
    try {
      final user = _users.firstWhere(
        (u) => u.email == email && u.password == password,
      );

      // ✅ Simpan email ke SharedPreferences
      await PrefsHelper.saveUser(email);

      // Arahkan sesuai role
      if (user.role == "admin") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DashboardAdminPage(user: user)),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DashboardUserPage(user: user)),
        );
      }
    } catch (e) {
      // kalau email/password salah
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email atau password salah")),
      );
    }
  }
}
