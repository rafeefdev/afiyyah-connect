import 'package:afiyyah_connect/app/core/model/activities/klinik_enums.dart';

class KunjunganKlinikModel {
  final String? id;
  final String? pendataanId;
  final String santuarioId;
  final SumberKunjungan? sumberKunjungan;
  final StatusPengarahan? statusPengarahan;

  KunjunganKlinikModel({
    this.id,
    this.pendataanId,
    required this.santuarioId,
    this.sumberKunjungan,
    this.statusPengarahan,
  });

  factory KunjunganKlinikModel.fromJson(Map<String, dynamic> json) {
    return KunjunganKlinikModel(
      id: json['id'] as String?,
      pendataanId: json['pendataan_id'] as String?,
      santuarioId: json['santri_id'] as String,
      sumberKunjungan: SumberKunjunganExtension.fromString(
        json['sumber_kunjungan'] as String?,
      ),
      statusPengarahan: StatusPengarahanExtension.fromString(
        json['status_pengarahan'] as String?,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pendataan_id': pendataanId,
      'santri_id': santuarioId,
      'sumber_kunjungan': sumberKunjungan?.value,
      'status_pengarahan': statusPengarahan?.value,
    };
  }
}
