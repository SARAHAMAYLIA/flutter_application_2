import 'dart:ui'; // penting buat ImageFilter
import 'package:flutter/material.dart';
import 'login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    // Animasi bounce untuk logo
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _bounceAnimation =
        Tween<double>(begin: 0.9, end: 1.1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    ));

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginView()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.8,
                colors: [
                  Color.fromARGB(255, 158, 217, 221), // pinggir
                  Color.fromARGB(255, 71, 110, 128),  // tengah
                ],
              ),
            ),
          ),

          // Blur efek
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Colors.black.withOpacity(0), // transparan biar blur keliatan
            ),
          ),

          // Konten di tengah
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo dengan efek bounce
                ScaleTransition(
                  scale: _bounceAnimation,
                  child: Image.asset(
                    "assets/images/logo1.png",
                    height: 300,
                  ),
                ),
                const SizedBox(height: 20),

                // Teks dengan font menarik + shadow
                Text(
                  "By Sarah Amaylia",
                  style: TextStyle(
                    fontFamily: 'Poppins', // bisa ganti ke font lain
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        offset: const Offset(2, 2),
                        blurRadius: 6,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      Shadow(
                        offset: const Offset(-2, -2),
                        blurRadius: 6,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
