import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/dashboard/view/sections/custom_appbar.dart';
import 'package:afiyyah_connect/features/dashboard/view/sections/insightcards_section.dart';
import 'package:afiyyah_connect/features/dashboard/view/sections/notification_section.dart';
import 'package:afiyyah_connect/features/dashboard/view/sections/charts_section.dart';
import 'package:afiyyah_connect/features/dashboard/view/sections/patientsreferral_section.dart';
import 'package:afiyyah_connect/features/dashboard/view/sections/todaypatients_section.dart';
import 'package:afiyyah_connect/features/health_input/view/show_bottom_input.dart';
import 'package:afiyyah_connect/features/dashboard/constants/dashboard_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardPage extends ConsumerWidget {
  final UserModel user;
  const DashboardPage({required this.user, super.key});

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
            InsightCardsSection(),
            SizedBox(height: AppSpacing.l),
            ChartsSection(), // TODO : most affected by deleted DashboardData
            SizedBox(height: AppSpacing.l),
            PatientsReferralSection(),
            SizedBox(height: AppSpacing.l),
            TodaypatientsSection(),
            const SizedBox(height: 240),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(DashboardStrings.inputData),
        icon: const Icon(Icons.assignment_add),
        onPressed: () => showBottomHealthInput(context, ref),
      ),
    );
  }
}
