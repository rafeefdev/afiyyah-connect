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

  Widget _buildLegend(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...List.generate(3, (index) {
          List<MaterialColor> colors = [
            Colors.green,
            Colors.orange,
            Colors.red,
          ];
          List<String> desc = [
            'Lanjut\nKegiatan',
            'Istirahat\nMaskan',
            'Rujuk\nKeluar',
          ];
          return Row(
            spacing: 8,
            children: [
              Container(height: 18, width: 18, color: colors[index]),
              Text(desc[index], style: context.textTheme.labelSmall),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildPeriksaTab(BuildContext context) {
    List<MaterialColor> colors = [Colors.orange, Colors.blue];
    List<String> desc = ['Belum\nPeriksa', 'Sudah\nPeriksa'];
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...List.generate(2, (index) {
              return Row(
                spacing: 8,
                children: [
                  Container(height: 18, width: 18, color: colors[index]),
                  Text(desc[index], style: context.textTheme.labelSmall),
                ],
              );
            }),
          ],
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
    List<String> desc = ['Lanjut\nKegiatan', 'Istirahat\nMaskan', 'Rujuk\nRS'];
    return ListView(
      children: [
        _buildLegend(context),
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
    List<String> desc = ['Perlu\nDiantar', 'Sudah\nDiantar'];
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...List.generate(2, (index) {
              return Row(
                spacing: 8,
                children: [
                  Container(height: 18, width: 18, color: colors[index]),
                  Text(desc[index], style: context.textTheme.labelSmall),
                ],
              );
            }),
          ],
        ),
        const SizedBox(height: 12),
        //TODO : fetch to real data
        ...List.generate(3, (index) {
          return ListCardItem(
            santri: Santri.generateDummyData(),
            info: 'Batuk, pilek, panas',
            customNotchColor: index < 2 ? colors[0] : colors[1],
          );
        }),
      ],
    );
  }
}
