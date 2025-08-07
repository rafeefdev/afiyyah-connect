
class IstirahatDiRumah {
  final String id;
  final DateTime timeStamp;
  final String diagnosaId;
  final DateTime tanggalMulai;
  final DateTime tanggalSelesai;
  final String keterangan;

  IstirahatDiRumah({
    required this.id,
    required this.timeStamp,
    required this.diagnosaId,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.keterangan,
  });
}
