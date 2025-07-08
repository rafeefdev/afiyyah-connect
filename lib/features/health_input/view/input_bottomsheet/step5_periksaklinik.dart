import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/health_input/view/confirmationcard_component.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/pendataan_kesehatan_provider.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/stepcontroller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Step5PeriksaKlinik extends ConsumerWidget {
  static String stepTitle = 'Periksa Klinik ?';

  const Step5PeriksaKlinik({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final klinikStatus =
        ref.watch(pendataanKesehatanProvider).periksaKlinikStatus;
    final notifier = ref.read(pendataanKesehatanProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            RadioListTile<PeriksaKlinikStatus>(
              value: PeriksaKlinikStatus.sudah,
              groupValue: klinikStatus,
              onChanged: (value) => notifier.setKlinikStatus(value!),
              title: const Text('Sudah periksa'),
            ),
            RadioListTile<PeriksaKlinikStatus>(
              value: PeriksaKlinikStatus.belum,
              groupValue: klinikStatus,
              onChanged: (value) => notifier.setKlinikStatus(value!),
              title: const Text('Belum periksa'),
            ),
            RadioListTile<PeriksaKlinikStatus>(
              value: PeriksaKlinikStatus.luar,
              groupValue: klinikStatus,
              onChanged: (value) => notifier.setKlinikStatus(value!),
              title: const Text('Sudah periksa di luar'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () =>
                  ref.read(stepcontrollerProviderProvider.notifier).previous(),
              child: const Text('kembali'),
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: () {
                showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (context) => const Confirmationcard(),
                );
              },
              child: const Text('cek data'),
            ),
            SizedBox(width: AppSpacing.l),
            FilledButton(
              onPressed: () async {
                await notifier.submitData();
                if (context.mounted) {
                  Navigator.pop(context);
                  ref.read(stepcontrollerProviderProvider.notifier).toStep(0);
                }
              },
              child: const Text('Tambahkan Data'),
            ),
          ],
        ),
      ],
    );
  }
}
