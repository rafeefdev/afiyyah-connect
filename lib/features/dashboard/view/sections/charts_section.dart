import 'package:afiyyah_connect/features/dashboard/view/charts/gedung_tab/gedung_tabview.dart';
import 'package:afiyyah_connect/features/dashboard/view/charts/ikhtisar_tab/ikhtisar_tabview.dart';
import 'package:afiyyah_connect/features/dashboard/view/charts/kelas_tab/kelas_tabview.dart';
import 'package:afiyyah_connect/features/dashboard/view/charts/penyakit_tab/penyakit_tabview.dart';
import 'package:afiyyah_connect/features/dashboard/constants/dashboard_strings.dart';
import 'package:flutter/material.dart';

class ChartsSection extends StatefulWidget {
  const ChartsSection({super.key});

  @override
  State<ChartsSection> createState() => ChartsSectionState();
}

class ChartsSectionState extends State<ChartsSection>
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
            Tab(text: DashboardStrings.overviewTab),
            Tab(text: DashboardStrings.classTab),
            Tab(text: DashboardStrings.buildingTab),
            Tab(text: DashboardStrings.diseaseTab),
          ],
        ),
        SizedBox(
          height: 300,
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
