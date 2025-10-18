import 'package:flutter/material.dart';
import 'models/user_model.dart';
import 'views/splash_view.dart';
import 'views/dashboard/user_page.dart';
import 'views/dashboard/tips_user.dart';
import 'views/dashboard/bookmark_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EventKampus',
      theme: ThemeData(primarySwatch: Colors.purple),

      // Halaman pertama saat aplikasi dijalankan
      home: const SplashView(),

      // Daftar rute navigasi
      routes: {
        '/dashboard-user': (context) {
          final user = ModalRoute.of(context)!.settings.arguments as User;
          return UserPage(user: user);
        },
        '/tips-user': (context) {
          final user = ModalRoute.of(context)!.settings.arguments as User;
          return TipsUserPage(user: user);
        },
        '/bookmark-user': (context) {
          final user = ModalRoute.of(context)!.settings.arguments as User;
          // ✅ Tambahkan parameter bookmarkedEvents biar tidak error
          return BookmarkUserPage(
            user: user,
            bookmarkedEvents: const [],
          );
        },
      },
    );
  }
}
