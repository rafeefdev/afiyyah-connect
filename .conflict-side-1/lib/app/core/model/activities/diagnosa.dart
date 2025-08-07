class Diagnosa {
  final String id;
  final DateTime timeStamp;
  final String dokterId;
  final String pendataanKesehatanId;
  final Arahan arahan;

  final String? rujukanId;
  final String? istirahatDiRumahId;

  Diagnosa({
    required this.id,
    required this.dokterId,
    required this.pendataanKesehatanId,
    required this.timeStamp,
    required this.arahan,
    this.rujukanId,
    this.istirahatDiRumahId,
  });
}

enum Arahan {
  istirahatMaskan,
  lanjutKegiatanWajib,
  rujukKeluar,
  istirahatDiRumah,
}

