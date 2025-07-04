import 'package:afiyyah_connect/features/dashboard/diseasedistributionchart_component.dart';
import 'package:afiyyah_connect/features/dashboard/dormbarchart_component.dart';
import 'package:afiyyah_connect/features/dashboard/horizontalstatcard_component.dart';
import 'package:afiyyah_connect/features/dashboard/timeserieschart_component.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class DashboardPage extends StatefulWidget {
  final String role;
  const DashboardPage({required this.role, super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.typography;

    return FScaffold(
      header: FHeader(title: const Text('Beranda')),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              DateTime.now().toString(),
              style: textTheme.base.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            FAlert(
              title: const Text('Rujukan Rumah Sakit'),
              subtitle: const Text('2 Santri butuh penangangan rumah sakit'),
              icon: Icon(FIcons.badgeAlert),
              style: FAlertStyle.destructive,
            ),
            SizedBox(height: 16),
            _buildInsightsCard(textTheme),
            const SizedBox(height: 16),
            FTabs(
              children: [
                _buildIkhtisharTab(),
                _buildKelasTab(),
                // FTabEntry(
                //   label: const Text('Gedung'),
                //   child: FCard(child: Text('gedung')),
                // ),
                _buildGedungTab(),
                _buildPenyakitTab(),
              ],
            ),
            SizedBox(height: 240),
          ],
        ),
      ),
    );
  }

  FTabEntry _buildPenyakitTab() {
    return FTabEntry(
      label: const Text('Penyakit'),
      child: FCard(
        child: DiseaseDistributionChart(
          title: 'Persebaran Penyakit',
          diseaseData: DiseaseChartFactory.createSampleData(),
          height: 320,
        ),
      ),
    );
  }

  FTabEntry _buildGedungTab() {
    return FTabEntry(
      label: const Text('Gedung'),
      child: FCard(
        child: SizedBox(
          height: 320,
          child: DormBarChartComponent(
            interval: 5,
            autoScale: true,
            dataList: [
              BarData(color: Colors.blue, label: 'Umayyah', value: 20),
              BarData(color: Colors.teal, label: 'Abbasiyyah', value: 12),
            ],
            title: 'Persebaran berdasarkan Asrama',
          ),
        ),
      ),
    );
  }

  FTabEntry _buildKelasTab() {
    return FTabEntry(
      label: const Text('Kelas'),
      child: FCard(child: const Text('Disease Distribution on Clases')),
    );
  }

  FTabEntry _buildIkhtisharTab() {
    return FTabEntry(
      label: const Text('Ikhtisar'),
      child: FCard(
        child: SizedBox(
          height: 320,
          child: Timeserieschart(
            healthScores: [12, 23, 3, 21],
            title: 'Tren Mingguan',
          ),
        ),
      ),
    );
  }
}

Widget _buildInsightsCard(FTypography textTheme) {
  return Column(
    children: [
      Row(
        spacing: 8,
        children: [
          insightCard(
            textTheme,
            title: 'Total Sakit',
            value: '78',
            explanation: '+12% dari pekan lalu',
          ),
          insightCard(
            textTheme,
            title: 'Kasus Terbanyak',
            value: 'Flu',
            explanation: '35 siswa terdampak',
          ),
        ],
      ),
      SizedBox(height: 8),
      Row(
        spacing: 8,
        children: [
          insightCard(
            textTheme,
            title: 'Butuh Istirahat Maskan',
            value: '23',
            explanation: 'Disetujui : 18\nPending : 5',
          ),
          insightCard(
            textTheme,
            title: 'Kasus Hari Ini',
            value: '12',
            explanation: '6 Kasus flu, 4 demam, 2 lainnya',
          ),
        ],
      ),
    ],
  );
}

Widget insightCard(
  FTypography textTheme, {
  required String title,
  required String value,
  required String explanation,
}) {
  return Expanded(
    child: SizedBox(
      height: 144,
      child: FCard(
        title: Text(title),
        subtitle: Text(value),
        style: FCardStyle(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.065),
            borderRadius: BorderRadius.circular(10),
          ),
          contentStyle: FCardContentStyle(
            titleTextStyle: textTheme.base.copyWith(
              fontWeight: FontWeight.w300,
            ),
            subtitleTextStyle: textTheme.xl2.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double fontSize = 12;
            if (constraints.maxWidth < 150) {
              fontSize = 10;
            } else if (constraints.maxWidth < 100) {
              fontSize = 8;
            }
            return Text(
              explanation,
              style: context.theme.typography.sm,
              overflow: TextOverflow.visible,
            );
          },
        ),
      ),
    ),
  );
}
