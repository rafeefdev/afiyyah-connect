import 'package:afiyyah_connect/features/dashboard/constants/dashboard_strings.dart';
import 'package:afiyyah_connect/features/dashboard/view/components/insight_card.dart';
import 'package:flutter/material.dart';

class InsightCardsSection extends StatelessWidget {
  const InsightCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InsightCard(
              title: DashboardStrings.totalSickTitle,
              value: 'data.totalSakitPekanIni.toString()',
              explanation: '',
            ),
            const SizedBox(width: 4),
            InsightCard(
              title: DashboardStrings.mostCasesTitle,
              value: '',
              explanation:
                  '{data.jumlahKasusTerbanyak} {DashboardStrings.studentsAffected}',
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            InsightCard(
              title: DashboardStrings.needsRestTitle,
              value: "{data.butuhIstirahatMaskan}",
              explanation:
                  '${DashboardStrings.approved} : 18\n${DashboardStrings.pending} : 5',
            ),
            const SizedBox(width: 4),
            InsightCard(
              title: DashboardStrings.todayCasesTitle,
              value: 'totalKasusBaruHariIni.toString()',
              explanation: '6 Kasus flu, 4 demam, 2 lainnya',
            ),
          ],
        ),
      ],
    );
  }
}
