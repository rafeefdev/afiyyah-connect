import 'package:afiyyah_connect/app/core/model/hujroh.dart';
import 'package:afiyyah_connect/app/core/model/kelas.dart';

class Santri {
  String name;
  DateTime tahunMasuk;
  Hujroh hujroh;
  Kelas kelas;

  Santri({
    required this.name,
    required this.tahunMasuk,
    required this.hujroh,
    required this.kelas,
  });
}
