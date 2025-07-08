import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/pendataan_kesehatan_provider.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/stepcontroller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Step2PilihSantri extends ConsumerWidget {
  static String stepTitle = 'Pilih Santri';

  const Step2PilihSantri({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //TODO : save real santri data that fetched from supabase

    // Dummy santri data for demonstration
    final santri = Santri(
      id: '123',
      name: 'Muhammad Isa',
      tahunMasuk: DateTime(2022),
      hujrohId: 'DMS',
      kelasId: 'XIPA1',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              Text(santri.name),
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
                  // TODO: display kelas based on the id
                  hintText: santri.kelasId,
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
                  // TODO: display hujroh based on the id
                  hintText: santri.hujrohId,
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
                Navigator.pop(context);
              },
              child: const Text('batal'),
            ),
            SizedBox(width: AppSpacing.xl),
            FilledButton(
              onPressed: () {
                // Set the santri in the state
                ref.read(pendataanKesehatanProvider.notifier).setSantri(santri);
                // Move to the next step
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
