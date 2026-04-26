import 'package:afiyyah_connect/app/core/model/activities/periksaklinikstatus_model.dart';

class PendataanKesehatanModel {
  final String? id;
  final DateTime? createdAt;
  final List<String> keluhan;
  final DateTime mulaiSakit;
  final String santuarioId;
  final PeriksaKlinikStatus? statusPeriksa;
  final DateTime? waktuMulaiSakit;
  final String? userId;

  PendataanKesehatanModel({
    this.id,
    this.createdAt,
    required this.keluhan,
    required this.mulaiSakit,
    required this.santuarioId,
    this.statusPeriksa,
    this.waktuMulaiSakit,
    this.userId,
  });

  factory PendataanKesehatanModel.fromJson(Map<String, dynamic> json) {
    return PendataanKesehatanModel(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      keluhan:
          (json['keluhan'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      mulaiSakit: DateTime.parse(json['mulai_sakit'] as String),
      santuarioId: json['santri_id'] as String,
      statusPeriksa: PeriksaKlinikStatusExtension.fromString(
        json['status_periksa'] as String?,
      ),
      waktuMulaiSakit: json['waktu_mulai_sakit'] != null
          ? DateTime.parse(json['waktu_mulai_sakit'] as String)
          : null,
      userId: json['user_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'keluhan': keluhan,
      'mulai_sakit': mulaiSakit.toIso8601String(),
      'santri_id': santuarioId,
      'status_periksa': statusPeriksa?.value,
      'waktu_mulai_sakit': waktuMulaiSakit?.toIso8601String(),
      'user_id': userId,
    };
  }
}
