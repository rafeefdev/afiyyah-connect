import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/widgets/adaptive_horizontal_barchart.dart';
import 'package:flutter/material.dart';

class KelasTabview extends StatelessWidget {
  final List<double> data;

  const KelasTabview({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for sick students per class
    final List<BarData> classSicknessData = [
      BarData(label: 'Kelas 7', value: data[0], color: Colors.blue),
      BarData(label: 'Kelas 8', value: data[1], color: Colors.green),
      BarData(label: 'Kelas 9', value: data[2], color: Colors.orange),
      BarData(label: 'Kelas 10', value: data[3], color: Colors.purple),
      BarData(label: 'Kelas 11', value: data[4], color: Colors.red),
      BarData(label: 'Kelas 12', value: data[5], color: Colors.teal),
    ];

    return Card(
      child: SizedBox(
        height: 300,
        child: Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.m),
          child: AdaptiveHorizontalBarChart(
            title: 'Sebaran Santri Sakit per Kelas',
            dataList: classSicknessData,
            totalUnitLabel: 'Siswa',
            customChartAspectRatio: 2,
            rodWidth: 8,
            showLegend: false,
            interval: 5,
          ),
        ),
      ),
    );
  }
}
