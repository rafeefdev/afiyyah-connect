enum SumberKunjungan { dariAsrama, Mandiri }

extension SumberKunjunganExtension on SumberKunjungan {
  String get value {
    switch (this) {
      case SumberKunjungan.dariAsrama:
        return 'dari_asrama';
      case SumberKunjungan.Mandiri:
        return 'mandiri';
    }
  }

  static SumberKunjungan fromString(String? value) {
    switch (value) {
      case 'dari_asrama':
        return SumberKunjungan.dariAsrama;
      case 'mandiri':
        return SumberKunjungan.Mandiri;
      default:
        return SumberKunjungan.Mandiri;
    }
  }
}

enum StatusPengarahan { masukSekolah, istirahatAsrama }

extension StatusPengarahanExtension on StatusPengarahan {
  String get value {
    switch (this) {
      case StatusPengarahan.masukSekolah:
        return 'masuk_sekolah';
      case StatusPengarahan.istirahatAsrama:
        return 'istirahat_asrama';
    }
  }

  static StatusPengarahan fromString(String? value) {
    switch (value) {
      case 'masuk_sekolah':
        return StatusPengarahan.masukSekolah;
      case 'istirahat_asrama':
        return StatusPengarahan.istirahatAsrama;
      default:
        return StatusPengarahan.masukSekolah;
    }
  }
}
