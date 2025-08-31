import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/features/dashboard/view/charts/gedung_tab/gedung_tabview.dart';
import 'package:afiyyah_connect/features/dashboard/view/charts/ikhtisar_tab/ikhtisar_tabview.dart';
import 'package:afiyyah_connect/features/dashboard/view/charts/kelas_tab/kelas_tabview.dart';
import 'package:afiyyah_connect/features/dashboard/view/charts/penyakit_tab/penyakit_tabview.dart';
import 'package:afiyyah_connect/features/dashboard/constants/dashboard_strings.dart';
import 'package:flutter/material.dart';

class ChartsSection extends StatefulWidget {
  final List<double> kasusPerHari;
  final List<double> kasusPerJenjang;
  final List<double> kasusPerAsrama;
  final Map<String, int> pieJenisPenyakit;
  final List<Santri> rujukanHariIni;
  final List<Santri> sakitHariIni;

  const ChartsSection({
    required this.kasusPerHari,
    required this.kasusPerJenjang,
    required this.kasusPerAsrama,
    required this.pieJenisPenyakit,
    required this.rujukanHariIni,
    required this.sakitHariIni,
    super.key,
  });

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
          height: 300, // Adjust height as needed
          child: TabBarView(
            controller: _tabController,
            children: [
              IkhtisarTabview(data: widget.kasusPerHari),
              KelasTabview(data: widget.kasusPerJenjang),
              GedungTabview(data: widget.kasusPerAsrama),
              PenyakitTabview(data: widget.pieJenisPenyakit),
            ],
          ),
        ),
      ],
    );
  }
}
