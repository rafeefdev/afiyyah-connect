import 'package:afiyyah_connect/app/core/model/entities/golongandarah_enum.dart';

class RiwayatKesehatanSantriModel {
  final String? id;
  final String santuarioId;
  final GolonganDarah? golongandarah;
  final List<String>? alergi;
  final List<String>? penyakitBawaan;

  RiwayatKesehatanSantriModel({
    this.id,
    required this.santuarioId,
    this.golongandarah,
    this.alergi,
    this.penyakitBawaan,
  });

  factory RiwayatKesehatanSantriModel.fromJson(Map<String, dynamic> json) {
    return RiwayatKesehatanSantriModel(
      id: json['id'] as String?,
      santuarioId: json['id_siswa'] as String,
      golongandarah: GolonganDarahExtension.fromString(
        json['golongandarah'] as String?,
      ),
      alergi: (json['alergi'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      penyakitBawaan: (json['penyakit_bawaan'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_siswa': santuarioId,
      'golongandarah': golongandarah?.value,
      'alergi': alergi,
      'penyakit_bawaan': penyakitBawaan,
    };
  }
}
