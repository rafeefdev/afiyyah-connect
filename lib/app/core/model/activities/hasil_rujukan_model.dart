class HasilRujukanModel {
  final String? id;
  final String? rujukanId;
  final DateTime? tanggalHasil;
  final String? dokumentasi;

  HasilRujukanModel({
    this.id,
    this.rujukanId,
    this.tanggalHasil,
    this.dokumentasi,
  });

  factory HasilRujukanModel.fromJson(Map<String, dynamic> json) {
    return HasilRujukanModel(
      id: json['id'] as String?,
      rujukanId: json['rujukan_id'] as String?,
      tanggalHasil: json['tanggal_hasil'] != null
          ? DateTime.parse(json['tanggal_hasil'] as String)
          : null,
      dokumentasi: json['dokumentasi'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rujukan_id': rujukanId,
      'tanggal_hasil': tanggalHasil?.toIso8601String(),
      'dokumentasi': dokumentasi,
    };
  }
}
