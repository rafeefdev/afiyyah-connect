import 'package:afiyyah_connect/features/dashboard/view/charts/ikhtisar_tab/timeserieschart_component.dart';
import 'package:flutter/material.dart';

class IkhtisarTabview extends StatelessWidget {
  final List<double> data;

  const IkhtisarTabview({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 300,
        child: Timeserieschart(
          healthScores: data,
          title: 'Tren Mingguan',
          dotRadius: 3,
          showHighestPointIndicator: false,
        ),
      ),
    );
  }
}
