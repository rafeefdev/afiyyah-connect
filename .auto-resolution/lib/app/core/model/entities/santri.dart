/// Merepresentasikan data detail seorang santri yang diambil dari view `v_santri_detail`.
class Santri {
  final String id;
  final String nama;
  final int? jenjang;
  final int? tahunMasuk;
  final String? namaHujroh;

  Santri({
    required this.id,
    required this.nama,
    this.jenjang,
    this.tahunMasuk,
    this.namaHujroh,
  });

  /// Membuat instance Santri dari JSON object.
  /// Didesain untuk menjadi null-safe dan cocok dengan kolom dari `v_santri_detail`.
  factory Santri.fromJson(Map<String, dynamic> json) {
    return Santri(
      id: json['santri_id'] as String? ?? '',
      nama: json['nama'] as String? ?? 'Tanpa Nama',
      jenjang: json['jenjang'] as int?,
      tahunMasuk: json['tahun_masuk'] as int?,
      namaHujroh: json['nama_hujroh'] as String?,
    );
  }

  /// Membuat data dummy untuk keperluan UI prototyping.
  factory Santri.generateDummyData() {
    return Santri(
      id: 'dummy-id',
      nama: 'Fulan bin Fulan',
      jenjang: 3,
      tahunMasuk: 2022,
      namaHujroh: 'Kamar A-15',
    );
  }

  @override
  String toString() {
    return 'Santri(id: $id, nama: $nama, namaHujroh: $namaHujroh)';
  }
}
