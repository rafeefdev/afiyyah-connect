import 'package:afiyyah_connect/features/dashboard/diseasedistributionchart_component.dart';
import 'package:afiyyah_connect/features/dashboard/dormbarchart_component.dart';
import 'package:afiyyah_connect/features/dashboard/horizontalstatcard_component.dart';
import 'package:afiyyah_connect/features/dashboard/timeserieschart_component.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  final String role;
  const DashboardPage({required this.role, super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              DateTime.now().toString(),
              style: textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.red[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.red[700]),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rujukan Rumah Sakit',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('2 Santri butuh penangangan rumah sakit'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildInsightsCard(context),
            const SizedBox(height: 16),
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Ikhtisar'),
                Tab(text: 'Kelas'),
                Tab(text: 'Gedung'),
                Tab(text: 'Penyakit'),
              ],
            ),
            SizedBox(
              height: 350, // Adjust height as needed
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildIkhtisharTab(),
                  _buildKelasTab(),
                  _buildGedungTab(),
                  _buildPenyakitTab(),
                ],
              ),
            ),
            const SizedBox(height: 240),
          ],
        ),
      ),
    );
  }

  Widget _buildPenyakitTab() {
    return Card(
      child: DiseaseDistributionChart(
        title: 'Persebaran Penyakit',
        diseaseData: DiseaseChartFactory.createSampleData(),
        height: 320,
      ),
    );
  }

  Widget _buildGedungTab() {
    return Card(
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
    );
  }

  Widget _buildKelasTab() {
    return const Card(child: Center(child: Text('Disease Distribution on Clases')));
  }

  Widget _buildIkhtisharTab() {
    return Card(
      child: SizedBox(
        height: 320,
        child: Timeserieschart(
          healthScores: const [12, 23, 3, 21],
          title: 'Tren Mingguan',
        ),
      ),
    );
  }
}

Widget _buildInsightsCard(BuildContext context) {
  return Column(
    children: [
      Row(
        children: [
          insightCard(
            context,
            title: 'Total Sakit',
            value: '78',
            explanation: '+12% dari pekan lalu',
          ),
          const SizedBox(width: 8),
          insightCard(
            context,
            title: 'Kasus Terbanyak',
            value: 'Flu',
            explanation: '35 siswa terdampak',
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          insightCard(
            context,
            title: 'Butuh Istirahat Maskan',
            value: '23',
            explanation: 'Disetujui : 18\nPending : 5',
          ),
          const SizedBox(width: 8),
          insightCard(
            context,
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
  BuildContext context, {
  required String title,
  required String value,
  required String explanation,
}) {
  final textTheme = Theme.of(context).textTheme;
  return Expanded(
    child: SizedBox(
      height: 144,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey[300]!, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.titleSmall),
              const SizedBox(height: 4),
              Text(value, style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(
                explanation,
                style: textTheme.bodySmall,
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
