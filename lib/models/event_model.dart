class EventModel {
  String _judul = "";
  String _deskripsi = "";
  String _tanggal = "";
  String _lokasi = "";

  // Constructor
  EventModel({
    required String judul,
    required String deskripsi,
    required String tanggal,
    required String lokasi,
  }) {
    _judul = judul;
    _deskripsi = deskripsi;
    _tanggal = tanggal;
    _lokasi = lokasi;
  }

  // Getter
  String get judul => _judul;
  String get deskripsi => _deskripsi;
  String get tanggal => _tanggal;
  String get lokasi => _lokasi;

  // Setter
  set judul(String value) => _judul = value;
  set deskripsi(String value) => _deskripsi = value;
  set tanggal(String value) => _tanggal = value;
  set lokasi(String value) => _lokasi = value;
}
