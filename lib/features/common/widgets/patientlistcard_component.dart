import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:afiyyah_connect/features/common/utils/get_initials.dart';
import 'package:flutter/material.dart';

Widget listCardItem(
  BuildContext context, {
  required Santri santri,
  String status = 'SEGERA RUJUK',
  bool isAlert = true,
  Color customStatusColor = Colors.red,
  required String info,
}) {
  String santriInitial = getInitials(santri.name);
  //TODO : implement real kelas
  String kelas = santri.kelasId;

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(child: Text(santriInitial)),
          SizedBox(width: AppSpacing.m),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(santri.name, style: context.textTheme.titleSmall),
              Text(
                'Kelas 10A • Kamar A-15',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),
              Text(
                info,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          Spacer(),
          FilledButton(onPressed: () {}, child: const Text('proses')),
        ],
      ),
    ),
  );
}
