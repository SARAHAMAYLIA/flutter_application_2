import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        backgroundColor: const Color.fromARGB(255, 237, 88, 230),
      ),
      body: const Center(
        child: Text(
          "Selamat datang di Home Screen 🎉",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
