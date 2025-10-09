import 'package:flutter/material.dart';
import '../../utils/format_helper.dart';

class EventManagementView extends StatefulWidget {
  final List<Map<String, dynamic>> events;
  final String searchQuery;

  const EventManagementView({
    super.key,
    required this.events,
    required this.searchQuery,
  });

  @override
  State<EventManagementView> createState() => _EventManagementViewState();
}

class _EventManagementViewState extends State<EventManagementView> {
  late List<Map<String, dynamic>> _eventList;

  @override
  void initState() {
    super.initState();
    _eventList = widget.events;
  }

  void _addEventDialog(BuildContext context) {
    final idController = TextEditingController();
    final nameController = TextEditingController();
    final dateController = TextEditingController();
    final statusController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Tambah Event Baru"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: "ID Event"),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nama Event"),
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                    labelText: "Tanggal (format: yyyy-MM-dd)"),
              ),
              TextField(
                controller: statusController,
                decoration: const InputDecoration(labelText: "Status"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _eventList.add({
                  "id": idController.text,
                  "name": nameController.text,
                  "date": dateController.text,
                  "status": statusController.text,
                });
              });
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _eventList
        .where((e) =>
            e["name"].toLowerCase().contains(widget.searchQuery.toLowerCase()) ||
            e["status"].toLowerCase().contains(widget.searchQuery.toLowerCase()))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul + Tombol Tambah
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Kelola Event",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Tambah Event"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              onPressed: () => _addEventDialog(context),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Tabel Event
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              headingRowColor: WidgetStateColor.resolveWith(
                (_) => const Color(0xFFF4F6FA),
              ),
              columns: const [
                DataColumn(label: Text("ID Event")),
                DataColumn(label: Text("Nama Event")),
                DataColumn(label: Text("Tanggal")),
                DataColumn(label: Text("Status")),
                DataColumn(label: Text("Aksi")),
              ],
              rows: filtered.map((e) {
                return DataRow(cells: [
                  DataCell(Text(e["id"].toString())),
                  DataCell(Text(e["name"])),
                  DataCell(
                      Text("Tanggal: ${FormatHelper.formatDate(e['date'])}")),
                  DataCell(Text(e["status"])),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _eventList.remove(e);
                          });
                        },
                      ),
                    ],
                  )),
                ]);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
