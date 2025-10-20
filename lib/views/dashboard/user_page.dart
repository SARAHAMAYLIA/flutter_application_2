import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../widgets/navbar_user.dart';

class DashboardUserPage extends StatefulWidget {
  final User user;
  const DashboardUserPage({super.key, required this.user});

  @override
  State<DashboardUserPage> createState() => _DashboardUserPageState();
}

class _DashboardUserPageState extends State<DashboardUserPage> {
  String _selectedCategory = "Semua Kategori";
  String _selectedLocation = "Semua Lokasi";
  String _selectedType = "Semua";
  String _searchQuery = "";

  final List<String> _categories = [
    "Semua Kategori",
    "Teknologi",
    "Seni & Budaya",
    "Olahraga",
    "Akademik",
    "Bisnis",
  ];

  final List<String> _locations = [
    "Semua Lokasi",
    "Surabaya",
    "Jakarta",
    "Bandung",
    "Yogyakarta",
    "Online",
  ];

  final List<Map<String, dynamic>> _events = [
    {
      "id": 1,
      "title": "Seminar AI & Machine Learning 2025",
      "category": "Teknologi",
      "date": "20 Sept 2025",
      "location": "Surabaya",
      "type": "Gratis",
      "isOnline": false,
      "registered": false,
      "imagePath": "assets/images/event1.png",
      "organizer": "UNESA Tech Community",
      "quota": "50 peserta",
    },
    {
      "id": 2,
      "title": "Workshop UI/UX Design Thinking",
      "category": "Teknologi",
      "date": "25 Sept 2025",
      "location": "Online",
      "type": "Berbayar",
      "isOnline": true,
      "registered": false,
      "imagePath": "assets/images/event2.png",
      "organizer": "Design Club UNESA",
      "quota": "100 peserta",
    },
    {
      "id": 3,
      "title": "Lomba Startup Digital Competition",
      "category": "Bisnis",
      "date": "30 Sept 2025",
      "location": "Jakarta",
      "type": "Berbayar",
      "isOnline": false,
      "registered": false,
      "imagePath": "assets/images/event3.png",
      "organizer": "Indonesia Startup Hub",
      "quota": "30 tim",
    },
    {
      "id": 4,
      "title": "Festival Seni Kampus 2025",
      "category": "Seni & Budaya",
      "date": "5 Okt 2025",
      "location": "Surabaya",
      "type": "Gratis",
      "isOnline": false,
      "registered": false,
      "imagePath": "assets/images/event4.png",
      "organizer": "Kesenian UNESA",
      "quota": "Unlimited",
    },
    {
      "id": 5,
      "title": "Turnamen Futsal Antar Fakultas",
      "category": "Olahraga",
      "date": "10 Okt 2025",
      "location": "Surabaya",
      "type": "Gratis",
      "isOnline": false,
      "registered": false,
      "imagePath": "assets/images/event5.png",
      "organizer": "BEM UNESA",
      "quota": "16 tim",
    },
  ];

  List<Map<String, dynamic>> get filteredEvents {
    return _events.where((event) {
      bool matchCategory = _selectedCategory == "Semua Kategori" ||
          event["category"] == _selectedCategory;
      bool matchLocation = _selectedLocation == "Semua Lokasi" ||
          event["location"] == _selectedLocation;
      bool matchType = _selectedType == "Semua" ||
          (_selectedType == "Gratis" && event["type"] == "Gratis") ||
          (_selectedType == "Berbayar" && event["type"] == "Berbayar") ||
          (_selectedType == "Online" && event["isOnline"] == true);
      bool matchSearch = _searchQuery.isEmpty ||
          event["title"]
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());

      return matchCategory && matchLocation && matchType && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 600 && screenWidth <= 1024;
    final horizontalPadding = isDesktop ? 60.0 : (isTablet ? 40.0 : 20.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _buildHeroSection()),
          SliverToBoxAdapter(child: _buildFilterChips()),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 30,
            ),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent:
                    isDesktop ? 350 : (isTablet ? 300 : double.infinity),
                mainAxisSpacing: isDesktop ? 20 : 16,
                crossAxisSpacing: isDesktop ? 20 : 16,
                childAspectRatio: isDesktop ? 0.75 : (isTablet ? 0.75 : 1.1),
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildEventCard(filteredEvents[index]);
                },
                childCount: filteredEvents.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF5E35B1), Color(0xFF9575CD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Text(
          'Event Kampus Hub',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ["Semua", "Gratis", "Berbayar", "Online"];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 10,
        children: filters.map((filter) {
          bool selected = _selectedType == filter;
          return ChoiceChip(
            label: Text(filter),
            selected: selected,
            selectedColor: Colors.purple,
            labelStyle: TextStyle(
              color: selected ? Colors.white : Colors.black,
            ),
            onSelected: (value) {
              setState(() {
                _selectedType = filter;
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              event['imagePath'],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          ListTile(
            title: Text(event['title']),
            subtitle: Text("${event['date']} • ${event['location']}"),
          ),
        ],
      ),
    );
  }
}
