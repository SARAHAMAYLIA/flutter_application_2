import 'package:flutter/material.dart';
import '../views/login_view.dart';
import '../models/user_model.dart';

class DashboardAdminPage extends StatefulWidget {
  final User user;
  const DashboardAdminPage({super.key, required this.user});

  @override
  State<DashboardAdminPage> createState() => _DashboardAdminPageState();
}

class _DashboardAdminPageState extends State<DashboardAdminPage> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> menuItems = [
    {
      "title": "Dashboard",
      "icon": Icons.home_rounded,
      "description": "Ikhtisar statistik dan data utama"
    },
    {
      "title": "Kelola User",
      "icon": Icons.people_rounded,
      "description": "Manajemen data dan peran pengguna"
    },
    {
      "title": "Kelola Event",
      "icon": Icons.event_rounded,
      "description": "Manajemen acara dan jadwal"
    },
    {
      "title": "Laporan",
      "icon": Icons.analytics_rounded,
      "description": "Analisis data dan laporan kinerja"
    },
    {
      "title": "Pengaturan",
      "icon": Icons.settings_rounded,
      "description": "Konfigurasi aplikasi dan sistem"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Mengubah warna latar belakang utama
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
              // Sidebar
              Container(
                width: 250,
                decoration: BoxDecoration(
                  // Mengubah warna gradien untuk sidebar
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5D7AFF), Color(0xFF335DFF)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(24.0),
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

                    // Menu List
                    Expanded(
                      child: ListView.builder(
                        itemCount: menuItems.length,
                        itemBuilder: (context, index) {
                          final isSelected = selectedIndex == index;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                // Mengubah warna item menu yang dipilih
                                color: isSelected
                                    ? Colors.white.withOpacity(0.2)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading: Icon(
                                  menuItems[index]["icon"],
                                  color: Colors.white,
                                ),
                                title: Text(
                                  menuItems[index]["title"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  menuItems[index]["description"],
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Tombol Logout
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
                            MaterialPageRoute(
                                builder: (_) => const LoginView()),
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
              ),

              // Main Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      _buildHeader(),
                      const SizedBox(height: 24),

                      // Dashboard Content
                      Expanded(
                        child: _buildContent(),
                      ),
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

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Halo admin, 👋",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Selamat datang kembali di dashboard!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none,
                  color: Color(0xFF5D7AFF), size: 30),
            ),
            const SizedBox(width: 16),
            const CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),
          ],
        ),
      ],
    );
  }

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
            ),
            _buildInfoCard(
              "Total Event",
              "15",
              "Acara yang sedang berlangsung",
              Icons.event_outlined,
              const Color(0xFFEE6A88),
            ),
            _buildInfoCard(
              "Laporan",
              "8",
              "Laporan baru",
              Icons.analytics_outlined,
              const Color(0xFF996BFF),
            ),
          ],
        );
      case 1:
        return _buildUserManagementTable();
      case 2:
        return _buildEventManagementTable();
      case 3:
        return _buildReportTable();
      case 4:
        return const Center(
            child: Text("Halaman Pengaturan - Konten sedang dikembangkan."));
      default:
        return const Center(child: Text("Halaman Tidak Ditemukan"));
    }
  }

  Widget _buildInfoCard(
      String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
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
    );
  }

  Widget _buildUserManagementTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Kelola User",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => const Color(0xFFF4F6FA)),
              columns: const [
                DataColumn(label: Text('ID User')),
                DataColumn(label: Text('Nama')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Peran')),
                DataColumn(label: Text('Aksi')),
              ],
              rows: List.generate(
                10,
                (index) => DataRow(cells: [
                  DataCell(Text('USER00${index + 1}')),
                  DataCell(Text('User ${index + 1}')),
                  DataCell(Text('user${index + 1}@email.com')),
                  DataCell(Text(index.isEven ? 'Admin' : 'Mahasiswa')),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {},
                      ),
                    ],
                  )),
                ]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEventManagementTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Kelola Event",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => const Color(0xFFF4F6FA)),
              columns: const [
                DataColumn(label: Text('ID Event')),
                DataColumn(label: Text('Nama Event')),
                DataColumn(label: Text('Tanggal')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Aksi')),
              ],
              rows: List.generate(
                5,
                (index) => DataRow(cells: [
                  DataCell(Text('EVENT00${index + 1}')),
                  DataCell(Text('Workshop Flutter ${index + 1}')),
                  DataCell(Text('2025-09-${25 + index}')),
                  DataCell(Text(index.isEven ? 'Aktif' : 'Selesai')),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {},
                      ),
                    ],
                  )),
                ]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReportTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Laporan",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => const Color(0xFFF4F6FA)),
              columns: const [
                DataColumn(label: Text('ID Laporan')),
                DataColumn(label: Text('Judul')),
                DataColumn(label: Text('Tanggal')),
                DataColumn(label: Text('Tipe')),
                DataColumn(label: Text('Aksi')),
              ],
              rows: List.generate(
                3,
                (index) => DataRow(cells: [
                  DataCell(Text('LAPORAN00${index + 1}')),
                  DataCell(Text('Laporan Penggunaan ${index + 1}')),
                  DataCell(Text('2025-09-2${5 + index}')),
                  DataCell(Text(index == 0 ? 'Harian' : 'Mingguan')),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.download, color: Colors.green),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.visibility, color: Colors.blue),
                        onPressed: () {},
                      ),
                    ],
                  )),
                ]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}