import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/features/common/widgets/displayzerodata_component.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:afiyyah_connect/features/monitoring/view/tablegend_component.dart';
import 'package:flutter/material.dart';

class RujukanNTransportasiTab extends StatelessWidget {
  const RujukanNTransportasiTab({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO : fetch to real data
    List<Santri> data = List.filled(0, Santri.generateDummyData());
    List<MaterialColor> colors = [Colors.orange, Colors.blue];

    return ListView(
      children: [
        tabLegend(
          context,
          indicatorColors: colors,
          labels: ['Perlu\nDiantar', 'Sudah\nDiantar'],
        ),
        const SizedBox(height: 12),
        data.isEmpty
            ? DisplayZeroData(
                height: 480,
                icon: Icons.check_circle_outline_rounded,
                message: 'Tidak ada santri yang dirujuk',
              )
            :
              //TODO : fetch to real data
              Column(
                children: List.generate(10, (index) {
                  return ListCardItem(
                    santri: Santri.generateDummyData(),
                    customNotchColor: index < 2 ? colors[0] : colors[1],
                    info: 'Batuk, pilek, panas',
                  );
                }),
              ),
      ],
    );
  }
}
