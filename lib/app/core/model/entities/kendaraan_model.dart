import 'package:afiyyah_connect/app/core/model/entities/kendaraan_enums.dart';

class KendaraanModel {
  final String id;
  final String namaKendaraan;
  final JenisKepemilikan? jenisKepemilikan;

  KendaraanModel({
    required this.id,
    required this.namaKendaraan,
    this.jenisKepemilikan,
  });

  factory KendaraanModel.fromJson(Map<String, dynamic> json) {
    return KendaraanModel(
      id: json['id'] as String? ?? '',
      namaKendaraan: json['nama_kendaraan'] as String? ?? '',
      jenisKepemilikan: JenisKepemilikanExtension.fromString(
        json['jenis_kepemilikan'] as String?,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_kendaraan': namaKendaraan,
      'jenis_kepemilikan': jenisKepemilikan?.value,
    };
  }
}
