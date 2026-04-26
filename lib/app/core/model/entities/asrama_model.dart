class AsramaModel {
  final String id;
  final String namaAsrama;

  AsramaModel({required this.id, required this.namaAsrama});

  factory AsramaModel.fromJson(Map<String, dynamic> json) {
    return AsramaModel(
      id: json['id'] as String? ?? '',
      namaAsrama: json['nama_asrama'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'nama_asrama': namaAsrama};
  }
}
