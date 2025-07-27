import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/widgets/adaptive_horizontal_barchart.dart';
import 'package:flutter/material.dart';

class KelasTabview extends StatelessWidget {
  const KelasTabview({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for sick students per class
    final List<BarData> classSicknessData = [
      const BarData(label: 'Kelas 7', value: 15, color: Colors.blue),
      const BarData(label: 'Kelas 8', value: 25, color: Colors.green),
      const BarData(label: 'Kelas 9', value: 10, color: Colors.orange),
      const BarData(label: 'Kelas 10', value: 18, color: Colors.purple),
      const BarData(label: 'Kelas 11', value: 5, color: Colors.red),
      const BarData(label: 'Kelas 12', value: 8, color: Colors.teal),
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
