import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:flutter/material.dart';

class TabViewMonitoring extends StatefulWidget {
  const TabViewMonitoring({super.key});

  @override
  State<TabViewMonitoring> createState() => TabViewMonitoringState();
}

class TabViewMonitoringState extends State<TabViewMonitoring>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Kunjungan Klinik'),
            Tab(text: 'Status Arahan'),
            Tab(text: 'Rujukan Luar'),
          ],
        ),
        IntrinsicHeight(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildKunjunganKlinikTab(),
              _buildStatusArahanTab(),
              _buildRujukanNTransportasiTab(),
            ],
          ),
        ),
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
