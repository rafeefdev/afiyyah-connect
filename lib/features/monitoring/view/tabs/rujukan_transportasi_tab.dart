import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/features/common/widgets/displayzerodata_component.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:afiyyah_connect/features/monitoring/view/tablegend_component.dart';
import 'package:afiyyah_connect/features/monitoring/view_model/monitoring_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RujukanNTransportasiTab extends ConsumerWidget {
  const RujukanNTransportasiTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rujukanAsync = ref.watch(rujukanListTodayProvider);
    List<MaterialColor> colors = [Colors.orange, Colors.blue];

    return rujukanAsync.when(
      data: (rujukanList) => ListView(
        children: [
          tabLegend(
            context,
            indicatorColors: colors,
            labels: ['Perlu\nDiantar', 'Sudah\nDiantar'],
          ),
          const SizedBox(height: 12),
          rujukanList.isEmpty
              ? DisplayZeroData(
                  height: 480,
                  icon: Icons.check_circle_outline_rounded,
                  message: 'Tidak ada rujukan yang perlu ditindaklanjuti',
                )
              : Column(
                  children: rujukanList.map((rujukan) {
                    final student = Santri(
                      id: rujukan.santuarioId ?? '',
                      nama: rujukan.namaSantri ?? 'Tanpa Nama',
                      namaHujroh: rujukan.namaHujroh,
                      jenjang: rujukan.jenjang,
                    );
                    return ListCardItem(
                      siswa: student,
                      customNotchColor: colors[0],
                      info: 'Dirujuk ke ${rujukan.rumahSakit ?? 'RS'}',
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
