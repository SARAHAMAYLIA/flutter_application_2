import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../models/event_model.dart';

class BookmarkUserPage extends StatelessWidget {
  final User user;
  final List<EventModel> bookmarkedEvents;
  final Function(EventModel)? onRemove;

  const BookmarkUserPage({
    super.key,
    required this.user,
    required this.bookmarkedEvents,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmark Saya"),
        backgroundColor: Colors.purple,
      ),
      body: bookmarkedEvents.isEmpty
          ? const Center(
              child: Text(
                "Belum ada event yang disimpan 😔",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: bookmarkedEvents.length,
              itemBuilder: (context, index) {
                final event = bookmarkedEvents[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.event_note, color: Colors.purple),
                    title: Text(event.judul),
                    subtitle: Text("${event.tanggal} • ${event.lokasi}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        onRemove?.call(event);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
