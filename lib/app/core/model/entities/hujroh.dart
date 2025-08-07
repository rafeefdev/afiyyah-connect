enum Gedung { umayyah, abbasiyyah }

class Hujroh {
  final String id;
  final String nama;
  final String waliKamarId;
  final Gedung gedung;
  final bool isActive;

  Hujroh({
    required this.id,
    required this.nama,
    required this.gedung,
    required this.waliKamarId,
    required this.isActive,
  });
}
