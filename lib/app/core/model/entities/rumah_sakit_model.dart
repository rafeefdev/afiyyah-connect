class RumahSakitModel {
  final String id;
  final String namaRs;
  final String? alamat;

  RumahSakitModel({required this.id, required this.namaRs, this.alamat});

  factory RumahSakitModel.fromJson(Map<String, dynamic> json) {
    return RumahSakitModel(
      id: json['id'] as String? ?? '',
      namaRs: json['nama_rs'] as String? ?? '',
      alamat: json['alamat'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'nama_rs': namaRs, 'alamat': alamat};
  }
}
