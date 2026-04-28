import 'package:afiyyah_connect/app/core/model/activities/monitoring_models.dart';
import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/features/common/widgets/displayzerodata_component.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:afiyyah_connect/features/monitoring/view/detail_dialog/health_detail_dialog.dart';
import 'package:afiyyah_connect/features/monitoring/view/tablegend_component.dart';
import 'package:afiyyah_connect/features/monitoring/view_model/monitoring_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArahanTab extends ConsumerWidget {
  const ArahanTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arahanAsync = ref.watch(arahanListTodayProvider);
    List<MaterialColor> colors = [Colors.green, Colors.orange, Colors.red];

    return arahanAsync.when(
      data: (list) => ListView(
        children: [
          tabLegend(
            context,
            indicatorColors: colors,
            labels: ['Lanjut\nKegiatan', 'Istirahat\nMaskan', 'Rujuk\nRS'],
          ),
          const SizedBox(height: 12),
          if (list.isEmpty)
            DisplayZeroData(
              height: 480,
              icon: Icons.health_and_safety_rounded,
              message: 'Tidak ada arahan istirahat',
            )
          else
            ...list.map((k) {
              final student = Santri(
                id: k.santuarioId ?? '',
                nama: k.namaSantri ?? '-',
                namaHujroh: k.namaHujroh,
                jenjang: k.jenjang,
              );
              return ListCardItem(
                siswa: student,
                customNotchColor: colors[1],
                info: k.keluhan?.join(', ') ?? 'Tanpa keluhan',
                onTap: () => _showDialog(context, k, student),
              );
            }),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  void _showDialog(
    BuildContext context,
    KunjunganWithSantri kunjungan,
    Santri student,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => HealthDetailDialog(
        kunjunganId: kunjungan.idKunjungan,
        tab: DetailTab.arahan,
        namaSantri: student.nama,
        namaHujroh: student.namaHujroh,
        jenjang: student.jenjang,
      ),
    );
  }
}
