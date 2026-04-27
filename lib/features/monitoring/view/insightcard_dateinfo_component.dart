import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:afiyyah_connect/features/common/widgets/dateinfo_component.dart';
import 'package:afiyyah_connect/features/monitoring/constants/monitoring_strings.dart';
import 'package:afiyyah_connect/features/monitoring/view_model/monitoring_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

class InsightCardDateInfo extends ConsumerWidget {
  const InsightCardDateInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalSantriSakit = ref.watch(totalSantriSakitProvider);

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
              totalSantriSakit.when(
                data: (total) => Text(
                  total.toString(),
                  style: context.textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) {
                  Logger log = LoggerService.getLogger("totalSakitToday");
                  log.warning("error occured : $stackTrace");
                  return Icon(Icons.error_outline);
                },
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
