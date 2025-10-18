import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';
import '../../models/event_model.dart';
import 'bookmark_user.dart';

class DashboardUserPage extends StatefulWidget {
  
  final User user;
  const DashboardUserPage({super.key, required this.user});

  @override
  State<DashboardUserPage> createState() => _DashboardUserPageState();
}

class _DashboardUserPageState extends State<DashboardUserPage> {
  List<EventModel> events = [
    EventModel(
      judul: "Seminar AI & Machine Learning",
      deskripsi: "Membahas perkembangan AI terkini.",
      tanggal: "20 Oktober 2025",
      lokasi: "Surabaya",
    ),
    EventModel(
      judul: "Workshop UI/UX Design Thinking",
      deskripsi: "Belajar membangun pengalaman pengguna modern.",
      tanggal: "25 Oktober 2025",
      lokasi: "Online",
    ),
    EventModel(
      judul: "Hackathon Nasional 2025",
      deskripsi: "Kompetisi inovasi digital skala nasional.",
      tanggal: "1 November 2025",
      lokasi: "Jakarta",
    ),
  ];

  List<EventModel> bookmarkedEvents = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('bookmarked_events');

    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      setState(() {
        bookmarkedEvents =
            decoded.map((e) => EventModel.fromMap(Map<String, dynamic>.from(e))).toList();
      });
    }
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString =
        jsonEncode(bookmarkedEvents.map((e) => e.toMap()).toList());
    await prefs.setString('bookmarked_events', jsonString);
  }

  void toggleBookmark(EventModel event) {
    setState(() {
      if (bookmarkedEvents.any((e) => e.judul == event.judul)) {
        bookmarkedEvents.removeWhere((e) => e.judul == event.judul);
      } else {
        bookmarkedEvents.add(event);
      }
    });
    _saveBookmarks();
  }

  void goToBookmarks() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookmarkUserPage(
          user: widget.user,
          bookmarkedEvents: bookmarkedEvents,
          onRemove: (event) {
            toggleBookmark(event);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Halo, ${widget.user.name}!"),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: goToBookmarks,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          final isBookmarked =
              bookmarkedEvents.any((e) => e.judul == event.judul);

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 3,
            child: ListTile(
              title: Text(event.judul),
              subtitle: Text("${event.tanggal} • ${event.lokasi}"),
              trailing: IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? Colors.purple : Colors.grey,
                ),
                onPressed: () => toggleBookmark(event),
              ),
            ),
          );
        },
      ),
    );
  }
}
