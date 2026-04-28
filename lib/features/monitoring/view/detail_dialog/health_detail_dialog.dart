import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/auth/view_model/app_user_provider.dart';
import 'package:afiyyah_connect/features/monitoring/view/detail_dialog/widgets/student_info_card.dart';
import 'package:afiyyah_connect/features/monitoring/view/detail_dialog/widgets/medical_info_card.dart';
import 'package:afiyyah_connect/features/monitoring/view/detail_dialog/widgets/visit_history_card.dart';
import 'package:afiyyah_connect/features/monitoring/view/detail_dialog/widgets/referral_info_card.dart';
import 'package:afiyyah_connect/features/monitoring/view/detail_dialog/widgets/action_buttons.dart';
import 'package:afiyyah_connect/features/monitoring/view/patient_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DetailTab { periksa, arahan, rujukan }

class HealthDetailDialog extends ConsumerStatefulWidget {
  final String? pendataanId;
  final int? kunjunganId;
  final int? rujukanId;
  final DetailTab tab;
  final String? namaSantri;
  final String? namaHujroh;
  final int? jenjang;
  final String? golDarah;
  final List<String>? alergi;
  final String? riwayatId;

  const HealthDetailDialog({
    super.key,
    this.pendataanId,
    this.kunjunganId,
    this.rujukanId,
    required this.tab,
    this.namaSantri,
    this.namaHujroh,
    this.jenjang,
    this.golDarah,
    this.alergi,
    this.riwayatId,
  });

  @override
  ConsumerState<HealthDetailDialog> createState() => _HealthDetailDialogState();
}

class _HealthDetailDialogState extends ConsumerState<HealthDetailDialog> {
  @override
  Widget build(BuildContext context) {
    final userRole = ref.watch(appUserProvider).valueOrNull?.role;
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 600;

    return Dialog(
      child: Container(
        width: isDesktop ? 500 : size.width * 0.9,
        constraints: const BoxConstraints(maxHeight: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            Flexible(
              child: SingleChildScrollView(
                padding: AppSpacing.pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StudentInfoCard(
                      nama: widget.namaSantri ?? '-',
                      namaHujroh: widget.namaHujroh,
                      jenjang: widget.jenjang,
                      golDarah: widget.golDarah,
                      allergies: widget.alergi,
                    ),
                    SizedBox(height: AppSpacing.m),
                    MedicalInfoCard(
                      riwayatId: widget.riwayatId,
                      alergias: widget.alergi,
                    ),
                    SizedBox(height: AppSpacing.m),
                    if (widget.tab == DetailTab.periksa)
                      VisitHistoryCard(
                        pendataanId: widget.pendataanId,
                        tab: widget.tab,
                      ),
                    if (widget.tab == DetailTab.arahan ||
                        widget.tab == DetailTab.rujukan)
                      VisitHistoryCard(
                        pendataanId: widget.pendataanId,
                        kunjunganId: widget.kunjunganId,
                        tab: widget.tab,
                      ),
                    if (widget.tab == DetailTab.rujukan &&
                        widget.rujukanId != null) ...[
                      SizedBox(height: AppSpacing.m),
                      ReferralInfoCard(rujukanId: widget.rujukanId!),
                    ],
                    SizedBox(height: AppSpacing.l),
                    ActionButtons(
                      tab: widget.tab,
                      pendataanId: widget.pendataanId,
                      kunjunganId: widget.kunjunganId,
                      rujukanId: widget.rujukanId,
                      userRole: userRole,
                      namaSantri: widget.namaSantri,
                      onViewFullscreen: () =>
                          _navigateToFullscreen(context, userRole),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToFullscreen(BuildContext context, Role? userRole) {
    if (userRole == Role.resepsionisKlinik || userRole == Role.dokter) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => PatientDetailPage(
            pendataanId: widget.pendataanId,
            kunjunganId: widget.kunjunganId,
            rujukanId: widget.rujukanId,
            tab: widget.tab,
            namaSantri: widget.namaSantri,
            namaHujroh: widget.namaHujroh,
            jenjang: widget.jenjang,
          ),
        ),
      );
    }
  }

  Widget _buildHeader(BuildContext context) {
    final tabTitle = switch (widget.tab) {
      DetailTab.periksa => 'Detail Pemeriksaan',
      DetailTab.arahan => 'Detail Arahan',
      DetailTab.rujukan => 'Detail Rujukan RS',
    };

    return Container(
      padding: EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Row(
        children: [
          Icon(switch (widget.tab) {
            DetailTab.periksa => Icons.medical_services_outlined,
            DetailTab.arahan => Icons.assignment_outlined,
            DetailTab.rujukan => Icons.local_hospital_outlined,
          }, color: Theme.of(context).colorScheme.onPrimaryContainer),
          SizedBox(width: AppSpacing.s),
          Text(
            tabTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
