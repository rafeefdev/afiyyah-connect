import 'package:afiyyah_connect/features/dashboard/view/charts/ikhtisar_tab/timeserieschart_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IkhtisarTabview extends ConsumerWidget {
  const IkhtisarTabview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO : fetch real data with ref keyword
    final List<double> data = [];
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
