class HistoriHujrohSiswaModel {
  final String? id;
  final String? siswaId;
  final String? hujrohId;
  final DateTime? tanggalMulai;
  final DateTime? tanggalSelesai;

  HistoriHujrohSiswaModel({
    this.id,
    this.siswaId,
    this.hujrohId,
    this.tanggalMulai,
    this.tanggalSelesai,
  });

  factory HistoriHujrohSiswaModel.fromJson(Map<String, dynamic> json) {
    return HistoriHujrohSiswaModel(
      id: json['id'] as String?,
      siswaId: json['siswa_id'] as String?,
      hujrohId: json['hujroh_id'] as String?,
      tanggalMulai: json['tanggal_mulai'] != null
          ? DateTime.parse(json['tanggal_mulai'] as String)
          : null,
      tanggalSelesai: json['tanggal_selesai'] != null
          ? DateTime.parse(json['tanggal_selesai'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'siswa_id': siswaId,
      'hujroh_id': hujrohId,
      'tanggal_mulai': tanggalMulai?.toIso8601String(),
      'tanggal_selesai': tanggalSelesai?.toIso8601String(),
    };
  }
}
