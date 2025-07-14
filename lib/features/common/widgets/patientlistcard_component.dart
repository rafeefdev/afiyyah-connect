import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:afiyyah_connect/features/common/utils/get_initials.dart';
import 'package:flutter/material.dart';

class ListCardItem extends StatelessWidget {
  final Santri santri;
  final bool isAlert;
  final String info;

  const ListCardItem({
    required this.santri,
    this.isAlert = false,
    required this.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String santriInitial = getInitials(santri.name);
    //TODO : implement real kelas
    String kelas = santri.kelasId;
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, right: 8, top: 8),
        child: Row(
          children: [
            Visibility(
              visible: isAlert,
              child: Container(
                width: 8,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(width: 16),
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
            // Spacer(),
            // FilledButton(
            //   onPressed: () {},
            //   child: const Text('proses'),
            // ),
          ],
        ),
      ),
    );
  }
}