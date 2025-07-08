
import 'package:afiyyah_connect/features/common/utils/extensions.dart';
import 'package:flutter/material.dart';

Widget step5PeriksaKlinik(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Periksa ke Klinik?', style: context.textTheme.titleLarge),
      const SizedBox(height: 12),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(onPressed: () {}, child: const Text('batal')),
          FilledButton(onPressed: () {}, child: const Text('lanjut')),
        ],
      ),
    ],
  );
}
