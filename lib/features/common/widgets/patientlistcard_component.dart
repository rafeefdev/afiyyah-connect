import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:afiyyah_connect/features/common/utils/get_initials.dart';
import 'package:flutter/material.dart';

class ListCardItem extends StatelessWidget {
  final Santri santri;
  final bool showNotchIndicator;
  final String info;
  final Color? customNotchColor;

  const ListCardItem({
    required this.santri,
    this.showNotchIndicator = false,
    required this.info,
    this.customNotchColor = Colors.red,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String santriInitial = getInitials(santri.name);
    //TODO : implement real kelas
    String kelas = santri.kelasId;
    var notchIndicator = Container(
      width: 8,
      height: 45,
      decoration: BoxDecoration(
        color: customNotchColor,
        borderRadius: BorderRadius.circular(20),
      ),
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, right: 8, top: 8),
        child: Row(
          children: [
            Visibility(visible: showNotchIndicator, child: notchIndicator),
            const SizedBox(width: 16),
            CircleAvatar(child: Text(santriInitial)),
            SizedBox(width: AppSpacing.m),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(santri.name, style: context.textTheme.titleSmall),
                // TODO : display kelas and hujroh
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

class NotchedListCardItem extends ListCardItem {
  const NotchedListCardItem({
    super.key,
    required super.santri,
    required super.info,
  });
}
