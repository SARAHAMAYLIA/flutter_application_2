import 'package:flutter/material.dart';

class UserManagementView extends StatefulWidget {
  final List<Map<String, dynamic>> users;
  final String searchQuery;

  const UserManagementView({
    super.key,
    required this.users,
    required this.searchQuery,
  });

  @override
  State<UserManagementView> createState() => _UserManagementViewState();
}

class _UserManagementViewState extends State<UserManagementView> {
  late List<Map<String, dynamic>> _users;

  @override
  void initState() {
    super.initState();
    _users = List.from(widget.users);
  }

  void _addUser() {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    String role = "Mahasiswa";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Tambah User Baru"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            DropdownButtonFormField<String>(
              initialValue: role,
              items: const [
                DropdownMenuItem(value: "Admin", child: Text("Admin")),
                DropdownMenuItem(value: "Mahasiswa", child: Text("Mahasiswa")),
              ],
              onChanged: (value) => role = value!,
              decoration: const InputDecoration(labelText: "Peran"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _users.add({
                  "id": "USER00${_users.length + 1}",
                  "name": nameController.text,
                  "email": emailController.text,
                  "role": role,
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

  void _editUser(Map<String, dynamic> user) {
    TextEditingController nameController = TextEditingController(text: user["name"]);
    TextEditingController emailController = TextEditingController(text: user["email"]);
    String role = user["role"];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Data User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            DropdownButtonFormField<String>(
              initialValue: role,
              items: const [
                DropdownMenuItem(value: "Admin", child: Text("Admin")),
                DropdownMenuItem(value: "Mahasiswa", child: Text("Mahasiswa")),
              ],
              onChanged: (value) => role = value!,
              decoration: const InputDecoration(labelText: "Peran"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                user["name"] = nameController.text;
                user["email"] = emailController.text;
                user["role"] = role;
              });
              Navigator.pop(context);
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  void _deleteUser(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hapus User"),
        content: Text("Apakah kamu yakin ingin menghapus ${user["name"]}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _users.remove(user);
              });
              Navigator.pop(context);
            },
            child: const Text("Hapus"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _users
        .where((u) =>
            u["name"].toLowerCase().contains(widget.searchQuery) ||
            u["email"].toLowerCase().contains(widget.searchQuery))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Kelola User",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Tambah User"),
              onPressed: _addUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5D7AFF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              headingRowColor:
                  WidgetStateColor.resolveWith((_) => const Color(0xFFF4F6FA)),
              columns: const [
                DataColumn(label: Text("ID User")),
                DataColumn(label: Text("Nama")),
                DataColumn(label: Text("Email")),
                DataColumn(label: Text("Peran")),
                DataColumn(label: Text("Aksi")),
              ],
              rows: filtered.map((u) {
                return DataRow(cells: [
                  DataCell(Text(u["id"])),
                  DataCell(Text(u["name"])),
                  DataCell(Text(u["email"])),
                  DataCell(Text(u["role"])),
                  DataCell(Row(children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _editUser(u),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteUser(u),
                    ),
                  ])),
                ]);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
