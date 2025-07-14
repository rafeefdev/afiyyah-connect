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
      id: 'id',
      kelasId: 'kelasID',
      name: 'Fulan Doe',
      hujrohId: 'hujrohID',
      tahunMasuk: DateTime(2020)
    );
  }
}
