import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:afiyyah_connect/features/health_input/constants/health_input_strings.dart';
import 'package:afiyyah_connect/features/health_input/model/periksaklinikstatus_model.dart';
import 'package:afiyyah_connect/features/health_input/view/confirmationcard_component.dart';
import 'package:afiyyah_connect/features/health_input/view/statuskunjunganselector_component.dart';
import 'package:afiyyah_connect/features/health_input/view_model/pendataan_kesehatan_provider.dart';
import 'package:afiyyah_connect/features/health_input/view_model/stepcontroller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Step5PeriksaKlinik extends ConsumerWidget {
  static String stepTitle = HealthInputStrings.step5Title;

  const Step5PeriksaKlinik({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendataanState = ref.watch(pendataanKesehatanProvider);
    final klinikStatus = pendataanState.periksaKlinikStatus;
    final isSubmitting = pendataanState.isSubmitting;
    final errorMessage = pendataanState.errorMessage;
    final notifier = ref.read(pendataanKesehatanProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tampilkan error message jika ada
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              errorMessage,
              style: context.textTheme.labelLarge!.copyWith(color: Colors.red),
            ),
          ),
        Visibility(
          visible: klinikStatus == PeriksaKlinikStatus.none,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              HealthInputStrings.emptyClinicCheckInfoMessage,
              style: context.textTheme.labelLarge!.copyWith(color: Colors.red),
            ),
          ),
        ),
        KlinikStatusSelector(
          selectedStatus: klinikStatus,
          onChanged: (value) => notifier.setKlinikStatus(value),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: isSubmitting
                  ? null
                  : () =>
                      ref.read(stepcontrollerProviderProvider.notifier).previous(),
              child: const Text(HealthInputStrings.back),
            ),
            const Spacer(),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                fixedSize: Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: isSubmitting
                  ? null
                  : () {
                      showDialog(
                        useSafeArea: true,
                        context: context,
                        builder: (context) => const Confirmationcard(),
                      );
                    },
              child: const Text(HealthInputStrings.check),
            ),
            SizedBox(width: AppSpacing.s),
            FilledButton(
              onPressed: isSubmitting
                  ? null // Disable tombol saat submitting
                  : () async {
                      if (klinikStatus != PeriksaKlinikStatus.none) {
                        try {
                          await notifier.submitData();
                          // Navigator.pop dan reset stepcontroller dipindah ke dalam try/catch
                          // untuk memastikan hanya dijalankan jika submit berhasil
                          if (context.mounted) {
                            Navigator.pop(context);
                            ref.read(stepcontrollerProviderProvider.notifier).toStep(0);
                          }
                        } catch (e) {
                          // Handle error UI di sini jika perlu
                          // Misalnya, tampilkan SnackBar
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to submit data: $e')),
                            );
                          }
                        }
                      }
                    },
              child: isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text(HealthInputStrings.adding),
            ),
          ],
        ),
      ],
    );
  }
}
