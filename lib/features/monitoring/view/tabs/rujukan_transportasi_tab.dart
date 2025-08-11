
import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:afiyyah_connect/features/monitoring/view/tablegend_component.dart';
import 'package:flutter/material.dart';

class RujukanNTransportasiTab extends StatelessWidget {
  const RujukanNTransportasiTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colors = [Colors.orange, Colors.blue];
    return ListView(
      children: [
        tabLegend(
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
