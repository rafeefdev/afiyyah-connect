import 'package:afiyyah_connect/app/core/model/activities/diagnosa.dart';

class KunjunganKlinik {
  final String id;
  final String santriId;
  // NULLABLE - ini kunci utamanya! : bernilai Null jika santri masih masuk sekolah
  final String? pendataanKesehatanId; 
  final String jenisKunjungan; // pertama_kali, ulang, kontrol
  final String keluhanUtama;
  final String diagnosis;
  final Arahan arahan; // masuk_sekolah, istirahat_asrama
  final bool perluRujukan;
  final DateTime waktuMasuk;
  
  // Constructor
  KunjunganKlinik({
    required this.id,
    required this.santriId,
    this.pendataanKesehatanId, // Bisa null jika langsung ke klinik
    required this.jenisKunjungan,
    required this.keluhanUtama,
    required this.diagnosis,
    required this.arahan,
    this.perluRujukan = false,
    required this.waktuMasuk,
  });
}