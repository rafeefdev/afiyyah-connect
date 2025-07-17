import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/dashboard/charts/gedung_tab/gedung_tabview.dart';
import 'package:afiyyah_connect/features/dashboard/charts/ikhtisar_tab/ikhtisar_tabview.dart';
import 'package:afiyyah_connect/features/dashboard/charts/kelas_tab/kelas_tabview.dart';
import 'package:afiyyah_connect/features/dashboard/charts/penyakit_tab/diseasedistributionchart_component.dart';
import 'package:afiyyah_connect/features/dashboard/charts/gedung_tab/dormbarchart_component.dart';
import 'package:afiyyah_connect/features/dashboard/charts/ikhtisar_tab/timeserieschart_component.dart';
import 'package:afiyyah_connect/features/dashboard/charts/penyakit_tab/penyakit_tabview.dart';
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
            children: const [
              IkhtisarTabview(),
              KelasTabview(),
              GedungTabview(),
              PenyakitTabview(),
            ],
          ),
        ),
      ],
    );
  }
}
