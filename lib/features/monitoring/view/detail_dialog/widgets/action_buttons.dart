import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/monitoring/view/detail_dialog/health_detail_dialog.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final DetailTab tab;
  final String? pendataanId;
  final int? kunjunganId;
  final int? rujukanId;
  final Role? userRole;

  const ActionButtons({
    super.key,
    required this.tab,
    this.pendataanId,
    this.kunjunganId,
    this.rujukanId,
    this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildButtonsForRole(context),
        SizedBox(height: AppSpacing.m),
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Tutup'),
        ),
      ],
    );
  }

  Widget _buildButtonsForRole(BuildContext context) {
    if (userRole == null) {
      return const SizedBox.shrink();
    }

    return switch (userRole!) {
      Role.asatidzPiketMaskan => _buildAsatidzButtons(context),
      Role.resepsionisKlinik => _buildResepsionisButtons(context),
      Role.dokter => _buildDokterButtons(context),
      Role.unknown => const SizedBox.shrink(),
    };
  }

  Widget _buildAsatidzButtons(BuildContext context) {
    final buttons = <Widget>[];

    if (tab == DetailTab.rujukan && rujukanId != null) {
      buttons.add(
        FilledButton.icon(
          onPressed: () => _scheduleTransport(context),
          icon: const Icon(Icons.directions_car),
          label: const Text('Jadwalkan Pengantaran'),
        ),
      );
    }

    if (buttons.isEmpty) {
      return Text(
        'Tidak ada aksi yang tersedia',
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
        textAlign: TextAlign.center,
      );
    }

    return Wrap(
      spacing: AppSpacing.s,
      runSpacing: AppSpacing.s,
      children: buttons,
    );
  }

  Widget _buildResepsionisButtons(BuildContext context) {
    final buttons = <Widget>[];

    if (tab == DetailTab.periksa && pendataanId != null) {
      buttons.add(
        FilledButton.icon(
          onPressed: () => _createKunjungan(context),
          icon: const Icon(Icons.add),
          label: const Text('Buat Kunjungan'),
        ),
      );
      buttons.add(
        OutlinedButton.icon(
          onPressed: () => _updateStatus(context),
          icon: const Icon(Icons.edit),
          label: const Text('Edit Status'),
        ),
      );
    }

    if (tab == DetailTab.arahan && kunjunganId != null) {
      buttons.add(
        FilledButton.icon(
          onPressed: () => _createRujukan(context),
          icon: const Icon(Icons.local_hospital),
          label: const Text('Rujuk RS'),
        ),
      );
      buttons.add(
        OutlinedButton.icon(
          onPressed: () => _updateStatusIstirahat(context),
          icon: const Icon(Icons.edit_calendar),
          label: const Text('Ubah Status'),
        ),
      );
    }

    if (tab == DetailTab.rujukan && rujukanId != null) {
      buttons.add(
        FilledButton.icon(
          onPressed: () => _scheduleTransport(context),
          icon: const Icon(Icons.directions_car),
          label: const Text('Jadwalkan Pengantaran'),
        ),
      );
      buttons.add(
        OutlinedButton.icon(
          onPressed: () => _inputHasilRujukan(context),
          icon: const Icon(Icons.upload_file),
          label: const Text('Input Hasil'),
        ),
      );
    }

    return Wrap(
      spacing: AppSpacing.s,
      runSpacing: AppSpacing.s,
      children: buttons,
    );
  }

  Widget _buildDokterButtons(BuildContext context) {
    final buttons = <Widget>[];

    if (tab == DetailTab.periksa && pendataanId != null) {
      buttons.add(
        FilledButton.icon(
          onPressed: () => _doPemeriksaan(context),
          icon: const Icon(Icons.medical_services),
          label: const Text('Periksa'),
        ),
      );
    }

    if (tab == DetailTab.arahan && kunjunganId != null) {
      buttons.add(
        FilledButton.icon(
          onPressed: () => _editCatatan(context),
          icon: const Icon(Icons.note_add),
          label: const Text('Edit Catatan'),
        ),
      );
      buttons.add(
        OutlinedButton.icon(
          onPressed: () => _createRujukan(context),
          icon: const Icon(Icons.local_hospital),
          label: const Text('Rujuk RS'),
        ),
      );
    }

    if (tab == DetailTab.rujukan && rujukanId != null) {
      buttons.add(
        OutlinedButton.icon(
          onPressed: () => _viewHasilRujukan(context),
          icon: Icon(Icons.visibility),
          label: const Text('Lihat Hasil'),
        ),
      );
    }

    return Wrap(
      spacing: AppSpacing.s,
      runSpacing: AppSpacing.s,
      children: buttons,
    );
  }

  void _createKunjungan(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur: Buat Kunjungan - Belum implementasi'),
      ),
    );
  }

  void _updateStatus(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur: Edit Status - Belum implementasi')),
    );
  }

  void _createRujukan(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur: Rujuk RS - Belum implementasi')),
    );
  }

  void _updateStatusIstirahat(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur: Ubah Status Istirahat - Belum implementasi'),
      ),
    );
  }

  void _scheduleTransport(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur: Jadwalkan Pengantaran - Belum implementasi'),
      ),
    );
  }

  void _inputHasilRujukan(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur: Input Hasil Rujukan - Belum implementasi'),
      ),
    );
  }

  void _doPemeriksaan(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur: Pemeriksaan - Belum implementasi')),
    );
  }

  void _editCatatan(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur: Edit Catatan - Belum implementasi')),
    );
  }

  void _viewHasilRujukan(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur: Lihat Hasil RS - Belum implementasi'),
      ),
    );
  }
}
