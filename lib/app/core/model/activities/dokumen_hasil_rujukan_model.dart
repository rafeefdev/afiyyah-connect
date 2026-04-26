import 'package:afiyyah_connect/app/core/model/activities/dokumen_enums.dart';

class DokumenHasilRujukanModel {
  final String? id;
  final String? hasilRujukanId;
  final String? namaFile;
  final String? pathFile;
  final JenisDokumen? jenisDokumen;

  DokumenHasilRujukanModel({
    this.id,
    this.hasilRujukanId,
    this.namaFile,
    this.pathFile,
    this.jenisDokumen,
  });

  factory DokumenHasilRujukanModel.fromJson(Map<String, dynamic> json) {
    return DokumenHasilRujukanModel(
      id: json['id'] as String?,
      hasilRujukanId: json['hasil_rujukan_id'] as String?,
      namaFile: json['nama_file'] as String?,
      pathFile: json['path_file'] as String?,
      jenisDokumen: JenisDokumenExtension.fromString(
        json['jenis_dokumen'] as String?,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hasil_rujukan_id': hasilRujukanId,
      'nama_file': namaFile,
      'path_file': pathFile,
      'jenis_dokumen': jenisDokumen?.value,
    };
  }
}
