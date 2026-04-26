enum JenisKepemilikan { pribadi, sekolah }

extension JenisKepemilikanExtension on JenisKepemilikan {
  String get value {
    switch (this) {
      case JenisKepemilikan.pribadi:
        return 'pribadi';
      case JenisKepemilikan.sekolah:
        return 'sekolah';
    }
  }

  static JenisKepemilikan fromString(String? value) {
    switch (value) {
      case 'pribadi':
        return JenisKepemilikan.pribadi;
      case 'sekolah':
        return JenisKepemilikan.sekolah;
      default:
        return JenisKepemilikan.pribadi;
    }
  }
}
