import 'package:afiyyah_connect/app/core/model/entities/sumber_biaya.dart';

class Pengantaran {
  final String id;
  final DateTime timeStamp;
  final String rujukanId;
  final DateTime waktuBerangkat;
  final DateTime waktuPulang;
  final SumberBiaya sumberBiaya;

  final String? fotoTagihanURL;
  final String? fotoBuktiPembayaran;

  Pengantaran({
    required this.id,
    required this.rujukanId,
    required this.waktuBerangkat,
    required this.waktuPulang,
    required this.sumberBiaya,
    this.fotoTagihanURL,
    this.fotoBuktiPembayaran
  }) : timeStamp = DateTime.timestamp();
}
