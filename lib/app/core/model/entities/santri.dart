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
