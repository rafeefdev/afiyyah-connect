enum JenisKwitansi { rs, Laboratorium, Transportasi }

extension JenisKwitansiExtension on JenisKwitansi {
  String get value {
    switch (this) {
      case JenisKwitansi.rs:
        return 'RS';
      case JenisKwitansi.Laboratorium:
        return 'Laboratorium';
      case JenisKwitansi.Transportasi:
        return 'Transportasi';
    }
  }

  static JenisKwitansi fromString(String? value) {
    switch (value) {
      case 'RS':
        return JenisKwitansi.rs;
      case 'Laboratorium':
        return JenisKwitansi.Laboratorium;
      case 'Transportasi':
        return JenisKwitansi.Transportasi;
      default:
        return JenisKwitansi.rs;
    }
  }
}
