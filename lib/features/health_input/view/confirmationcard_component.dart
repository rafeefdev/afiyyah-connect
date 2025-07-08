import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extensions.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/pendataan_kesehatan_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class Confirmationcard extends ConsumerWidget {
  const Confirmationcard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pendataanKesehatanProvider);
    final santri = state.santri;
    final keluhan = state.keluhan.join(', ');
    final sickTime = state.sickStartTime != null
        ? DateFormat('d MMMM y, HH:mm').format(state.sickStartTime!)
        : 'Belum diisi';

    if (santri == null) {
      return const Dialog(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Data santri belum dipilih.'),
        ),
      );
    }

    return Dialog(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.l,
          vertical: AppSpacing.m,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(Icons.person, size: 40, color: Colors.grey),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        santri.name,
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        santri.kelasId,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        santri.hujrohId,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 8),
            Text(
              'Keluhan',
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              keluhan.isNotEmpty ? keluhan : 'Belum diisi',
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Mulai Sakit',
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              sickTime,
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
