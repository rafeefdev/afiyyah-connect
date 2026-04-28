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
      data: (arahanList) => ListView(
        children: [
          tabLegend(
            context,
            indicatorColors: colors,
            labels: ['Lanjut\n Kegiatan', 'Istirahat\nMaskan', 'Rujuk\nRS'],
          ),
          const SizedBox(height: 12),
          arahanList.isEmpty
              ? DisplayZeroData(
                  height: 480,
                  icon: Icons.health_and_safety_rounded,
                  message: 'Tidak ada arahan istirahat',
                )
              : Column(
                  children: arahanList.map((kunjungan) {
                    final student = Santri(
                      id: kunjungan.santuarioId ?? '',
                      nama: kunjungan.namaSantri ?? 'Tanpa Nama',
                      namaHujroh: kunjungan.namaHujroh,
                      jenjang: kunjungan.jenjang,
                    );
                    return ListCardItem(
                      siswa: student,
                      customNotchColor: colors[1],
                      info: kunjungan.keluhan?.join(', ') ?? 'Tanpa keluhan',
                      onTap: () => _showDetailDialog(
                        context,
                        kunjungan.idKunjungan,
                        DetailTab.arahan,
                        student,
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  void _showDetailDialog(
    BuildContext context,
    int kunjunganId,
    DetailTab tab,
    Santri student,
  ) {
    showDialog(
      context: context,
      builder: (context) =>
          HealthDetailDialog(kunjunganId: kunjunganId, tab: tab),
    );
  }
}
