import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/features/common/widgets/displayzerodata_component.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:afiyyah_connect/features/monitoring/view/tablegend_component.dart';
import 'package:afiyyah_connect/features/monitoring/view_model/monitoring_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PeriksaTab extends ConsumerWidget {
  const PeriksaTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final periksaAsync = ref.watch(periksaListTodayProvider);

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
          periksaList.isEmpty
              ? DisplayZeroData(
                  height: 480,
                  icon: Icons.health_and_safety_rounded,
                  message: 'Tidak ada santri sakit hari ini',
                )
              : Column(
                  children: periksaList.map((pendataan) {
                    final student = Santri(
                      id: pendataan.santuarioId,
                      nama: pendataan.namaSantri ?? 'Tanpa Nama',
                      namaHujroh: pendataan.namaHujroh,
                      jenjang: pendataan.jenjang,
                    );
                    Color notchColor;
                    if (pendataan.statusPeriksa == 'belum') {
                      notchColor = colors[0];
                    } else if (pendataan.statusPeriksa == 'di luar') {
                      notchColor = colors[2];
                    } else {
                      notchColor = colors[1];
                    }
                    return ListCardItem(
                      siswa: student,
                      customNotchColor: notchColor,
                      info: pendataan.keluhan.isNotEmpty
                          ? pendataan.keluhan.join(', ')
                          : 'Tanpa keluhan',
                    );
                  }).toList(),
                ),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}
