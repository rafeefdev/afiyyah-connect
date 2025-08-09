import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:afiyyah_connect/features/dashboard/model/dashboard_data.dart';
import 'package:afiyyah_connect/features/dashboard/view/components/alertcardinfo_component.dart';
import 'package:afiyyah_connect/features/dashboard/view/sections/custom_appbar.dart';
import 'package:afiyyah_connect/features/dashboard/view/sections/tabviewcharts.dart';
import 'package:afiyyah_connect/features/dashboard/view/components/insight_card.dart';
import 'package:afiyyah_connect/features/health_input/view/show_bottom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardPage extends ConsumerWidget {
  final UserModel user;
  final DashboardData data;
  const DashboardPage({required this.user, required this.data, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: AppSpacing.pagePadding,
          children: [
            CustomDashboardAppBar(user: user),
            SizedBox(height: AppSpacing.l),
            const _NotificationSection(),
            SizedBox(height: AppSpacing.l),
            _buildInsightsCard(context, data),
            SizedBox(height: AppSpacing.l),
            TabViewCharts(
              kasusPerHari: data.kasusPerHari,
              kasusPerJenjang: data.kasusPerJenjang,
              kasusPerAsrama: data.kasusPerAsrama,
              pieJenisPenyakit: data.pieJenisPenyakit,
              rujukanHariIni: data.rujukanHariIni,
              sakitHariIni: data.sakitHariIni,
            ),
            SizedBox(height: AppSpacing.l),
            _buildRujukanRumahSakit(context),
            SizedBox(height: AppSpacing.l),
            _buildSantriSakitHariIni(context),
            const SizedBox(height: 240),
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

  Widget _buildRujukanRumahSakit(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rujukan Rumah Sakit', style: context.textTheme.titleMedium),
        SizedBox(height: AppSpacing.s),
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

class _NotificationSection extends StatelessWidget {
  const _NotificationSection();

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      child: alertCard(
        context,
        title: 'Rujukan Rumah Sakit',
        alertMessage: '2 santri butuh penanganan rumah sakit',
      ),
    );
  }
}

Widget _buildInsightsCard(BuildContext context, DashboardData data) {
  int totalKasusBaruHariIni = data.kasusBaruHariIni.values.fold(
    0,
    (a, b) => a + b,
  );

  return Column(
    children: [
      Row(
        children: [
          insightCard(
            context,
            title: 'Total Sakit',
            value: data.totalSakitPekanIni.toString(),
            explanation:
                '${data.persentasePerbandinganPekanLalu} dari pekan lalu',
          ),
          const SizedBox(width: 4),
          insightCard(
            context,
            title: 'Kasus Terbanyak',
            value: data.kasusTerbanyak,
            explanation: '${data.jumlahKasusTerbanyak} santri terdampak',
          ),
        ],
      ),
      const SizedBox(height: 4),
      Row(
        children: [
          insightCard(
            context,
            title: 'Butuh Istirahat Maskan',
            value: "${data.butuhIstirahatMaskan}",
            explanation: 'Disetujui : 18\nPending : 5',
          ),
          const SizedBox(width: 4),
          insightCard(
            context,
            title: 'Kasus Hari Ini',
            value: totalKasusBaruHariIni.toString(),
            explanation: '6 Kasus flu, 4 demam, 2 lainnya',
          ),
        ],
      ),
    ],
  );
}
