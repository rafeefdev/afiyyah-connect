enum JenisDokumen { hasilLab, suratDokter, fotoRontgen }

extension JenisDokumenExtension on JenisDokumen {
  String get value {
    switch (this) {
      case JenisDokumen.hasilLab:
        return 'Hasil Lab';
      case JenisDokumen.suratDokter:
        return 'Surat Dokter';
      case JenisDokumen.fotoRontgen:
        return 'Foto Rontgen';
    }
  }

  static JenisDokumen fromString(String? value) {
    switch (value) {
      case 'Hasil Lab':
        return JenisDokumen.hasilLab;
      case 'Surat Dokter':
        return JenisDokumen.suratDokter;
      case 'Foto Rontgen':
        return JenisDokumen.fotoRontgen;
      default:
        return JenisDokumen.hasilLab;
    }
  }
}
