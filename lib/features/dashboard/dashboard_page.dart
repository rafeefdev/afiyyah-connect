import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:afiyyah_connect/features/common/widgets/dateinfo_component.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:afiyyah_connect/features/dashboard/alertcardinfo_component.dart';
import 'package:afiyyah_connect/features/dashboard/tabview_charts.dart';
import 'package:afiyyah_connect/features/dashboard/insight_card.dart';
import 'package:afiyyah_connect/features/health_input/view/show_bottom_input.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  final String role;
  const DashboardPage({required this.role, super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: AppSpacing.pagePadding,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileBar(context, textTheme),
                SizedBox(height: AppSpacing.l),
                alertCard(
                  context,
                  title: 'Rujukan Rumah Sakit',
                  alertMessage: '2 santri butuh penanganan rumah sakit',
                ),
                SizedBox(height: AppSpacing.l),
                _buildInsightsCard(context),
                SizedBox(height: AppSpacing.l),
                const TabViewCharts(),
                SizedBox(height: AppSpacing.l),
                _buildRujukanRumahSakit(context),
                SizedBox(height: AppSpacing.l),
                _buildSantriSakitHariIni(context),
                const SizedBox(height: 240),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Input Data'),
        icon: const Icon(Icons.assignment_add),
        onPressed: () => showBottomHealthInput(context),
      ),
    );
  }

  Widget _buildProfileBar(BuildContext context, TextTheme textTheme) {
    return Row(
      spacing: AppSpacing.m,
      children: [
        CircleAvatar(child: const Text('FD')),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fulan Doe', style: context.textTheme.titleSmall),
            Text(
              'Asatidz Piket Maskan',
              style: context.textTheme.bodySmall!.copyWith(color: Colors.grey),
            ),
          ],
        ),
        Spacer(),
        DateInfo(
          textTheme: textTheme,
          customTextStyle: context.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _buildRujukanRumahSakit(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rujukan Rumah Sakit', style: context.textTheme.titleMedium),
        SizedBox(height: AppSpacing.s),
        // TODO : generate rujukan rumah sakit list
        ListCardItem(santri: Santri.generateDummyData(), info: 'Demam tinggi'),
      ],
    );
  }

  Widget _buildSantriSakitHariIni(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Santri Sakit Hari Ini', style: context.textTheme.titleMedium),
        SizedBox(height: AppSpacing.s),
        // TODO : generate rujukan rumah sakit list
        ...List.generate(
          3,
          (index) => ListCardItem(
            santri: Santri.generateDummyData(),
            info: 'Mual, Pusing, batuk, pilek, dll',
          ),
        ),
      ],
    );
  }
}

Widget _buildInsightsCard(BuildContext context) {
  return Column(
    children: [
      Row(
        children: [
          insightCard(
            context,
            title: 'Total Sakit',
            value: '78',
            explanation: '+12% dari pekan lalu',
          ),
          const SizedBox(width: 8),
          insightCard(
            context,
            title: 'Kasus Terbanyak',
            value: 'Flu',
            explanation: '35 siswa terdampak',
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          insightCard(
            context,
            title: 'Butuh Istirahat Maskan',
            value: '23',
            explanation: 'Disetujui : 18\nPending : 5',
          ),
          const SizedBox(width: 8),
          insightCard(
            context,
            title: 'Kasus Hari Ini',
            value: '12',
            explanation: '6 Kasus flu, 4 demam, 2 lainnya',
          ),
        ],
      ),
    ],
  );
}
