import 'package:afiyyah_connect/features/dashboard/constants/dashboard_strings.dart';
import 'package:afiyyah_connect/features/dashboard/view/components/insight_card.dart';
import 'package:afiyyah_connect/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InsightCardsSection extends ConsumerWidget {
  const InsightCardsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardViewModelProvider);

    return statsAsync.when(
      data: (stats) => Column(
        children: [
          Row(
            children: [
              InsightCard(
                title: DashboardStrings.totalSickTitle,
                value: stats.totalIllnessThisWeek.toString(),
                explanation:
                    '${stats.comparisonPercentage >= 0 ? '+' : ''}${stats.comparisonPercentage.toStringAsFixed(1)}%',
              ),
              const SizedBox(width: 4),
              InsightCard(
                title: DashboardStrings.mostCasesTitle,
                value: stats.mostCommonCaseCount.toString(),
                explanation: stats.mostCommonCase,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              InsightCard(
                title: DashboardStrings.needsRestTitle,
                value: stats.needToRestCount.toString(),
                explanation: '',
              ),
              const SizedBox(width: 4),
              InsightCard(
                title: DashboardStrings.todayCasesTitle,
                value: stats.newCasesToday.toString(),
                explanation: '',
              ),
            ],
          ),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text('Error: $e'),
    );
  }
}
