import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/dashboard/view/charts/gedung_tab/dormbarchart_component.dart';
import 'package:flutter/material.dart';

class GedungTabview extends StatelessWidget {
  final List<double> data;

  const GedungTabview({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
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
