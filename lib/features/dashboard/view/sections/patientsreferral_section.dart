import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:afiyyah_connect/features/common/widgets/detailinfo_page.dart';
import 'package:afiyyah_connect/features/common/widgets/displayzerodata_component.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:afiyyah_connect/features/dashboard/constants/dashboard_strings.dart';
import 'package:flutter/material.dart';

class PatientsReferralSection extends StatelessWidget {
  final List<Santri> santriReferred;
  const PatientsReferralSection({super.key, required this.santriReferred});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DashboardStrings.hospitalReferralTitle,
          style: context.textTheme.titleMedium,
        ),
        SizedBox(height: AppSpacing.s),
        if (santriReferred.isNotEmpty)
          Column(
            children: List.generate(santriReferred.length, (index) {
              //TODO : real data !
              return ListCardItem(
                santri: Santri.generateDummyData(),
                info: 'Mual, Pusing, batuk, pilek, dll',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailinfoPage(
                        santri: santriReferred[index],
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
            icon: Icons.check_circle_outline_rounded,
            message: DashboardStrings.noReferralsToday,
          ),
      ],
    );
  }
}
