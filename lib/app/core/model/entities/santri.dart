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
      id: json['id'].toString(),
      name: json['nama'],
      tahunMasuk: DateTime.parse(json['tahun_masuk']),
      // TODO : insert real id
      hujrohId: json['hujroh'],
      kelasId: json['kelas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tahun_masuk': tahunMasuk.toIso8601String(),
      'hujroh_id': hujrohId,
      'kelas_id': kelasId,
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
