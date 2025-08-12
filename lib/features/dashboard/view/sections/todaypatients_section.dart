import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:afiyyah_connect/features/common/widgets/displayzerodata_component.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:flutter/material.dart';

class TodaypatientsSection extends StatelessWidget {
  const TodaypatientsSection({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO : real count !
    List<Santri> todayPatients = List.filled(20, Santri.generateDummyData());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Santri Sakit Hari Ini', style: context.textTheme.titleMedium),
        SizedBox(height: AppSpacing.s),
        if (todayPatients.isNotEmpty)
          Column(
            children: List.generate(todayPatients.length, (index) {
              //TODO : real data !
              return ListCardItem(
                santri: Santri.generateDummyData(),
                info: 'Mual, Pusing, batuk, pilek, dll',
              );
            }),
          )
        else
          DisplayZeroData(
            icon: Icons.health_and_safety_rounded,
            message: 'Tidak ada santri sakit hari ini',
          ),
      ],
    );
  }
}
