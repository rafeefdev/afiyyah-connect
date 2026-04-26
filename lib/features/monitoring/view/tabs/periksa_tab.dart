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
    final periksaAsync = ref.watch(periksaListProvider);

    List<MaterialColor> colors = [Colors.orange, Colors.blue];

    return periksaAsync.when(
      data: (periksaList) => ListView(
        children: [
          tabLegend(
            context,
            indicatorColors: colors,
            labels: ['Belum\nPeriksa', 'Sudah\nPeriksa'],
          ),
          const SizedBox(height: 12),
          periksaList.isEmpty
              ? DisplayZeroData(
                  height: 480,
                  icon: Icons.health_and_safety_rounded,
                  message: 'Tidak ada yang belum diperiksa',
                )
              : Column(
                  children: periksaList.map((pendataan) {
                    return ListCardItem(
                      customNotchColor: colors[0],
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
