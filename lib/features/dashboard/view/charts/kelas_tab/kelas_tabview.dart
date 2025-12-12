import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/widgets/adaptive_horizontal_barchart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KelasTabview extends ConsumerWidget {
  const KelasTabview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO : fetch data with ref keyword
    List<double>? data;
    final safeData = data ?? List.filled(6, 0);

    // Dummy data for sick students per class
    final List<BarData> classSicknessData = [
      BarData(label: 'Kelas 7', value: safeData[0], color: Colors.blue),
      BarData(label: 'Kelas 8', value: safeData[1], color: Colors.green),
      BarData(label: 'Kelas 9', value: safeData[2], color: Colors.orange),
      BarData(label: 'Kelas 10', value: safeData[3], color: Colors.purple),
      BarData(label: 'Kelas 11', value: safeData[4], color: Colors.red),
      BarData(label: 'Kelas 12', value: safeData[5], color: Colors.teal),
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
