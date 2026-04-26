/// Merepresentasikan data kelas dari tabel `kelas`.
class Kelas {
  final String id;
  final String namaKelas;
  final int? tingkat;

  Kelas({required this.id, required this.namaKelas, this.tingkat});

  factory Kelas.fromJson(Map<String, dynamic> json) {
    return Kelas(
      id: json['id'] as String? ?? '',
      namaKelas: json['nama_kelas'] as String? ?? '',
      tingkat: json['tingkat'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'nama_kelas': namaKelas, 'tingkat': tingkat};
  }
}
