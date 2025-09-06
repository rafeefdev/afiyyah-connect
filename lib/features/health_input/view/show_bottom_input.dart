import 'package:afiyyah_connect/features/health_input/view/bottomsheet_navigator.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/pendataan_kesehatan_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<dynamic> showBottomHealthInput(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) {
      return BottomSheetNavigator();
    },
  ).then((value) {
    ref.read(pendataanKesehatanProvider.notifier).reset();
  });
}
