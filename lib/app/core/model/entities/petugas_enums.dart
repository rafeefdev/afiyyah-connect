enum JenisPetugas { piketAsrama, resepsionisKlinik }

extension JenisPetugasExtension on JenisPetugas {
  String get value {
    switch (this) {
      case JenisPetugas.piketAsrama:
        return 'piket_asrama';
      case JenisPetugas.resepsionisKlinik:
        return 'resepsionis_klinik';
    }
  }

  static JenisPetugas fromString(String? value) {
    switch (value) {
      case 'piket_asrama':
        return JenisPetugas.piketAsrama;
      case 'resepsionis_klinik':
        return JenisPetugas.resepsionisKlinik;
      default:
        return JenisPetugas.piketAsrama;
    }
  }
}
