class ResepObatModel {
  final String? id;
  final String? pemeriksaanId;
  final String? namaObat;
  final String? dosis;

  ResepObatModel({this.id, this.pemeriksaanId, this.namaObat, this.dosis});

  factory ResepObatModel.fromJson(Map<String, dynamic> json) {
    return ResepObatModel(
      id: json['id'] as String?,
      pemeriksaanId: json['pemeriksaan_id'] as String?,
      namaObat: json['nama_obat'] as String?,
      dosis: json['dosis'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pemeriksaan_id': pemeriksaanId,
      'nama_obat': namaObat,
      'dosis': dosis,
    };
  }
}
