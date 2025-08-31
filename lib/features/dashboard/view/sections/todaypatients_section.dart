import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:afiyyah_connect/features/common/widgets/detailinfo_page.dart';
import 'package:afiyyah_connect/features/common/widgets/displayzerodata_component.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:afiyyah_connect/features/dashboard/constants/dashboard_strings.dart';
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
        Text(DashboardStrings.todaySickSantriTitle, style: context.textTheme.titleMedium),
        SizedBox(height: AppSpacing.s),
        if (todayPatients.isNotEmpty)
          Column(
            children: List.generate(todayPatients.length, (index) {
              //TODO : real data !
              return ListCardItem(
                santri: Santri.generateDummyData(),
                info: 'Mual, Pusing, batuk, pilek, dll',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailinfoPage(
                        santri: todayPatients[index],
                        keluhan: const [], // TODO: Use real data
                        additionalTiles: const [], // TODO: Use real data
                        sickTime: DateTime(2020),
                      ),
                    ),
                  );
                },
              );
            }),
          )
        else
          DisplayZeroData(
            icon: Icons.health_and_safety_rounded,
            message: DashboardStrings.noSickSantriToday,
          ),
      ],
    );
  }
}
