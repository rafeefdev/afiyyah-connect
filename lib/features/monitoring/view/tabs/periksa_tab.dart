import 'package:afiyyah_connect/app/core/model/activities/monitoring_models.dart';
import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/features/auth/view_model/app_user_provider.dart';
import 'package:afiyyah_connect/features/common/widgets/displayzerodata_component.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:afiyyah_connect/features/monitoring/view/detail_dialog/health_detail_dialog.dart';
import 'package:afiyyah_connect/features/monitoring/view/patient_detail_page.dart';
import 'package:afiyyah_connect/features/monitoring/view/tablegend_component.dart';
import 'package:afiyyah_connect/features/monitoring/view_model/monitoring_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PeriksaTab extends ConsumerWidget {
  const PeriksaTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final periksaAsync = ref.watch(periksaListTodayProvider);
    final userRole = ref.watch(appUserProvider).valueOrNull?.role;
    List<MaterialColor> colors = [Colors.orange, Colors.blue, Colors.green];

    return periksaAsync.when(
      data: (periksaList) => ListView(
        children: [
          tabLegend(
            context,
            indicatorColors: colors,
            labels: ['Belum\nPeriksa', 'Sudah\nPeriksa', 'Periksa\ndi Luar'],
          ),
          const SizedBox(height: 12),
          if (periksaList.isEmpty)
            DisplayZeroData(
              height: 480,
              icon: Icons.health_and_safety_rounded,
              message: 'Tidak ada santri sakit hari ini',
            )
          else
            ...periksaList.map((p) {
              final student = Santri(
                id: p.santuarioId,
                nama: p.namaSantri ?? 'Tanpa Nama',
                namaHujroh: p.namaHujroh,
                jenjang: p.jenjang,
              );
              final notchColor = p.statusPeriksa == 'belum'
                  ? colors[0]
                  : (p.statusPeriksa == 'di luar' ? colors[2] : colors[1]);
              return ListCardItem(
                siswa: student,
                customNotchColor: notchColor,
                info: p.keluhan.isNotEmpty
                    ? p.keluhan.join(', ')
                    : 'Tanpa keluhan',
                onTap: () => _handleTap(context, userRole, p, student),
              );
            }),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  void _handleTap(
    BuildContext context,
    Role? userRole,
    PendataanWithSantri pendataan,
    Santri student,
  ) {
    if (userRole == Role.resepsionisKlinik || userRole == Role.dokter) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => PatientDetailPage(
            pendataanId: pendataan.pendataanId,
            tab: DetailTab.periksa,
            namaSantri: student.nama,
            namaHujroh: student.namaHujroh,
            jenjang: student.jenjang,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => HealthDetailDialog(
          pendataanId: pendataan.pendataanId,
          tab: DetailTab.periksa,
          namaSantri: student.nama,
          namaHujroh: student.namaHujroh,
          jenjang: student.jenjang,
        ),
      );
    }
  }
}
