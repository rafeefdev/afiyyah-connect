import 'package:afiyyah_connect/app/core/model/entities/santri.dart';

class DashboardData {
  final int totalSakitPekanIni;
  final double persentasePerbandinganPekanLalu;
  final String kasusTerbanyak;
  final int jumlahKasusTerbanyak;
  final int siswaIstirahat;
  final Map<String, int> kasusBaruHariIni; // flu: 3, batuk: 4, dll
  final List<int> kasusPerHari; // [3, 4, 5, 2, 7, 1, 3]
  final Map<String, List<int>> kasusPerJenjang; // "kelas 7": [1,2,1,3,0,0,1]
  final Map<String, List<int>> kasusPerAsrama; // "utara": [...], "selatan": [...]
  final Map<String, int> pieJenisPenyakit; // flu: 10, batuk: 5
  final List<Santri> rujukanHariIni;
  final List<Santri> sakitHariIni;

  DashboardData({
    required this.totalSakitPekanIni,
    required this.persentasePerbandinganPekanLalu,
    required this.kasusTerbanyak,
    required this.jumlahKasusTerbanyak,
    required this.siswaIstirahat,
    required this.kasusBaruHariIni,
    required this.kasusPerHari,
    required this.kasusPerJenjang,
    required this.kasusPerAsrama,
    required this.pieJenisPenyakit,
    required this.rujukanHariIni,
    required this.sakitHariIni,
  });
}
