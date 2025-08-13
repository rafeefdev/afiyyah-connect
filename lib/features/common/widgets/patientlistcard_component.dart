import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/string_extension.dart';
import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListCardItem extends ConsumerWidget {
  final Santri santri;
  final String info;
  final Color? customNotchColor;
  final List<String> keluhan;
  final List<Widget>? additionalTiles;
  final VoidCallback? onTap;

  const ListCardItem({
    required this.santri,
    required this.info,
    this.customNotchColor,
    //TODO : use real keluhan
    this.keluhan = const ['demam', 'batuk', 'pilek'],
    this.additionalTiles,
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //TODO : implement real kelas
    String kelasDanHujroh = santri.namaHujroh ?? 'Belum ada data';

    var notchIndicator = Container(
      width: 8,
      height: 45,
      decoration: BoxDecoration(
        color: customNotchColor,
        borderRadius: BorderRadius.circular(20),
      ),
    );
    return InkWell(
      onTap: onTap ?? () {},
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, right: 8, top: 8),
          child: Row(
            children: [
              Visibility(
                visible: customNotchColor != null,
                child: notchIndicator,
              ),
              const SizedBox(width: 16),
              CircleAvatar(child: Text(santri.nama.getInitials())),
              SizedBox(width: AppSpacing.m),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(santri.nama, style: context.textTheme.titleSmall),
                  // TODO : display kelas and hujroh
                  Text(
                    kelasDanHujroh,
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
            ],
          ),
        ),
      ),
    );
  }
}
