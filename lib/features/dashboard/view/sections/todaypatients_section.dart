import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:flutter/material.dart';

class TodaypatientsSection extends StatelessWidget {
  const TodaypatientsSection({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO : real count !
    int patientCount = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Santri Sakit Hari Ini', style: context.textTheme.titleMedium),
        SizedBox(height: AppSpacing.s),
        if (patientCount > 0)
          Column(
            children: List.generate(patientCount, (index) {
              //TODO : real data !
              return ListCardItem(
                santri: Santri.generateDummyData(),
                info: 'Mual, Pusing, batuk, pilek, dll',
              );
            }),
          )
        else
          Container(
            width: context.mq.size.width,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black54,
                width: 0.2,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                Icon(Icons.health_and_safety_rounded, color: Colors.blueGrey),
                Text(
                  'Tidak ada santri sakit\nhari ini',
                  textAlign: TextAlign.center,

                  style: context.textTheme.bodyLarge!.copyWith(
                    color: Colors.blueGrey,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
