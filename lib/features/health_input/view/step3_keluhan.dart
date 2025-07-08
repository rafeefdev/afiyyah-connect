
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extensions.dart';
import 'package:flutter/material.dart';

Widget step3Keluhan(BuildContext context) {
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
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Apa yang dikeluhkan Isa?', style: context.textTheme.titleLarge),
      SizedBox(height: AppSpacing.l),
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
            onPressed: () {},
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
