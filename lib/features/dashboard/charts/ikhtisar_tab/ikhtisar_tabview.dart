import 'package:afiyyah_connect/features/dashboard/charts/ikhtisar_tab/timeserieschart_component.dart';
import 'package:flutter/material.dart';

class IkhtisarTabview extends StatelessWidget {
  const IkhtisarTabview({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 300,
        child: Timeserieschart(
          healthScores: const [2, 4, 8, 20, 17],
          title: 'Tren Mingguan',
          dotRadius: 3,
          showHighestPointIndicator: false,
        ),
      ),
    );
  }
}
