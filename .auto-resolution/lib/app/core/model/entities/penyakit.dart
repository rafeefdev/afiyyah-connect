class Penyakit {
  final String id;
  final String nama;
  final String? kodeICD;
  final String? deskripsi;
  final bool menular;

  Penyakit({
    required this.id,
    required this.nama,
    required this.kodeICD,
    required this.deskripsi,
    required this.menular,
  });
}
