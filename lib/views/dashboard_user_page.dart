import 'package:flutter/material.dart';

class DashboardUserPage extends StatefulWidget {
  const DashboardUserPage({super.key});

  @override
  State<DashboardUserPage> createState() => _DashboardUserPageState();
}

class _DashboardUserPageState extends State<DashboardUserPage> {
  int _selectedIndex = 0;

  // Data dummy events - Nanti diganti dengan data dari API/Database
  final List<Map<String, dynamic>> _upcomingEvents = [
    {
      "id": 1,
      "title": "Seminar AI",
      "date": "20 Sept 2025",
      "icon": Icons.computer,
      "color": Color(0xFF7C4DFF),
      "registered": true,
    },
    {
      "id": 2,
      "title": "Workshop UI/UX",
      "date": "25 Sept 2025",
      "icon": Icons.design_services,
      "color": Color(0xFF00B0FF),
      "registered": true,
    },
  ];

  final List<Map<String, dynamic>> _allEvents = [
    {
      "id": 1,
      "title": "Seminar AI",
      "date": "20 Sept 2025",
      "registered": true,
    },
    {
      "id": 2,
      "title": "Workshop UI/UX",
      "date": "25 Sept 2025",
      "registered": true,
    },
    {
      "id": 3,
      "title": "Lomba Startup Digital",
      "date": "30 Sept 2025",
      "registered": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Row(
        children: [
          // Sidebar
          _buildSidebar(),
          
          // Main Content
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(
                  child: _buildMainContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Sidebar dengan gradient
  Widget _buildSidebar() {
    return Container(
      width: 220,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF5E35B1), // Purple
            Color(0xFF3949AB), // Indigo
            Color(0xFF1E88E5), // Blue
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          
          // Logo & Brand
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.celebration,
                    color: Color(0xFF5E35B1),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'eventkampus',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 50),
          
          // Menu Items
          _buildMenuItem(0, Icons.dashboard, 'Dashboard'),
          _buildMenuItem(1, Icons.event, 'Event Kampus'),
          _buildMenuItem(2, Icons.bookmark, 'Event Saya'),
          _buildMenuItem(3, Icons.person, 'Profil'),
          
          const Spacer(),
          
          // Logout Button
          _buildMenuItem(4, Icons.logout, 'Logout'),
          
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildMenuItem(int index, IconData icon, String title) {
    bool isSelected = _selectedIndex == index;
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        
        // Handle navigation
        if (title == 'Logout') {
          _handleLogout();
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Top Bar dengan greeting dan profile
  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Halo user, kamu login sebagai USER',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF212121),
            ),
          ),
          
          // Profile Avatar
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF5E35B1), Color(0xFF1E88E5)],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  // Main Content Area
  Widget _buildMainContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Upcoming Event Section
          const Text(
            'Upcoming Event',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Upcoming Event Cards (Horizontal)
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _upcomingEvents.length,
              itemBuilder: (context, index) {
                return _buildUpcomingEventCard(_upcomingEvents[index]);
              },
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Daftar Event Section
          const Text(
            'Daftar Event',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Event List
          ..._allEvents.map((event) => _buildEventListItem(event)).toList(),
        ],
      ),
    );
  }

  // Upcoming Event Card (Horizontal Card)
  Widget _buildUpcomingEventCard(Map<String, dynamic> event) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon with gradient background
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: event['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              event['icon'],
              color: event['color'],
              size: 30,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Event Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  event['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF212121),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  event['date'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Event List Item
  Widget _buildEventListItem(Map<String, dynamic> event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Calendar Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.calendar_today,
              color: Color(0xFF5E35B1),
              size: 24,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Event Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF212121),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event['date'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          // Button
          ElevatedButton(
            onPressed: event['registered'] 
                ? null 
                : () => _handleRegisterEvent(event),
            style: ElevatedButton.styleFrom(
              backgroundColor: event['registered'] 
                  ? Colors.grey[300] 
                  : const Color(0xFF5E35B1),
              foregroundColor: event['registered'] 
                  ? Colors.grey[600] 
                  : Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: Text(
              event['registered'] ? 'Terdaftar' : 'Daftar',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Handle Event Registration
  void _handleRegisterEvent(Map<String, dynamic> event) {
    setState(() {
      // Update status registered
      event['registered'] = true;
      
      // Tambahkan ke upcoming events jika belum ada
      bool exists = _upcomingEvents.any((e) => e['id'] == event['id']);
      if (!exists) {
        _upcomingEvents.add({
          "id": event['id'],
          "title": event['title'],
          "date": event['date'],
          "icon": Icons.event,
          "color": Color(0xFF00B0FF),
          "registered": true,
        });
      }
    });
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Berhasil mendaftar ${event['title']}'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // Handle Logout
  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin keluar?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to login page
              // Navigator.pushReplacementNamed(context, '/login');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logout berhasil'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5E35B1),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}