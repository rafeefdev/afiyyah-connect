import 'package:afiyyah_connect/app/core/model/entities/santri.dart';

class DashboardData {
  final int totalSakitPekanIni;
  final double persentasePerbandinganPekanLalu;

  final String kasusTerbanyak;
  final int jumlahKasusTerbanyak;

  final int butuhIstirahatMaskan;

  final Map<String, int> kasusBaruHariIni;

  //chart datas
  final List<double> kasusPerHari;
  final List<double> kasusPerJenjang;
  final List<double> kasusPerAsrama;
  final Map<String, int> pieJenisPenyakit;
  final List<Santri> rujukanHariIni;
  final List<Santri> sakitHariIni;

  DashboardData({
    required this.totalSakitPekanIni,
    required this.persentasePerbandinganPekanLalu,
    required this.kasusTerbanyak,
    required this.jumlahKasusTerbanyak,
    required this.butuhIstirahatMaskan,
    required this.kasusBaruHariIni,
    required this.kasusPerHari,
    required this.kasusPerJenjang,
    required this.kasusPerAsrama,
    required this.pieJenisPenyakit,
    required this.rujukanHariIni,
    required this.sakitHariIni,
  });

  /// Factory method untuk generate dummy data dashboard
  factory DashboardData.dummy({bool isEmptyData = false}) {
    return isEmptyData
        ? DashboardData(
            totalSakitPekanIni: 0,
            persentasePerbandinganPekanLalu:
                0, // misal naik 19.2% dari pekan lalu
            kasusTerbanyak: "Tidak ada",
            jumlahKasusTerbanyak: 0,
            butuhIstirahatMaskan: 0,
            kasusBaruHariIni: {},
            kasusPerHari: [
              0,
              0,
              0,
              0,
              0,
              0,
              0,
            ], // 7 hari terakhir (Senin - Ahad)
            kasusPerJenjang: [],
            kasusPerAsrama: [],
            pieJenisPenyakit: {},
            rujukanHariIni: [],
            sakitHariIni: [],
          )
        : DashboardData(
            totalSakitPekanIni: 25,
            persentasePerbandinganPekanLalu:
                19.2, // misal naik 19.2% dari pekan lalu
            kasusTerbanyak: "Flu",
            jumlahKasusTerbanyak: 12,
            butuhIstirahatMaskan: 9,
            kasusBaruHariIni: {"Flu": 5, "Batuk": 3, "Demam": 2, "Pusing": 1},
            kasusPerHari: [
              2,
              5,
              4,
              6,
              3,
              2,
              3,
            ], // 7 hari terakhir (Senin - Ahad)
            kasusPerJenjang: [2, 4, 4, 6, 2, 8],
            kasusPerAsrama: [24, 28],
            pieJenisPenyakit: {"Flu": 12, "Batuk": 6, "Demam": 4, "Pusing": 3},
            rujukanHariIni: [
              Santri(
                id: '1',
                nama: 'Ahmad Fauzi',
                jenjang: 8,
                tahunMasuk: 2021,
              ),
              Santri(
                id: '2',
                nama: 'Rizki Hidayat',
                jenjang: 9,
                tahunMasuk: 2020,
              ),
            ],
            sakitHariIni: [
              Santri(
                id: '3',
                nama: 'Fajar Sidik',
                jenjang: 7,
                tahunMasuk: 2022,
              ),
              Santri(
                id: '4',
                nama: 'Rafli Ananda',
                jenjang: 8,
                tahunMasuk: 2021,
              ),
              Santri(
                id: '5',
                nama: 'Ilham Ramadhan',
                jenjang: 9,
                tahunMasuk: 2020,
              ),
            ],
          );
  }
}
