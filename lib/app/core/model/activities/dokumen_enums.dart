enum JenisDokumen { hasilLab, SuratDokter, FotoRontgen }

extension JenisDokumenExtension on JenisDokumen {
  String get value {
    switch (this) {
      case JenisDokumen.hasilLab:
        return 'Hasil Lab';
      case JenisDokumen.SuratDokter:
        return 'Surat Dokter';
      case JenisDokumen.FotoRontgen:
        return 'Foto Rontgen';
    }
  }

  static JenisDokumen fromString(String? value) {
    switch (value) {
      case 'Hasil Lab':
        return JenisDokumen.hasilLab;
      case 'Surat Dokter':
        return JenisDokumen.SuratDokter;
      case 'Foto Rontgen':
        return JenisDokumen.FotoRontgen;
      default:
        return JenisDokumen.hasilLab;
    }
  }
}
