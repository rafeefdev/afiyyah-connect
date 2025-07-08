import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extensions.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/stepcontroller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TODO : connect keluhan list with list of real list of disease
final keluhanList = [
  'Batuk',
  'Pusing',
  'Demam / Panas',
  'Pilek',
  'Masuk Angin',
  'Maag / Asam Lambung',
  'lainnya ...',
];

class Step3Keluhan extends ConsumerWidget {
  static String stepTitle = 'Apa Saja yang Dikeluhkan ?';

  const Step3Keluhan({super.key, required this.keluhanList});

  final List<String> keluhanList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: keluhanList
              .map(
                (keluhan) => FilterChip(
                  label: Text(keluhan),
                  selected: false,
                  onSelected: (_) {},
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: AppSpacing.l,
          children: [
            TextButton(onPressed: () {}, child: const Text('batal')),
            FilledButton(
              onPressed: () {
                //add value of step controller
                ref.read(stepcontrollerProviderProvider.notifier).next();
              },
              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size.fromWidth(120)),
              ),
              child: const Text('lanjut'),
            ),
          ],
        ),
      ],
    );
  }
}
