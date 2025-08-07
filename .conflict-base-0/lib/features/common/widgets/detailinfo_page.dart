import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:afiyyah_connect/features/health_input/data/model/periksaklinikstatus_model.dart';
import 'package:afiyyah_connect/features/monitoring/model/detailpageinfos_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailinfoPage extends StatelessWidget {
  final Santri santri;
  final List<String> keluhan;
  final DateTime sickTime;
  final bool isMedicated;
  final List<Widget> additionalTiles;
  final PeriksaKlinikStatus periksaKlinikStatus;
  final Role role;
  final DetailPageInfosStyle detailPageInfosStyle;

  const DetailinfoPage({
    required this.santri,
    required this.keluhan,
    required this.sickTime,
    this.isMedicated = false,
    this.additionalTiles = const [],
    this.periksaKlinikStatus = PeriksaKlinikStatus.none,
    required this.role,
    this.detailPageInfosStyle = DetailPageInfosStyle.standard,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('HH:mm, EEEE\nd MMMM y', 'id_ID');

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: ListView(
          padding: AppSpacing.pagePadding,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 8),
            _buildBody(dateFormat),
            const SizedBox(height: 32),
            _buildBottomAction(role: role),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAction({required Role role}) {
    List<Widget> bottomButtons = [];

    switch (role) {
      // TODO : add filter to case for santri condition where have go to clinic
      case Role.asatidzPiketMaskan:
        bottomButtons = [
          OutlinedButton(onPressed: () {}, child: const Text('Delegasikan')),
          FilledButton(onPressed: () {}, child: const Text('Antar')),
        ];
      case Role.resepsionisKlinik:
        bottomButtons = [
          // FilledButton(onPressed: () {}, child: const Text('')),
          FilledButton(onPressed: () {}, child: const Text('Konfirmasi')),
        ];
      default:
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 8,
      children: bottomButtons,
    );
  }

  Widget _buildBody(DateFormat dateFormat) {
    String kunjunganKlinikStatus =
        periksaKlinikStatus == PeriksaKlinikStatus.none
        ? 'tanpa keterangan'
        : periksaKlinikStatus.name;
    return Column(
      children: [
        ListTile(
          title: const Text('Keluhan'),
          subtitle: Text(
            keluhan.join(', ').toString(),
            overflow: TextOverflow.ellipsis,
          ),
          leading: Icon(Icons.sick_rounded, color: Colors.grey.shade700),
          // trailing: IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.edit, color: Colors.grey.shade400),
          // ),
        ),
        ListTile(
          title: const Text('Mulai Sakit'),
          subtitle: Text(dateFormat.format(sickTime)),
          leading: Icon(Icons.schedule_rounded, color: Colors.grey.shade700),
        ),
        ListTile(
          title: const Text('Kunjungan Klinik'),
          subtitle: Text(kunjunganKlinikStatus),
          leading: Icon(
            Icons.local_hospital_rounded,
            color: Colors.grey.shade700,
          ),
        ),
        ListTile(
          title: const Text('Sudah konsumsi obat'),
          subtitle: Text(isMedicated ? 'Sudah' : 'Belum'),
          leading: Icon(Icons.medication_rounded, color: Colors.grey.shade700),
        ),
        ...additionalTiles,
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey[300],
          child: const Icon(Icons.person, size: 40, color: Colors.grey),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                santri.nama,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                santri.namaHujroh ?? 'Belum ada data hujroh',
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
