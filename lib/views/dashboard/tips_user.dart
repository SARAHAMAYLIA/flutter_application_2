import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../widgets/navbar_user.dart';

class TipsUserPage extends StatelessWidget {
  final User user;
  const TipsUserPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text('Tips & Edukasi Event'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: NavbarUser(
              user: user,
              currentPage: 'tips',
              onLogout: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                Card(
                  child: ListTile(
                    leading: Icon(Icons.lightbulb, color: Colors.purple),
                    title: Text("Tips Mengatur Jadwal Event"),
                    subtitle: Text("Pelajari cara memilih event yang sesuai dengan minat dan waktu kuliah."),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.people, color: Colors.purple),
                    title: Text("Networking di Dunia Kampus"),
                    subtitle: Text("Bangun relasi positif lewat kegiatan kampus."),
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
