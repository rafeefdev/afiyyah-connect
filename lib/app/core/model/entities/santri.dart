class Santri {
  String id;
  String name;
  DateTime tahunMasuk;
  String hujrohId;
  String kelasId;

  Santri({
    required this.id,
    required this.name,
    required this.tahunMasuk,
    required this.hujrohId,
    required this.kelasId,
  });

  // TODO: Sesuaikan nama field ('id', 'name', 'tahun_masuk', dll) dengan nama kolom di tabel Supabase Anda.
  factory Santri.fromJson(Map<String, dynamic> json) {
    return Santri(
      // Kunci sudah benar, menggunakan 'santri_id'
      id: json['santri_id'],

      // Kunci sudah benar, menggunakan 'nama'
      name: json['nama'],

      // FIX: 'tahun_masuk' adalah int (misal: 2023), bukan String. 
      // Buat objek DateTime langsung dari tahun tersebut.
      tahunMasuk: DateTime(json['tahun_masuk']),

      // Kunci sudah benar, menggunakan 'hujroh'
      hujrohId: json['hujroh'],

      // FIX: 'jenjang' adalah int (misal: 9), sedangkan kelasId adalah String.
      // Konversi int menjadi String.
      kelasId: json['jenjang'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tahun_masuk': tahunMasuk.toIso8601String(),
      'hujroh_id': hujrohId.toString(),
      'kelas_id': kelasId.toString(),
    };
  }

  static Santri generateDummyData() {
    return Santri(
      id: '18437123786',
      kelasId: 'X IPA 1',
      name: 'Fulan Doe',
      hujrohId: 'Damaskus',
      tahunMasuk: DateTime(2020)
    );
  }
}
