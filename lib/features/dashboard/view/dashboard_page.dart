import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/dashboard/model/dashboard_data.dart';
import 'package:afiyyah_connect/features/dashboard/view/sections/custom_appbar.dart';
import 'package:afiyyah_connect/features/dashboard/view/sections/insightcards_section.dart';
import 'package:afiyyah_connect/features/dashboard/view/sections/notification_section.dart';
import 'package:afiyyah_connect/features/dashboard/view/sections/charts_section.dart';
import 'package:afiyyah_connect/features/dashboard/view/sections/patientsreferral_section.dart';
import 'package:afiyyah_connect/features/dashboard/view/sections/todaypatients_section.dart';
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
            const NotificationSection(),
            SizedBox(height: AppSpacing.l),
            InsightCardsSection(data: data),
            SizedBox(height: AppSpacing.l),
            ChartsSection(
              kasusPerHari: data.kasusPerHari,
              kasusPerJenjang: data.kasusPerJenjang,
              kasusPerAsrama: data.kasusPerAsrama,
              pieJenisPenyakit: data.pieJenisPenyakit,
              rujukanHariIni: data.rujukanHariIni,
              sakitHariIni: data.sakitHariIni,
            ),
            SizedBox(height: AppSpacing.l),
            const PatientsReferralSection(),
            SizedBox(height: AppSpacing.l),
            const TodaypatientsSection(),
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
}
