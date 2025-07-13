import 'package:afiyyah_connect/features/health_input/view/bottomsheet_navigator.dart';
import 'package:flutter/material.dart';

Future<dynamic> showBottomHealthInput(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return BottomSheetNavigator();
      },
    );
  }