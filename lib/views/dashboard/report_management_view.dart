import 'package:flutter/material.dart';

class ReportManagementView extends StatelessWidget {
  final List<Map<String, dynamic>> reports;
  final String searchQuery;

  const ReportManagementView({
    super.key,
    required this.reports,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    final filtered = reports
        .where((r) =>
            r["title"].toLowerCase().contains(searchQuery) ||
            r["type"].toLowerCase().contains(searchQuery))
        .toList();

    return _buildTable("Laporan", [
      "ID Laporan",
      "Judul",
      "Tanggal",
      "Tipe",
      "Aksi"
    ], filtered.map((r) {
      return DataRow(cells: [
        DataCell(Text(r["id"])),
        DataCell(Text(r["title"])),
        DataCell(Text(r["date"])),
        DataCell(Text(r["type"])),
        DataCell(Row(children: [
          IconButton(icon: const Icon(Icons.download, color: Colors.green), onPressed: () {}),
          IconButton(icon: const Icon(Icons.visibility, color: Colors.blue), onPressed: () {})
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
                  WidgetStateColor.resolveWith((_) => const Color(0xFFF4F6FA)),
              columns: columns.map((c) => DataColumn(label: Text(c))).toList(),
              rows: rows,
            ),
          ),
        ),
      ],
    );
  }
}
