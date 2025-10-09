import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EventKampusPage extends StatefulWidget {
  const EventKampusPage({super.key});

  @override
  State<EventKampusPage> createState() => _EventKampusPageState();
}

class _EventKampusPageState extends State<EventKampusPage> {
  final List<Map<String, String>> _eventList = [
    {
      "judul": "Seminar AI dan Big Data",
      "deskripsi": "Diskusi tentang perkembangan AI dan penerapan Big Data.",
      "tanggal": "20 September 2025",
      "lokasi": "Aula Kampus A",
      "gambar": "assets/images/ai_seminar.jpg",
    },
    {
      "judul": "Workshop Flutter",
      "deskripsi": "Belajar membuat aplikasi mobile dengan Flutter.",
      "tanggal": "25 September 2025",
      "lokasi": "Lab Informatika",
      "gambar": "assets/images/flutter_workshop.jpg",
    },
    {
      "judul": "Lomba Startup",
      "deskripsi": "Kompetisi ide startup inovatif antar mahasiswa.",
      "tanggal": "1 Oktober 2025",
      "lokasi": "Gedung Serbaguna",
      "gambar": "assets/images/startup_competition.jpg",
    },
  ];

  String _searchQuery = "";
  String _sortOption = "Tanggal";

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredList = _eventList
        .where((event) =>
            event["judul"]!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            event["deskripsi"]!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            event["lokasi"]!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    if (_sortOption == "Tanggal") {
      filteredList.sort((a, b) => a["tanggal"]!.compareTo(b["tanggal"]!));
    } else if (_sortOption == "Judul") {
      filteredList.sort((a, b) => a["judul"]!.compareTo(b["judul"]!));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Kampus"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 🔎 Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari event...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // 🔄 Dropdown Sorting
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  "Sort by:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: _sortOption,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: "Tanggal",
                        child: Text("Tanggal"),
                      ),
                      DropdownMenuItem(
                        value: "Judul",
                        child: Text("Judul"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _sortOption = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 📌 Grid View of Events
          Expanded(
            child: filteredList.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Event tidak ditemukan",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.95,
                    ),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final event = filteredList[index];
                      final delay = (index * 150).ms;

                      return InkWell(
                        onTap: () {
                          _showEventDetail(context, event);
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 🖼️ Image dengan ClipRRect
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 1.5,
                                  child: Image.asset(
                                    event["gambar"]!,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: double.infinity,
                                        color: Colors.deepPurple.withOpacity(0.1),
                                        child: const Icon(
                                          Icons.event,
                                          size: 40,
                                          color: Colors.deepPurple,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              // 📄 Content
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event["judul"]!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    
                                    Text(
                                      event["deskripsi"]!,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),

                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          size: 11,
                                          color: Colors.deepPurple,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            event["tanggal"]!,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),

                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          size: 11,
                                          color: Colors.deepPurple,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            event["lokasi"]!,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                          .animate(delay: delay)
                          .fadeIn(duration: 500.ms)
                          .scale(
                              begin: const Offset(0.8, 0.8),
                              duration: 500.ms);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showEventDetail(BuildContext context, Map<String, String> event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  event["gambar"]!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.deepPurple.withOpacity(0.1),
                      child: const Icon(
                        Icons.event,
                        size: 80,
                        color: Colors.deepPurple,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                event["judul"]!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                event["deskripsi"]!,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.deepPurple),
                    const SizedBox(width: 12),
                    Text(
                      event["tanggal"]!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.deepPurple),
                    const SizedBox(width: 12),
                    Text(
                      event["lokasi"]!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Kamu mendaftar di ${event["judul"]}"),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Daftar Sekarang",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }
}