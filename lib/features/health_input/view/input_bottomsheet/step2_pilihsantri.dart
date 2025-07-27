import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/pendataan_kesehatan_provider.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/stepcontroller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Step2PilihSantri extends ConsumerWidget {
  static String stepTitle = 'Pilih Santri';

  const Step2PilihSantri({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final santri = ref.watch(pendataanKesehatanProvider).santri;

    // Fallback if santri is somehow null
    if (santri == null) {
      return Center(
        child: Column(
          children: [
            const Text('Santri belum dipilih.'),
            TextButton(
              onPressed: () =>
                  ref.read(stepcontrollerProviderProvider.notifier).previous(),
              child: const Text('Kembali ke pencarian'),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: AppSpacing.l,
            horizontal: AppSpacing.l,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(
              context,
            ).colorScheme.surfaceVariant.withOpacity(0.5),
          ),
          child: Row(
            children: [
              const CircleAvatar(radius: 20, child: Icon(Icons.person)),
              const SizedBox(width: 12),
              Expanded(
                child: Tooltip(
                  message: santri.nama.toTitleCase(),
                  child: Text(
                    santri.nama.toTitleCase(),
                    style: context.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Hujroh',
                  hintText: santri.namaHujroh ?? 'N/A',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Jenjang',
                  hintText: 'Tahun ke-${santri.jenjang?.toString() ?? 'N/A'}',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                ref.read(stepcontrollerProviderProvider.notifier).previous();
              },
              child: const Text('Kembali'),
            ),
            SizedBox(width: AppSpacing.m),
            FilledButton(
              onPressed: () {
                // Santri sudah di-set di state, jadi langsung lanjut
                ref.read(stepcontrollerProviderProvider.notifier).next();
              },
              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size.fromWidth(120)),
              ),
              child: const Text('Lanjut'),
            ),
          ],
        ),
      ],
    );
  }
}
