import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/dashboard/charts/diseasedistributionchart_component.dart';
import 'package:afiyyah_connect/features/dashboard/charts/dormbarchart_component.dart';
import 'package:afiyyah_connect/features/dashboard/charts/timeserieschart_component.dart';
import 'package:flutter/material.dart';

class TabViewCharts extends StatefulWidget {
  const TabViewCharts({super.key});

  @override
  State<TabViewCharts> createState() => TabViewChartsState();
}

class TabViewChartsState extends State<TabViewCharts>
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
    return Column(
      children: [
        TabBar.secondary(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Ikhtisar'),
            Tab(text: 'Kelas'),
            Tab(text: 'Gedung'),
            Tab(text: 'Penyakit'),
          ],
        ),
        SizedBox(
          height: 300, // Adjust height as needed
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
      ],
    );
  }

  Widget _buildPenyakitTab() {
    return Padding(
      padding: EdgeInsets.only(top: AppSpacing.m),
      child: Card(
        child: DiseaseDistributionChart(
          title: 'Persebaran Penyakit',
          diseaseData: DiseaseChartFactory.createSampleData(),
          height: 300,
        ),
      ),
    );
  }

  Widget _buildGedungTab() {
    return Card(
      child: SizedBox(
        height: 300,
        child: Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.m),
          child: Align(
            alignment: Alignment.center,
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
      ),
    );
  }

  Widget _buildKelasTab() {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: AppSpacing.m),
        child: Center(child: Text('Disease Distribution on Clases')),
      ),
    );
  }

  Widget _buildIkhtisharTab() {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: 0),
        child: SizedBox(
          height: 300,
          child: Timeserieschart(
            healthScores: const [2, 4, 8, 20, 17],
            title: 'Tren Mingguan',
            dotRadius: 3,
            showHighestPointIndicator: false,
          ),
        ),
      ),
    );
  }
}
