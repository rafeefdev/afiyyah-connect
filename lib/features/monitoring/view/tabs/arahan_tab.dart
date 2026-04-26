import 'package:afiyyah_connect/features/common/widgets/displayzerodata_component.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:afiyyah_connect/features/monitoring/view/tablegend_component.dart';
import 'package:afiyyah_connect/features/monitoring/view_model/monitoring_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArahanTab extends ConsumerWidget {
  const ArahanTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arahanAsync = ref.watch(arahanListProvider);

    List<MaterialColor> colors = [Colors.green, Colors.orange, Colors.red];

    return arahanAsync.when(
      data: (arahanList) => ListView(
        children: [
          tabLegend(
            context,
            indicatorColors: colors,
            labels: ['Lanjut\nKegiatan', 'Istirahat\nMaskan', 'Rujuk\nRS'],
          ),
          const SizedBox(height: 12),
          arahanList.isEmpty
              ? DisplayZeroData(
                  height: 480,
                  icon: Icons.health_and_safety_rounded,
                  message: 'Tidak ada arahan',
                )
              : Column(
                  children: arahanList.map((kunjungan) {
                    return ListCardItem(
                      customNotchColor: colors[1],
                      info: 'Istirahat di asrama',
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
