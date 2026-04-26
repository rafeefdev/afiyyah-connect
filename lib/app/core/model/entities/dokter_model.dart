class DokterModel {
  final String id;
  final String namaDokter;
  final String? spesialis;

  DokterModel({required this.id, required this.namaDokter, this.spesialis});

  factory DokterModel.fromJson(Map<String, dynamic> json) {
    return DokterModel(
      id: json['id'] as String? ?? '',
      namaDokter: json['nama_dokter'] as String? ?? '',
      spesialis: json['spesialis'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'nama_dokter': namaDokter, 'spesialis': spesialis};
  }
}
