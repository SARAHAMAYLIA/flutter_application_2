import 'package:flutter/material.dart';

class UserManagementView extends StatelessWidget {
  final List<Map<String, dynamic>> users;
  final String searchQuery;

  const UserManagementView({
    super.key,
    required this.users,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
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
