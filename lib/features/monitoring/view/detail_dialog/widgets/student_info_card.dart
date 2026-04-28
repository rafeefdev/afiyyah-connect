import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:flutter/material.dart';

class StudentInfoCard extends StatelessWidget {
  final String nama;
  final String? namaHujroh;
  final int? jenjang;
  final String? golDarah;
  final List<String>? allergies;

  const StudentInfoCard({
    super.key,
    required this.nama,
    this.namaHujroh,
    this.jenjang,
    this.golDarah,
    this.allergies,
  });

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
                CircleAvatar(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer,
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                SizedBox(width: AppSpacing.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nama,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Hujroh ${namaHujroh ?? '-'} • Jenjang ${jenjang ?? '-'}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (golDarah != null ||
                (allergies != null && allergies!.isNotEmpty)) ...[
              Divider(height: AppSpacing.l),
              Wrap(
                spacing: AppSpacing.s,
                runSpacing: AppSpacing.xs,
                children: [
                  if (golDarah != null)
                    _InfoChip(
                      icon: Icons.water_drop_outlined,
                      label: 'Gol. Darah',
                      value: golDarah!,
                      color: Colors.red,
                    ),
                  if (allergies != null && allergies!.isNotEmpty)
                    _InfoChip(
                      icon: Icons.warning_amber_rounded,
                      label: 'Alergi',
                      value: allergies!.join(', '),
                      color: Colors.orange,
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          SizedBox(width: AppSpacing.xs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: color),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
