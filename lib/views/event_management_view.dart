import 'package:flutter/material.dart';

class EventManagementView extends StatelessWidget {
  final List<Map<String, dynamic>> events;
  final String searchQuery;

  const EventManagementView({
    super.key,
    required this.events,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
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
        DataCell(Row(children: [
          IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () {}),
          IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () {})
        ]))
      ]);
    }).toList());
  }

  Widget _buildTable(
      String title, List<String> columns, List<DataRow> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              headingRowColor:
                  MaterialStateColor.resolveWith((_) => const Color(0xFFF4F6FA)),
              columns: columns.map((c) => DataColumn(label: Text(c))).toList(),
              rows: rows,
            ),
          ),
        ),
      ],
    );
  }
}
