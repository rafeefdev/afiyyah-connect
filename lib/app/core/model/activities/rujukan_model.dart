import 'package:afiyyah_connect/app/core/model/activities/rujukan_enums.dart';

class RujukanModel {
  final String? id;
  final String? pemeriksaanId;
  final String? rumahSakitId;
  final StatusRujukan? statusRujukan;
  final DateTime? createdAt;

  RujukanModel({
    this.id,
    this.pemeriksaanId,
    this.rumahSakitId,
    this.statusRujukan,
    this.createdAt,
  });

  factory RujukanModel.fromJson(Map<String, dynamic> json) {
    return RujukanModel(
      id: json['id'] as String?,
      pemeriksaanId: json['pemeriksaan_id'] as String?,
      rumahSakitId: json['rumah_sakit_id'] as String?,
      statusRujukan: StatusRujukanExtension.fromString(
        json['status_rujukan'] as String?,
      ),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pemeriksaan_id': pemeriksaanId,
      'rumah_sakit_id': rumahSakitId,
      'status_rujukan': statusRujukan?.value,
    };
  }
}
