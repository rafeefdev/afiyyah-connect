enum SumberDana { sekolah, Pengantar, hybrid }

extension SumberDanaExtension on SumberDana {
  String get value {
    switch (this) {
      case SumberDana.sekolah:
        return 'sekolah';
      case SumberDana.Pengantar:
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
        return SumberDana.Pengantar;
      case 'hybrid':
        return SumberDana.hybrid;
      default:
        return SumberDana.sekolah;
    }
  }
}
