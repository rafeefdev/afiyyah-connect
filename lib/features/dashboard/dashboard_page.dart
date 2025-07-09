import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extensions.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:afiyyah_connect/features/dashboard/alertcardinfo_component.dart';
import 'package:afiyyah_connect/features/health_input/view/bottomsheet_navigator.dart';
import 'package:afiyyah_connect/features/dashboard/diseasedistributionchart_component.dart';
import 'package:afiyyah_connect/features/dashboard/dormbarchart_component.dart';
import 'package:afiyyah_connect/features/dashboard/horizontalstatcard_component.dart';
import 'package:afiyyah_connect/features/dashboard/insight_card.dart';
import 'package:afiyyah_connect/features/dashboard/timeserieschart_component.dart';
import 'package:afiyyah_connect/features/health_input/view/confirmationcard_component.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  Santri johnDoe = Santri(
    hujrohId: '',
    id: 'as',
    kelasId: '',
    name: 'John Doe',
    tahunMasuk: DateTime(2020),
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateInfo(textTheme),
            const SizedBox(height: 16),
            alertCard(
              context,
              title: 'Rujukan Rumah Sakit',
              alertMessage: '2 santri butuh penanganan rumah sakit',
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
            SizedBox(height: AppSpacing.l),
            _buildRujukanRumahSakit(context),
            SizedBox(height: AppSpacing.l),
            _buildSantriSakitHariIni(context),
            const SizedBox(height: 240),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Input Data'),
        icon: const Icon(Icons.assignment_add),
        onPressed: () {
          _buildShowHealthInput(context);
        },
      ),
    );
  }

  Widget _buildRujukanRumahSakit(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rujukan Rumah Sakit', style: context.textTheme.titleMedium),
        SizedBox(height: AppSpacing.s),
        // TODO : generate rujukan rumah sakit list
        listCardItem(context, santri: johnDoe),
      ],
    );
  }

  Widget _buildSantriSakitHariIni(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Santri Sakit Hari Ini', style: context.textTheme.titleMedium),
        SizedBox(height: AppSpacing.s),
        // TODO : generate rujukan rumah sakit list
        listCardItem(context, santri: johnDoe),
      ],
    );
  }

  Future<dynamic> _buildShowHealthInput(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      requestFocus: true,
      useSafeArea: true,
      builder: (context) {
        return BottomSheetNavigator();
      },
    );
  }

  Widget _buildDateInfo(TextTheme textTheme, {DateTime? date}) {
    final now = date ?? DateTime.now();
    final formatter = DateFormat(
      'EEEE, d MMMM y • HH:mm',
    ); // contoh: Minggu, 6 Juli 2025 • 14:45
    final formatted = formatter.format(now);

    return Text(
      formatted,
      style: textTheme.bodySmall?.copyWith(color: Colors.grey),
    );
  }

  Widget _buildPenyakitTab() {
    return Padding(
      padding: EdgeInsets.only(top: AppSpacing.m),
      child: Card(
        child: DiseaseDistributionChart(
          title: 'Persebaran Penyakit',
          diseaseData: DiseaseChartFactory.createSampleData(),
          height: 320,
        ),
      ),
    );
  }

  Widget _buildGedungTab() {
    return Padding(
      padding: EdgeInsets.only(top: AppSpacing.m),
      child: Card(
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

  Widget _buildKelasTab() {
    return Padding(
      padding: EdgeInsets.only(top: AppSpacing.m),
      child: const Card(
        child: Center(child: Text('Disease Distribution on Clases')),
      ),
    );
  }

  Widget _buildIkhtisharTab() {
    return Padding(
      padding: EdgeInsets.only(top: AppSpacing.m),
      child: Card(
        child: SizedBox(
          height: 320,
          child: Timeserieschart(
            healthScores: const [12, 23, 3, 21],
            title: 'Tren Mingguan',
          ),
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
