import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
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
        _buildKunjunganKlinikTab(context),
        _buildStatusArahanTab(context),
        _buildRujukanNTransportasiTab(context),
      ],
    );
  }

  Widget _buildStatusArahanTab(BuildContext context) {
    return ListView(
      children: [
        Row(
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
        ),
        const SizedBox(height: 12),
        //TODO : fetch to real data
        ...List.generate(10, (index) {
          return NotchedListCardItem(
            santri: Santri.generateDummyData(),
            info: 'Batuk, pilek, panas',
            // showNotchIndicator: index % 3 == 1,
          );
        }),
      ],
    );
  }

  Widget _buildKunjunganKlinikTab(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...List.generate(2, (index) {
              List<MaterialColor> colors = [Colors.blue, Colors.orange];
              List<String> desc = ['Sudah\nPeriksa', 'Belum\nPeriksa'];
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
            info: 'Batuk, pilek, panas',
            showNotchIndicator: index % 3 == 1,
          );
        }),
      ],
    );
  }

  Widget _buildRujukanNTransportasiTab(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...List.generate(2, (index) {
              List<MaterialColor> colors = [Colors.blue, Colors.orange];
              List<String> desc = ['Perlu\nDiantar', 'Sudah\nDiantar'];
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
            info: 'Batuk, pilek, panas',
            showNotchIndicator: index % 3 == 1,
          );
        }),
      ],
    );
  }
}
