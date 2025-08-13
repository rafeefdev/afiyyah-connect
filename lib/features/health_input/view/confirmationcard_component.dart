import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:afiyyah_connect/features/common/widgets/detailinfo_dialog.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/pendataan_kesehatan_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class Confirmationcard extends ConsumerWidget {
  const Confirmationcard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pendataanKesehatanProvider);
    final santri = state.santri;
    final keluhan = state.keluhan.join(', ');
    final sickTime = state.sickStartTime != null
        ? DateFormat('d MMMM y, HH:mm').format(state.sickStartTime!)
        : 'Belum diisi';

    if (santri == null) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              CircleAvatar(child: Icon(Icons.search_off_rounded)),
              Text(
                'Data santri belum ditemukan',
                style: context.textTheme.titleSmall,
              ),
              Text(
                'Mungkin terjadi karena koneksi internet buruk. Hubungi tim pengembang untuk melaporkan bug ini',
                style: context.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return DetailInfoDialog(
      santri: santri,
      keluhan: keluhan,
      sickTime: sickTime,
    );
  }
}
