import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/dashboard/view/charts/penyakit_tab/diseasedistributionchart_component.dart';
import 'package:flutter/material.dart';

class PenyakitTabview extends StatelessWidget {
  final Map<String, int> data;

  const PenyakitTabview({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    List<DiseaseData> diseaseDatas(Map<String, int> dataSource) {
      List<String> keys = dataSource.keys.toList();
      List<int> values = dataSource.values.toList();
      List<Color> diseaseColors = Colors.primaries;
      List<DiseaseData> result = [];
      for (var i = 0; i < values.length || i < keys.length; i++) {
        result.add(
          DiseaseData(name: keys[i], count: values[i], color: diseaseColors[i]),
        );
      }
      return result;
    }

    return Padding(
      padding: EdgeInsets.only(top: AppSpacing.m),
      child: Card(
        child: DiseaseDistributionChart(
          title: 'Persebaran Penyakit',
          diseaseData: diseaseDatas(data),
          height: 300,
        ),
      ),
    );
  }
}
