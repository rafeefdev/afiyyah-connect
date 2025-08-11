
import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:afiyyah_connect/features/monitoring/view/tablegend_component.dart';
import 'package:flutter/material.dart';

class ArahanTab extends StatelessWidget {
  const ArahanTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colors = [Colors.green, Colors.orange, Colors.red];
    return ListView(
      children: [
        tabLegend(
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
}
