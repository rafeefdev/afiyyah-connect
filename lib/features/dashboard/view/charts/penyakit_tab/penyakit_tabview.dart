import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/dashboard/view/charts/penyakit_tab/diseasedistributionchart_component.dart';
import 'package:flutter/material.dart';

class PenyakitTabview extends StatelessWidget {
  const PenyakitTabview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.only(top: AppSpacing.m),
    child: Card(
      child: DiseaseDistributionChart(
        title: 'Persebaran Penyakit',
        diseaseData: DiseaseChartFactory.createSampleData(),
        height: 300,
      ),
    ),
  );
  }
}