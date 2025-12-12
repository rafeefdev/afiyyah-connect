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
              value: '0',
              explanation: '',
            ),
            const SizedBox(width: 4),
            InsightCard(
              title: DashboardStrings.mostCasesTitle,
              value: '0',
              explanation: '',
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            InsightCard(
              title: DashboardStrings.needsRestTitle,
              value: "0",
              explanation:
                  '${DashboardStrings.approved} : X\n${DashboardStrings.pending} : Y',
            ),
            const SizedBox(width: 4),
            InsightCard(
              title: DashboardStrings.todayCasesTitle,
              value: '0',
              explanation: 'X Kasus flu, Y demam, Z lainnya',
            ),
          ],
        ),
      ],
    );
  }
}
