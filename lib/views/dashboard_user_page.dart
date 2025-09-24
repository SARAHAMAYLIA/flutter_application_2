import 'package:flutter/material.dart';
import '../views/login_view.dart';
import '../views/event_kampus_page.dart'; // ⬅️ Import Event Kampus
import '../models/user_model.dart';

class DashboardUserPage extends StatelessWidget {
  final User user;
  const DashboardUserPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 👉 AppBar dihilangkan, diganti Sidebar + Layout modern
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 220,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo1.png", // path logo kamu
                  width: 160,
                  height: 160,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 30),
                menuItem(Icons.dashboard, "Dashboard"),
                menuItem(Icons.event, "Event Kampus", onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EventKampusPage()),
                  );
                }),
                menuItem(Icons.bookmark, "Event Saya"),
                menuItem(Icons.person, "Profil"),
                menuItem(Icons.logout, "Logout", onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginView()),
                    (route) => false,
                  );
                }),
              ],
            ),
          ),

          // Content Area
          Expanded(
            child: Container(
              color: const Color(0xFFF5F6FA),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Halo ${user.email}, kamu login sebagai USER",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const CircleAvatar(
                        backgroundColor: Colors.purple,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Section: Upcoming Event
                  const Text(
                    "Upcoming Event",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: eventCard(
                          title: "Seminar AI",
                          date: "20 Sept 2025",
                          icon: Icons.computer,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: eventCard(
                          title: "Workshop UI/UX",
                          date: "25 Sept 2025",
                          icon: Icons.design_services,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Section: List Event
                  const Text(
                    "Daftar Event",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Expanded(
                    child: ListView(
                      children: [
                        listEventTile("Seminar AI", "20 Sept 2025"),
                        listEventTile("Workshop UI/UX", "25 Sept 2025"),
                        listEventTile("Lomba Startup Digital", "30 Sept 2025"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Sidebar Menu Item
  Widget menuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap ?? () {},
    );
  }

  // 🔹 Event Card
  static Widget eventCard({
    required String title,
    required String date,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              Text(date, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  // 🔹 List Event Tile
  static Widget listEventTile(String title, String date) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.event),
        title: Text(title),
        subtitle: Text(date),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            "Daftar",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
