import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/monitoring/view/detail_dialog/health_detail_dialog.dart';
import 'package:flutter/material.dart';

class VisitHistoryCard extends StatelessWidget {
  final String? pendataanId;
  final int? kunjunganId;
  final DetailTab tab;

  const VisitHistoryCard({
    super.key,
    this.pendataanId,
    this.kunjunganId,
    required this.tab,
  });

  @override
  Widget build(BuildContext context) {
    final title = switch (tab) {
      DetailTab.periksa => 'Riwayat Pendataan',
      DetailTab.arahan => 'Riwayat Kunjungan',
      DetailTab.rujukan => 'Riwayat Klinik',
    };

    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.history,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(width: AppSpacing.s),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.m),
            if (pendataanId == null && kunjunganId == null)
              Text(
                'Belum ada data',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              )
            else
              _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return Text(
            'Tidak ada riwayat',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          );
        }
        return _buildDetailList(context, snapshot.data!);
      },
    );
  }

  Future<Map<String, dynamic>> _fetchData() async {
    return {};
  }

  Widget _buildDetailList(BuildContext context, Map<String, dynamic> data) {
    return Text('ID: ${data.keys.length}');
  }
}
