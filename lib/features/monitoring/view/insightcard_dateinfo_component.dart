import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:afiyyah_connect/features/common/widgets/dateinfo_component.dart';
import 'package:afiyyah_connect/features/monitoring/constants/monitoring_strings.dart';
import 'package:flutter/material.dart';

class InsightCardDateInfo extends StatelessWidget {
  final int value;

  const InsightCardDateInfo({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Card(
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.m,
            vertical: AppSpacing.m,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                value.toString(),
                style: context.textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: AppSpacing.m),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MonitoringStrings.student,
                    style: context.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    MonitoringStrings.sickInDorm,
                    style: context.textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              DateInfo(
                textTheme: context.textTheme,
                customTextStyle: context.textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
