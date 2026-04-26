import 'package:afiyyah_connect/app/core/model/entities/petugas_enums.dart';

class PetugasModel {
  final String id;
  final String namaPetugas;
  final JenisPetugas? jenisPetugas;

  PetugasModel({
    required this.id,
    required this.namaPetugas,
    this.jenisPetugas,
  });

  factory PetugasModel.fromJson(Map<String, dynamic> json) {
    return PetugasModel(
      id: json['id'] as String? ?? '',
      namaPetugas: json['nama_petugas'] as String? ?? '',
      jenisPetugas: JenisPetugasExtension.fromString(
        json['jenis_petugas'] as String?,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'nama_petugas': namaPetugas, 'jenis_petugas': jenisPetugas?.value};
  }
}
