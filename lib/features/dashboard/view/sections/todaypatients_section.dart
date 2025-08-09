import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:flutter/material.dart';

class TodaypatientsSection extends StatelessWidget {
  const TodaypatientsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Santri Sakit Hari Ini', style: context.textTheme.titleMedium),
        SizedBox(height: AppSpacing.s),
        Column(
          children: List.generate(
            3,
            (index) => ListCardItem(
              santri: Santri.generateDummyData(),
              info: 'Mual, Pusing, batuk, pilek, dll',
            ),
          ),
        ),
      ],
    );
  }
}
