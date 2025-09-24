import 'package:flutter/material.dart';
import '../models/event_model.dart';

class EventKampusPage extends StatefulWidget {
  const EventKampusPage({super.key});

  @override
  State<EventKampusPage> createState() => _EventKampusPageState();
}

class _EventKampusPageState extends State<EventKampusPage> {
  final List<EventModel> _eventList = [
    EventModel(
      judul: "Seminar AI dan Big Data",
      deskripsi: "Diskusi tentang perkembangan AI dan penerapan Big Data.",
      tanggal: "20 September 2025",
      lokasi: "Aula Kampus A",
    ),
    EventModel(
      judul: "Workshop Flutter",
      deskripsi: "Belajar membuat aplikasi mobile dengan Flutter.",
      tanggal: "25 September 2025",
      lokasi: "Lab Informatika",
    ),
    EventModel(
      judul: "Lomba Startup",
      deskripsi: "Kompetisi ide startup inovatif antar mahasiswa.",
      tanggal: "1 Oktober 2025",
      lokasi: "Gedung Serbaguna",
    ),
  ];

  String _searchQuery = "";
  String _sortOption = "Tanggal"; // default sorting

  @override
  Widget build(BuildContext context) {
    // 🔎 Filter berdasarkan search
    List<EventModel> filteredList = _eventList
        .where((event) =>
            event.judul.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            event.deskripsi.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            event.lokasi.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    // 🔄 Sorting
    if (_sortOption == "Tanggal") {
      filteredList.sort((a, b) => a.tanggal.compareTo(b.tanggal));
    } else if (_sortOption == "Judul") {
      filteredList.sort((a, b) => a.judul.compareTo(b.judul));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Kampus"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // 🔎 Search bar
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari event...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Text("Sort by: ",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _sortOption,
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
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 📌 List Event
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final event = filteredList[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(Icons.event, color: Colors.deepPurple),
                    title: Text(event.judul,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("📅 ${event.tanggal} | 📍 ${event.lokasi}"),
                    onTap: () {
                      // detail dalam modal
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (_) {
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: 40,
                                    height: 5,
                                    margin: const EdgeInsets.only(bottom: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Text(
                                  event.judul,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(event.deskripsi),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        color: Colors.deepPurple),
                                    const SizedBox(width: 8),
                                    Text(event.tanggal),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on,
                                        color: Colors.deepPurple),
                                    const SizedBox(width: 8),
                                    Text(event.lokasi),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Kamu mendaftar di ${event.judul}"),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Daftar Sekarang",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
