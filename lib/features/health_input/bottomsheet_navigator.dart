import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extensions.dart';
import 'package:afiyyah_connect/features/health_input/step5_periksaklinik.dart';
import 'package:flutter/material.dart';

class BottomSheetNavigator extends StatelessWidget {
  const BottomSheetNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: step5PeriksaKlinik(context),
    );
  }

  Widget step1CariSantri(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nama Santri', style: context.textTheme.titleLarge),
        SizedBox(height: AppSpacing.l),
        TextField(
          autofocus: true,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hint: const Text('Ketik untuk mencari nama santri'),
            label: const Text('Nama Santri'),
            prefixIcon: const Icon(Icons.search_rounded),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        SizedBox(height: AppSpacing.l),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: AppSpacing.m,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('batal'),
              ),
            ),
            Expanded(
              child: FilledButton(onPressed: () {}, child: const Text('cari')),
            ),
          ],
        ),
      ],
    );
  }
}
