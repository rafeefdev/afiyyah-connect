import 'package:afiyyah_connect/app/core/model/activities/kwitansi_enums.dart';

class KwitansiPengantaranModel {
  final String? id;
  final String? pengantaranId;
  final String? namaFile;
  final String? pathFile;
  final JenisKwitansi? jenisKwitansi;

  KwitansiPengantaranModel({
    this.id,
    this.pengantaranId,
    this.namaFile,
    this.pathFile,
    this.jenisKwitansi,
  });

  factory KwitansiPengantaranModel.fromJson(Map<String, dynamic> json) {
    return KwitansiPengantaranModel(
      id: json['id'] as String?,
      pengantaranId: json['pengantaran_id'] as String?,
      namaFile: json['nama_file'] as String?,
      pathFile: json['path_file'] as String?,
      jenisKwitansi: JenisKwitansiExtension.fromString(
        json['jenis_kwitansi'] as String?,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pengantaran_id': pengantaranId,
      'nama_file': namaFile,
      'path_file': pathFile,
      'jenis_kwitansi': jenisKwitansi?.value,
    };
  }
}
