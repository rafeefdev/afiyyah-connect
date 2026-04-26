enum SumberDana { sekolah, pengantar, hybrid }

extension SumberDanaExtension on SumberDana {
  String get value {
    switch (this) {
      case SumberDana.sekolah:
        return 'sekolah';
      case SumberDana.pengantar:
        return 'pengantar';
      case SumberDana.hybrid:
        return 'hybrid';
    }
  }

  static SumberDana fromString(String? value) {
    switch (value) {
      case 'sekolah':
        return SumberDana.sekolah;
      case 'pengantar':
        return SumberDana.pengantar;
      case 'hybrid':
        return SumberDana.hybrid;
      default:
        return SumberDana.sekolah;
    }
  }
}
