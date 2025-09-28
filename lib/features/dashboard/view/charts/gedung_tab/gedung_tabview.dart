import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/dashboard/view/charts/gedung_tab/dormbarchart_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GedungTabview extends ConsumerWidget {
  const GedungTabview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO : fetch real data with ref keyword
    final List<double> data = [];
    return Card(
      child: SizedBox(
        height: 300,
        child: Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.m),
          child: DormBarChartComponent(
            interval: 5,
            autoScale: true,
            dataList: [
              BarData(color: Colors.blue, label: 'Umayyah', value: data[0]),
              BarData(color: Colors.teal, label: 'Abbasiyyah', value: data[1]),
            ],
            title: 'Persebaran berdasarkan Asrama',
          ),
        ),
      ),
    );
  }
}
