enum PeriksaKlinikStatus { belum, sudah, luar, none }

extension PeriksaKlinikStatusExtension on PeriksaKlinikStatus {
  String get value {
    switch (this) {
      case PeriksaKlinikStatus.belum:
        return 'belum';
      case PeriksaKlinikStatus.sudah:
        return 'sudah';
      case PeriksaKlinikStatus.luar:
        return 'di luar';
      case PeriksaKlinikStatus.none:
        return '';
    }
  }

  static PeriksaKlinikStatus fromString(String? value) {
    switch (value) {
      case 'belum':
        return PeriksaKlinikStatus.belum;
      case 'sudah':
        return PeriksaKlinikStatus.sudah;
      case 'di luar':
        return PeriksaKlinikStatus.luar;
      default:
        return PeriksaKlinikStatus.none;
    }
  }
}
