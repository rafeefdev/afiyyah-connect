enum StatusRujukan { menunggu, terjadwal, selesai, dibatalkan }

extension StatusRujukanExtension on StatusRujukan {
  String get value {
    switch (this) {
      case StatusRujukan.menunggu:
        return 'menunggu';
      case StatusRujukan.terjadwal:
        return 'terjadwal';
      case StatusRujukan.selesai:
        return 'selesai';
      case StatusRujukan.dibatalkan:
        return 'dibatalkan';
    }
  }

  static StatusRujukan fromString(String? value) {
    switch (value) {
      case 'menunggu':
        return StatusRujukan.menunggu;
      case 'terjadwal':
        return StatusRujukan.terjadwal;
      case 'selesai':
        return StatusRujukan.selesai;
      case 'dibatalkan':
        return StatusRujukan.dibatalkan;
      default:
        return StatusRujukan.menunggu;
    }
  }
}
