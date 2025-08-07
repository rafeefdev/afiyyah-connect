import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:afiyyah_connect/features/health_input/view/input_bottomsheet/step1_carisantri.dart';
import 'package:afiyyah_connect/features/health_input/view/input_bottomsheet/step2_pilihsantri.dart';
import 'package:afiyyah_connect/features/health_input/view/input_bottomsheet/step3_keluhan.dart';
import 'package:afiyyah_connect/features/health_input/view/input_bottomsheet/step4_sejakkapan.dart';
import 'package:afiyyah_connect/features/health_input/view/input_bottomsheet/step5_periksaklinik.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/stepcontroller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> steps = [
  Step1CariSantri(),
  Step2PilihSantri(),
  Step3Keluhan(keluhanList: keluhanList),
  Step4SejakKapan(),
  Step5PeriksaKlinik(),
];

List<String> titles = [
  'Cari Nama Santri',
  'Pilih Santri',
  'Apa saja keluhannya ?',
  'Sejak Kapan Sakitnya ?',
  'Periksa Klinik',
];

class BottomSheetNavigator extends ConsumerWidget {
  const BottomSheetNavigator({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentStep = ref.watch(stepcontrollerProviderProvider);

    return AnimatedPadding(
      duration: Duration(milliseconds: 50),
      padding: EdgeInsets.only(
        left: AppSpacing.xl,
        right: AppSpacing.xl,
        bottom: context.viewInset.bottom + 48,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titles[currentStep], style: context.textTheme.titleLarge),
          SizedBox(height: AppSpacing.xs),
          LinearProgressIndicator(value: (currentStep + 1) / 5),
          Text('${currentStep + 1} / 5'),
          SizedBox(height: AppSpacing.m),
          Consumer(builder: (context, ref, _) => steps[currentStep]),
        ],
      ),
    );
  }
}
