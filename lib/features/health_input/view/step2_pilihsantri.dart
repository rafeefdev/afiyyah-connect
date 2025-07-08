
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extensions.dart';
import 'package:flutter/material.dart';

Widget step2PilihSantri(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Nama Santri', style: context.textTheme.titleLarge),
      SizedBox(height: AppSpacing.l),
      Container(
        padding: EdgeInsets.symmetric(
          vertical: AppSpacing.l,
          horizontal: AppSpacing.l,
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            const CircleAvatar(radius: 16),
            const SizedBox(width: 12),
            const Text('Muhammad Isa'),
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
                hintText: 'X IPA 1',
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
                hintText: 'Damaskus',
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
        spacing: AppSpacing.xl,
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
