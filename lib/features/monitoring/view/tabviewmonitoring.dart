import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:flutter/material.dart';

class TabViewMonitoring extends StatelessWidget {
  const TabViewMonitoring({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        _buildPeriksaTab(context),
        _buildArahan(context),
        _buildRujukanNTransportasiTab(context),
      ],
    );
  }

  Widget _buildLegend(
    BuildContext context, {
    required List<Color> indicatorColors,
    required List<String> labels,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...List.generate(indicatorColors.length, (index) {
          return Row(
            spacing: 8,
            children: [
              Container(height: 18, width: 18, color: indicatorColors[index]),
              Text(labels[index], style: context.textTheme.labelSmall),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildPeriksaTab(BuildContext context) {
    List<MaterialColor> colors = [Colors.orange, Colors.blue];
    return ListView(
      children: [
        _buildLegend(
          context,
          indicatorColors: colors,
          labels: ['Belum\nPeriksa', 'Sudah\nPeriksa'],
        ),
        const SizedBox(height: 12),
        //TODO : fetch to real data
        ...List.generate(10, (index) {
          return ListCardItem(
            santri: Santri.generateDummyData(),
            customNotchColor: index < 2 ? colors[0] : colors[1],
            info: 'Batuk, pilek, panas',
          );
        }),
      ],
    );
  }

  Widget _buildArahan(BuildContext context) {
    List<MaterialColor> colors = [Colors.green, Colors.orange, Colors.red];
    return ListView(
      children: [
        _buildLegend(
          context,
          indicatorColors: colors,
          labels: ['Lanjut\nKegiatan', 'Istirahat\nMaskan', 'Rujuk\nRS'],
        ),
        const SizedBox(height: 12),
        //TODO : fetch to real data
        ...List.generate(10, (index) {
          return ListCardItem(
            santri: Santri.generateDummyData(),
            info: 'Batuk, pilek, panas',
            customNotchColor: (index / 4) == 0 ? colors[0] : colors[1],
            // showNotchIndicator: index % 3 == 1,
          );
        }),
      ],
    );
  }

  Widget _buildRujukanNTransportasiTab(BuildContext context) {
    List<MaterialColor> colors = [Colors.orange, Colors.blue];
    return ListView(
      children: [
        _buildLegend(
          context,
          indicatorColors: colors,
          labels: ['Perlu\nDiantar', 'Sudah\nDiantar'],
        ),
        const SizedBox(height: 12),
        //TODO : fetch to real data
        ...List.generate(3, (index) {
          return ListCardItem(
            santri: Santri.generateDummyData(),
            additionalTiles: [
              ListTile(
                title: Text('RS / Klinik Rujukan'),
                leading: Icon(Icons.health_and_safety_rounded),
              ),
            ],
            info: 'Batuk, pilek, panas',
            customNotchColor: index < 2 ? colors[0] : colors[1],
          );
        }),
      ],
    );
  }
}
