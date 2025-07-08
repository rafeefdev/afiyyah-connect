import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/stepcontroller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Step1CariSantri extends ConsumerWidget {
  final nameController = TextEditingController();

  Step1CariSantri({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            autofocus: true,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hint: const Text('Ketik untuk mencari nama santri'),
              label: const Text('Nama Santri'),
              prefixIcon: const Icon(Icons.search_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: AppSpacing.l),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: AppSpacing.m,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('batal'),
              ),
              FilledButton(
                onPressed: () {
                  //TODO : implement search algorythm
                  ref.read(stepcontrollerProviderProvider.notifier).next();
                },
                child: const Text('cari'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
