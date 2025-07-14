import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/dashboard/diseasedistributionchart_component.dart';
import 'package:afiyyah_connect/features/dashboard/dormbarchart_component.dart';
import 'package:afiyyah_connect/features/dashboard/timeserieschart_component.dart';
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
    return Padding(
      padding: EdgeInsets.only(top: AppSpacing.m),
      child: Card(
        child: SizedBox(
          height: 300,
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
          height: 300,
          child: Timeserieschart(
            healthScores: const [12, 23, 3, 21],
            title: 'Tren Mingguan',
          ),
        ),
      ),
    );
  }
}
