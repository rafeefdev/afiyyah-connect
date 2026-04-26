class PemeriksaanDokterModel {
  final String? id;
  final String? kunjunganId;
  final String? idDokter;
  final String? diagnosa;
  final String? resep;
  final DateTime? createdAt;

  PemeriksaanDokterModel({
    this.id,
    this.kunjunganId,
    this.idDokter,
    this.diagnosa,
    this.resep,
    this.createdAt,
  });

  factory PemeriksaanDokterModel.fromJson(Map<String, dynamic> json) {
    return PemeriksaanDokterModel(
      id: json['id'] as String?,
      kunjunganId: json['kunjungan_id'] as String?,
      idDokter: json['id_dokter'] as String?,
      diagnosa: json['diagnosa'] as String?,
      resep: json['resep'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kunjungan_id': kunjunganId,
      'id_dokter': idDokter,
      'diagnosa': diagnosa,
      'resep': resep,
    };
  }
}
