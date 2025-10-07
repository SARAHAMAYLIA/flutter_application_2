import 'package:flutter/material.dart';
import '../views/login_view.dart';
import '../models/user_model.dart';
import '../views/user_management_view.dart';
import '../views/event_management_view.dart';
import '../views/report_management_view.dart';

class DashboardAdminPage extends StatefulWidget {
  final User user;
  const DashboardAdminPage({super.key, required this.user});

  @override
  State<DashboardAdminPage> createState() => _DashboardAdminPageState();
}

class _DashboardAdminPageState extends State<DashboardAdminPage> {
  int selectedIndex = 0;
  String searchQuery = "";

  // Dummy Data
  List<Map<String, dynamic>> users = List.generate(
    10,
    (index) => {
      "id": "USER00${index + 1}",
      "name": "User ${index + 1}",
      "email": "user${index + 1}@email.com",
      "role": index.isEven ? "Admin" : "Mahasiswa",
    },
  );

  List<Map<String, dynamic>> events = List.generate(
    5,
    (index) => {
      "id": "EVENT00${index + 1}",
      "name": "Workshop Flutter ${index + 1}",
      "date": "2025-09-${25 + index}",
      "status": index.isEven ? "Aktif" : "Selesai",
    },
  );

  List<Map<String, dynamic>> reports = List.generate(
    3,
    (index) => {
      "id": "LAPORAN00${index + 1}",
      "title": "Laporan Penggunaan ${index + 1}",
      "date": "2025-09-2${5 + index}",
      "type": index == 0 ? "Harian" : "Mingguan",
    },
  );

  // Menu
  final List<Map<String, dynamic>> menuItems = [
    {"title": "Dashboard", "icon": Icons.home_rounded},
    {"title": "Kelola User", "icon": Icons.people_rounded},
    {"title": "Kelola Event", "icon": Icons.event_rounded},
    {"title": "Laporan", "icon": Icons.analytics_rounded},
    {"title": "Pengaturan", "icon": Icons.settings_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              _buildSidebar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 24),
                      Expanded(child: _buildContent()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- Sidebar ----------------
  Widget _buildSidebar() {
    return Container(
      width: 250,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF5D7AFF), Color(0xFF335DFF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            "Admin Panel",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final isSelected = selectedIndex == index;
                return ListTile(
                  leading: Icon(menuItems[index]["icon"], color: Colors.white),
                  title: Text(
                    menuItems[index]["title"],
                    style: const TextStyle(color: Colors.white),
                  ),
                  tileColor: isSelected ? Colors.white24 : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      searchQuery = "";
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF335DFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginView()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout, size: 20),
              label: const Text(
                "Logout",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Header ----------------
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Halo admin 👋",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        if (selectedIndex != 0 && selectedIndex != 4)
          SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari data...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
      ],
    );
  }

  // ---------------- Content ----------------
  Widget _buildContent() {
    switch (selectedIndex) {
      case 0:
        return GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 1.5,
          children: [
            _buildInfoCard(
              "Total User",
              "120",
              "Pengguna aktif",
              Icons.person_outline,
              const Color(0xFF5D7AFF),
              onTap: () {
                setState(() {
                  selectedIndex = 1; // Pindah ke menu "Kelola User"
                });
              },
            ),
            _buildInfoCard(
              "Total Event",
              "15",
              "Acara yang sedang berlangsung",
              Icons.event_outlined,
              const Color(0xFFEE6A88),
              onTap: () {
                setState(() {
                  selectedIndex = 2; // Pindah ke menu "Kelola Event"
                });
              },
            ),
            _buildInfoCard(
              "Laporan",
              "8",
              "Laporan baru",
              Icons.analytics_outlined,
              const Color(0xFF996BFF),
              onTap: () {
                setState(() {
                  selectedIndex = 3; // Pindah ke menu "Laporan"
                });
              },
            ),
          ],
        );
      case 1:
        return UserManagementView(users: users, searchQuery: searchQuery);
      case 2:
        return EventManagementView(events: events, searchQuery: searchQuery);
      case 3:
        return ReportManagementView(reports: reports, searchQuery: searchQuery);

      case 4:
        return const Center(
          child: Text("Halaman Pengaturan - Konten sedang dikembangkan."),
        );
      default:
        return const Center(
          child: Text("Halaman Tidak Ditemukan"),
        );
    }
  }

  // ---------------- Card ----------------
  Widget _buildInfoCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: color.withOpacity(0.1),
                  child: Icon(icon, color: color, size: 30),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- Tables ----------------
  Widget _buildUserManagementTable() {
    final filtered = users
        .where((u) =>
            u["name"].toLowerCase().contains(searchQuery) ||
            u["email"].toLowerCase().contains(searchQuery))
        .toList();

    return _buildTable("Kelola User", [
      "ID User",
      "Nama",
      "Email",
      "Peran",
      "Aksi"
    ], filtered.map((u) {
      return DataRow(cells: [
        DataCell(Text(u["id"])),
        DataCell(Text(u["name"])),
        DataCell(Text(u["email"])),
        DataCell(Text(u["role"])),
        DataCell(
          Row(children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {},
            ),
          ]),
        ),
      ]);
    }).toList());
  }

  Widget _buildEventManagementTable() {
    final filtered = events
        .where((e) =>
            e["name"].toLowerCase().contains(searchQuery) ||
            e["status"].toLowerCase().contains(searchQuery))
        .toList();

    return _buildTable("Kelola Event", [
      "ID Event",
      "Nama Event",
      "Tanggal",
      "Status",
      "Aksi"
    ], filtered.map((e) {
      return DataRow(cells: [
        DataCell(Text(e["id"])),
        DataCell(Text(e["name"])),
        DataCell(Text(e["date"])),
        DataCell(Text(e["status"])),
        DataCell(
          Row(children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {},
            ),
          ]),
        ),
      ]);
    }).toList());
  }

  Widget _buildReportTable() {
    final filtered = reports
        .where((r) =>
            r["title"].toLowerCase().contains(searchQuery) ||
            r["type"].toLowerCase().contains(searchQuery))
        .toList();

    return _buildTable("Laporan", [
      "ID Laporan",
      "Judul",
      "Tanggal",
      "Tipe",
      "Aksi"
    ], filtered.map((r) {
      return DataRow(cells: [
        DataCell(Text(r["id"])),
        DataCell(Text(r["title"])),
        DataCell(Text(r["date"])),
        DataCell(Text(r["type"])),
        DataCell(
          Row(children: [
            IconButton(
              icon: const Icon(Icons.download, color: Colors.green),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.visibility, color: Colors.blue),
              onPressed: () {},
            ),
          ]),
        ),
      ]);
    }).toList());
  }

  Widget _buildTable(String title, List<String> columns, List<DataRow> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                (_) => const Color(0xFFF4F6FA),
              ),
              columns: columns.map((c) => DataColumn(label: Text(c))).toList(),
              rows: rows,
            ),
          ),
        ),
      ],
    );
  }
}
