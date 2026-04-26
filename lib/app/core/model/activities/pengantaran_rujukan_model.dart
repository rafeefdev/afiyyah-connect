import 'package:afiyyah_connect/app/core/model/activities/pengantaran_enums.dart';

class PengantaranRujukanModel {
  final String? id;
  final String? rujukanId;
  final String? idPetugas;
  final DateTime? tanggalPengantaran;
  final String? sumberDana;

  PengantaranRujukanModel({
    this.id,
    this.rujukanId,
    this.idPetugas,
    this.tanggalPengantaran,
    this.sumberDana,
  });

  factory PengantaranRujukanModel.fromJson(Map<String, dynamic> json) {
    return PengantaranRujukanModel(
      id: json['id'] as String?,
      rujukanId: json['rujukan_id'] as String?,
      idPetugas: json['id_petugas'] as String?,
      tanggalPengantaran: json['tanggal_pengantaran'] != null
          ? DateTime.parse(json['tanggal_pengantaran'] as String)
          : null,
      sumberDana: json['sumber_dana'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rujukan_id': rujukanId,
      'id_petugas': idPetugas,
      'tanggal_pengantaran': tanggalPengantaran?.toIso8601String(),
      'sumber_dana': sumberDana,
    };
  }
}
