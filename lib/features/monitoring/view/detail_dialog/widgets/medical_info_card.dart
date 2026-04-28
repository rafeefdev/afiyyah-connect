import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:flutter/material.dart';

class MedicalInfoCard extends StatelessWidget {
  final String? santruiId;

  const MedicalInfoCard({super.key, required this.santruiId});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.favorite_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: AppSpacing.s),
                Text(
                  'Riwayat Medis',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.m),
            FutureBuilder<List<dynamic>>(
              future: _fetchRiwayat(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text(
                    'Belum ada riwayat medis',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  );
                }
                return _buildRiwayatList(context, snapshot.data!);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<dynamic>> _fetchRiwayat(BuildContext context) async {
    return [];
  }

  Widget _buildRiwayatList(BuildContext context, List<dynamic> data) {
    return Text('Data: ${data.length}');
  }
}
