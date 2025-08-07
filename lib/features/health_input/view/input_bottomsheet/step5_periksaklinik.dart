import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:afiyyah_connect/features/health_input/data/model/periksaklinikstatus_model.dart';
import 'package:afiyyah_connect/features/health_input/view/confirmationcard_component.dart';
import 'package:afiyyah_connect/features/health_input/view/statuskunjunganselector_component.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/pendataan_kesehatan_provider.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/stepcontroller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Step5PeriksaKlinik extends ConsumerWidget {
  static String stepTitle = 'Periksa Klinik ?';

  const Step5PeriksaKlinik({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final klinikStatus = ref
        .watch(pendataanKesehatanProvider)
        .periksaKlinikStatus;
    final notifier = ref.read(pendataanKesehatanProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KlinikStatusSelector(
          selectedStatus: klinikStatus,
          onChanged: (value)=>notifier.setKlinikStatus(value),
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
              style: OutlinedButton.styleFrom(
                fixedSize: Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (context) => const Confirmationcard(),
                );
              },
              child: const Text('cek'),
            ),
            SizedBox(width: AppSpacing.s),
            FilledButton(
              onPressed: () async {
                await notifier.submitData();
                if (context.mounted) {
                  Navigator.pop(context);
                  ref.read(stepcontrollerProviderProvider.notifier).toStep(0);
                }
              },
              child: const Text('Tambahkan'),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _buildRadioOption(
  BuildContext context, {
  required String label,
  required PeriksaKlinikStatus value,
  required PeriksaKlinikStatus groupValue,
  required ValueChanged<PeriksaKlinikStatus> onChanged,
}) {
  return GestureDetector(
    onTap: () => onChanged(value),
    behavior: HitTestBehavior.opaque,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Radio<PeriksaKlinikStatus>(
            value: value,
            groupValue: groupValue,
            onChanged: (v) => onChanged(v!),
            visualDensity: const VisualDensity(
              horizontal: -4,
              vertical: -4,
            ), // lebih kompak
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          const SizedBox(width: 8), // Atur jarak antara radio dan teks di sini
          Expanded(child: Text(label, style: context.textTheme.bodyMedium)),
        ],
      ),
    ),
  );
}
