import 'package:afiyyah_connect/features/dashboard/model/dashboard_data.dart';
import 'package:afiyyah_connect/features/dashboard/view/components/insight_card.dart';
import 'package:flutter/material.dart';

class InsightCardsSection extends StatelessWidget {
  final DashboardData data;

  const InsightCardsSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    int totalKasusBaruHariIni = data.kasusBaruHariIni.values.fold(
      0,
      (a, b) => a + b,
    );

    return Column(
      children: [
        Row(
          children: [
            insightCard(
              context,
              title: 'Total Sakit',
              value: data.totalSakitPekanIni.toString(),
              explanation:
                  '${data.persentasePerbandinganPekanLalu} dari pekan lalu',
            ),
            const SizedBox(width: 4),
            insightCard(
              context,
              title: 'Kasus Terbanyak',
              value: data.kasusTerbanyak,
              explanation: '${data.jumlahKasusTerbanyak} santri terdampak',
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            insightCard(
              context,
              title: 'Butuh Istirahat Maskan',
              value: "${data.butuhIstirahatMaskan}",
              explanation: 'Disetujui : 18\nPending : 5',
            ),
            const SizedBox(width: 4),
            insightCard(
              context,
              title: 'Kasus Hari Ini',
              value: totalKasusBaruHariIni.toString(),
              explanation: '6 Kasus flu, 4 demam, 2 lainnya',
            ),
          ],
        ),
      ],
    );
  }
}
