import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/auth/view_model/auth_provider.dart';
import 'package:afiyyah_connect/features/common/utils/extension/string_extension.dart';
import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:afiyyah_connect/features/common/utils/get_initials.dart';
import 'package:afiyyah_connect/features/common/widgets/dateinfo_component.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:afiyyah_connect/features/dashboard/model/dashboard_data.dart';
import 'package:afiyyah_connect/features/dashboard/view/alertcardinfo_component.dart';
import 'package:afiyyah_connect/features/dashboard/view/tabviewcharts.dart';
import 'package:afiyyah_connect/features/dashboard/view/insight_card.dart';
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
            _buildCustomAppBar(context, ref),
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

  Widget _buildCustomAppBar(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        _buildProfileBar(context, ref),
        const Spacer(),
        DateInfo(
          textTheme: context.textTheme,
          customTextStyle: context.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileBar(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => _showUserInfoDialog(context, ref),
      child: Row(
        spacing: AppSpacing.m,
        children: [
          CircleAvatar(child: Text(getInitials(user.fullName))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.fullName, style: context.textTheme.titleSmall),
              Text(
                Role.name(user.role),
                style: context.textTheme.bodySmall!.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showUserInfoDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            'Informasi Pengguna',
            style: context.textTheme.titleLarge!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 30,
                  child: Text(
                    getInitials(user.fullName),
                    style: context.textTheme.headlineSmall,
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.l),
              Text(
                'Nama',
                style: context.textTheme.labelMedium!.copyWith(
                  color: Colors.blueGrey,
                ),
              ),
              Text(user.fullName, style: context.textTheme.bodyLarge),
              SizedBox(height: AppSpacing.m),
              Text(
                'Email',
                style: context.textTheme.labelMedium!.copyWith(
                  color: Colors.blueGrey,
                ),
              ),
              Text(user.email, style: context.textTheme.bodyLarge),
              SizedBox(height: AppSpacing.m),
              Text(
                'Role',
                style: context.textTheme.labelMedium!.copyWith(
                  color: Colors.blueGrey,
                ),
              ),
              Text(Role.name(user.role), style: context.textTheme.bodyLarge),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Tutup'),
            ),
            FilledButton.tonal(
              style: FilledButton.styleFrom(
                backgroundColor: context.colorScheme.errorContainer,
                foregroundColor: context.colorScheme.onErrorContainer,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the info dialog
                _showSignOutConfirmationDialog(context, ref);
              },
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  void _showSignOutConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Sign Out'),
          content: const Text('Apakah Anda yakin ingin keluar dari akun ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Batal'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: context.colorScheme.error,
                foregroundColor: context.colorScheme.onError,
              ),
              onPressed: () {
                ref.read(authProviderProvider.notifier).signOut();
                Navigator.of(dialogContext).pop(); // Close confirmation dialog
              },
              child: const Text('Ya, Keluar'),
            ),
          ],
        );
      },
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
            //TODO : fetch real value
            explanation: 'Disetujui : 18\nPending : 5',
          ),
          const SizedBox(width: 4),
          insightCard(
            context,
            title: 'Kasus Hari Ini',
            value: totalKasusBaruHariIni.toString(),
            //TODO : display real cases
            explanation: '6 Kasus flu, 4 demam, 2 lainnya',
          ),
        ],
      ),
    ],
  );
}
