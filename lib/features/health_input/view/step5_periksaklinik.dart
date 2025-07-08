import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extensions.dart';
import 'package:afiyyah_connect/features/health_input/view/confirmationcard_component.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/stepcontroller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Step5PeriksaKlinik extends ConsumerWidget {
  static String stepTitle = 'Periksa Klinik ?';

  const Step5PeriksaKlinik({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            RadioListTile(
              value: 'sudah',
              groupValue: null,
              onChanged: (_) {},
              title: const Text('Sudah periksa'),
            ),
            RadioListTile(
              value: 'belum',
              groupValue: null,
              onChanged: (_) {},
              title: const Text('Belum periksa'),
            ),
            RadioListTile(
              value: 'luar',
              groupValue: null,
              onChanged: (_) {},
              title: const Text('Sudah periksa di luar'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: () {}, child: const Text('batal')),
            Spacer(),
            OutlinedButton(
              onPressed: () {
                showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (context) => Confirmationcard(
                    name: 'Fulan John Doe',
                    className: 'XA1',
                    hujroh: 'Damaskus',
                    keluhan: 'Lemas, Pusing, dll',
                    kunjunganKlinik: 'Kemarin',
                  ),
                );
              },
              child: const Text('cek data'),
            ),
            SizedBox(width: AppSpacing.l),
            FilledButton(
              onPressed: () {
                //TODO: implement send to database
                Navigator.pop(context);
              },
              child: const Text('Tambahkan Data'),
            ),
          ],
        ),
      ],
    );
  }
}
