import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extensions.dart';
import 'package:afiyyah_connect/features/common/widgets/dateinfo_component.dart';
import 'package:flutter/material.dart';

class InsightCardNDateInfo extends StatelessWidget {
  final int value;

  const InsightCardNDateInfo({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.l,
          vertical: AppSpacing.m,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value.toString(),
              style: context.textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: AppSpacing.m),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Santri',
                  style: context.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Sakit di Maskan',
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: DateInfo(textTheme: context.textTheme),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
