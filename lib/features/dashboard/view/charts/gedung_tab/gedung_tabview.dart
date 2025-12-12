import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/dashboard/view/charts/gedung_tab/dormbarchart_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GedungTabview extends ConsumerWidget {
  const GedungTabview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO : fetch real data with ref keyword
    List<double>? data;

    // TODO : is this match with best practice ?
    final safeData = data ?? List.filled(2, 0);

    return Card(
      child: SizedBox(
        height: 300,
        child: Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.m),
          child: DormBarChartComponent(
            interval: 5,
            autoScale: true,
            dataList: [
              BarData(color: Colors.blue, label: 'Umayyah', value: safeData[0]),
              BarData(
                color: Colors.teal,
                label: 'Abbasiyyah',
                value: safeData[1],
              ),
            ],
            title: 'Persebaran berdasarkan Asrama',
          ),
        ),
      ),
    );
  }
}
