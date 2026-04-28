import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:flutter/material.dart';

class MedicalInfoCard extends StatelessWidget {
  final String? riwayatId;
  final List<String>? alergias;

  const MedicalInfoCard({super.key, this.riwayatId, this.alergias});

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
            if (alergias != null && alergias!.isNotEmpty) ...[
              Text(
                'Alergi: ${alergias!.join(', ')}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ] else ...[
              Text(
                'Belum ada riwayat medis',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
