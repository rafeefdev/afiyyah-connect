enum JenisKwitansi { rs, labor, transportasi }

extension JenisKwitansiExtension on JenisKwitansi {
  String get value {
    switch (this) {
      case JenisKwitansi.rs:
        return 'RS';
      case JenisKwitansi.labor:
        return 'Laboratorium';
      case JenisKwitansi.transportasi:
        return 'Transportasi';
    }
  }

  static JenisKwitansi fromString(String? value) {
    switch (value) {
      case 'RS':
        return JenisKwitansi.rs;
      case 'Laboratorium':
        return JenisKwitansi.labor;
      case 'Transportasi':
        return JenisKwitansi.transportasi;
      default:
        return JenisKwitansi.rs;
    }
  }
}
