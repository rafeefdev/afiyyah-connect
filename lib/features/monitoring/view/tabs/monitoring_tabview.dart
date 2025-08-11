import 'package:afiyyah_connect/features/monitoring/view/tabs/arahan_tab.dart';
import 'package:afiyyah_connect/features/monitoring/view/tabs/periksa_tab.dart';
import 'package:afiyyah_connect/features/monitoring/view/tabs/rujukan_transportasi_tab.dart';
import 'package:flutter/material.dart';

class TabViewMonitoring extends StatelessWidget {
  const TabViewMonitoring({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: const [PeriksaTab(), ArahanTab(), RujukanNTransportasiTab()],
    );
  }
}
