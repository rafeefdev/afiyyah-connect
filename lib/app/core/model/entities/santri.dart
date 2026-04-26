/// Merepresentasikan data seorang santri dari tabel `data_santri`.
class Santri {
  final String id;
  final String nama;
  final String? nis;
  final String? hujrohId;
  final bool statusAktif;
  final int? jenjang;
  final int? tahunMasuk;
  final String? namaHujroh;

  Santri({
    required this.id,
    required this.nama,
    this.nis,
    this.hujrohId,
    this.statusAktif = true,
    this.jenjang,
    this.tahunMasuk,
    this.namaHujroh,
  });

  /// Membuat instance Santri dari tabel `data_santri`.
  factory Santri.fromTable(Map<String, dynamic> json) {
    return Santri(
      id: json['id'] as String? ?? '',
      nama: json['nama'] as String? ?? 'Tanpa Nama',
      nis: json['nis'] as String?,
      hujrohId: json['hujroh_id'] as String?,
      statusAktif: json['status_aktif'] as bool? ?? true,
    );
  }

  /// Membuat instance Santri dari view `v_santri_detail`.
  factory Santri.fromJson(Map<String, dynamic> json) {
    return Santri(
      id: json['santri_id'] as String? ?? '',
      nama: json['nama'] as String? ?? 'Tanpa Nama',
      nis: json['nis'] as String?,
      hujrohId: json['hujroh_id'] as String?,
      statusAktif: json['status_aktif'] as bool? ?? true,
      jenjang: json['jenjang'] as int?,
      tahunMasuk: json['tahun_masuk'] as int?,
      namaHujroh: json['nama_hujroh'] as String?,
    );
  }

  /// Membuat Map untuk insert ke database.
  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'nis': nis,
      'hujroh_id': hujrohId,
      'status_aktif': statusAktif,
    };
  }

  /// Membuat data dummy untuk keperluan UI prototyping.
  factory Santri.generateDummyData() {
    return Santri(
      id: 'dummy-id',
      nama: 'Fulan bin Fulan',
      nis: '12345',
      hujrohId: 'hujroh-001',
      statusAktif: true,
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
