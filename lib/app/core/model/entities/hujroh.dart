/// Merepresentasikan data kamar/hujroh dari tabel `hujroh`.
class Hujroh {
  final String id;
  final String namaHujroh;
  final String? asramaId;

  Hujroh({required this.id, required this.namaHujroh, this.asramaId});

  factory Hujroh.fromJson(Map<String, dynamic> json) {
    return Hujroh(
      id: json['id'] as String? ?? '',
      namaHujroh: json['nama_hujroh'] as String? ?? '',
      asramaId: json['asrama_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'nama_hujroh': namaHujroh, 'asrama_id': asramaId};
  }
}
