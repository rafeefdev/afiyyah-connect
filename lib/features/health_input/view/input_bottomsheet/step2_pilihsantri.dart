import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:afiyyah_connect/features/health_input/constants/health_input_strings.dart';
import 'package:afiyyah_connect/features/health_input/view_model/pendataan_kesehatan_provider.dart';
import 'package:afiyyah_connect/features/health_input/view_model/stepcontroller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Step2PilihSantri extends ConsumerWidget {
  static String stepTitle = HealthInputStrings.step2Title;

  const Step2PilihSantri({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final santri = ref.watch(pendataanKesehatanProvider).santri;

    // Fallback if santri is somehow null
    if (santri == null) {
      return Center(
        child: Column(
          children: [
            const Text(HealthInputStrings.notSelected),
            TextButton(
              onPressed: () =>
                  ref.read(stepcontrollerProviderProvider.notifier).previous(),
              child: const Text(HealthInputStrings.backToSearch),
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
            ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
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
                  labelText: santri.namaHujroh ?? HealthInputStrings.notAvailable,
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
                  labelText:
                      '${HealthInputStrings.classLabel}${santri.jenjang?.toString() ?? HealthInputStrings.notAvailable}',
                  hintText:
                      '${HealthInputStrings.yearLabel}${santri.jenjang?.toString() ?? HealthInputStrings.notAvailable}',
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
              child: const Text(HealthInputStrings.back),
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
              child: const Text(HealthInputStrings.next),
            ),
          ],
        ),
      ],
    );
  }
}
