import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:flutter/material.dart';

class KelasTabview extends StatelessWidget {
  const KelasTabview({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: AppSpacing.m),
        child: Center(child: Text('Disease Distribution on Clases')),
      ),
    );
  }
}
