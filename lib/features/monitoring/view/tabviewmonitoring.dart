import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:flutter/material.dart';

class TabViewMonitoring extends StatelessWidget {
  const TabViewMonitoring({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        _buildKunjunganKlinikTab(),
        _buildStatusArahanTab(),
        _buildRujukanNTransportasiTab(),
      ],
    );
  }

  Widget _buildStatusArahanTab() {
    return Padding(
      padding: EdgeInsets.only(top: AppSpacing.m),
      child: const Card(
        child: Center(child: Text('Disease Distribution on Clases')),
      ),
    );
  }

  Widget _buildKunjunganKlinikTab() {
    return Padding(
      padding: EdgeInsets.only(top: AppSpacing.m),
      child: const Card(
        child: Center(child: Text('Disease Distribution on Clases')),
      ),
    );
  }

  Widget _buildRujukanNTransportasiTab() {
    return Padding(
      padding: EdgeInsets.only(top: AppSpacing.m),
      child: const Card(
        child: Center(child: Text('Disease Distribution on Clases')),
      ),
    );
  }
}
