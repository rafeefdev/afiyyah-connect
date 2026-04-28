import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/auth/view_model/app_user_provider.dart';
import 'package:afiyyah_connect/features/monitoring/view/detail_dialog/health_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientDetailPage extends ConsumerWidget {
  final String? pendataanId;
  final int? kunjunganId;
  final int? rujukanId;
  final DetailTab tab;
  final String? namaSantri;
  final String? namaHujroh;
  final int? jenjang;

  const PatientDetailPage({
    super.key,
    this.pendataanId,
    this.kunjunganId,
    this.rujukanId,
    required this.tab,
    this.namaSantri,
    this.namaHujroh,
    this.jenjang,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRole = ref.watch(appUserProvider).valueOrNull?.role;

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStudentSection(context),
            SizedBox(height: AppSpacing.m),
            _buildMedicalSection(context),
            SizedBox(height: AppSpacing.m),
            _buildDataSection(context),
            SizedBox(height: AppSpacing.l),
          ],
        ),
      ),
      bottomNavigationBar: _buildActionButtons(context, userRole),
    );
  }

  String _getTitle() {
    return switch (tab) {
      DetailTab.periksa => 'Detail Pemeriksaan',
      DetailTab.arahan => 'Detail Arahan',
      DetailTab.rujukan => 'Detail Rujukan RS',
    };
  }

  Widget _buildStudentSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.m),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.person,
                size: 32,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            SizedBox(width: AppSpacing.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    namaSantri ?? '-',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Hujroh ${namaHujroh ?? '-'} • Jenjang ${jenjang ?? '-'}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.favorite_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: AppSpacing.s),
                Text(
                  'Riwayat Medis',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.m),
            Text(
              'Golongan Darah: -',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text('Alergi: -', style: Theme.of(context).textTheme.bodyMedium),
            Text(
              'Penyakit Kronis: -',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataSection(BuildContext context) {
    final sectionTitle = switch (tab) {
      DetailTab.periksa => 'Data Pendataan',
      DetailTab.arahan => 'Data Kunjungan',
      DetailTab.rujukan => 'Data Rujukan',
    };

    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.history,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(width: AppSpacing.s),
                Text(
                  sectionTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.m),
            if (tab == DetailTab.periksa) ...[
              _buildInfoRow('Keluhan:', '-'),
              _buildInfoRow('Waktu Mulai:', '-'),
              _buildInfoRow('Status:', 'Belum Diperiksa'),
            ] else if (tab == DetailTab.arahan) ...[
              _buildInfoRow('Status Pengarahan:', 'Istirahat Asrama'),
              _buildInfoRow('Mulai Istirahat:', '-'),
              _buildInfoRow('Selesai Istirahat:', '-'),
              _buildInfoRow('Catatan:', '-'),
            ] else ...[
              _buildInfoRow('Rumah Sakit:', '-'),
              _buildInfoRow('Tanggal Rujukan:', '-'),
              _buildInfoRow('Diagnosis:', '-'),
              _buildInfoRow('Status Pengantaran:', 'Belum Diantar'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, Role? userRole) {
    if (userRole == null) {
      return const SizedBox.shrink();
    }

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.m),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _getButtonsForRole(context, userRole),
        ),
      ),
    );
  }

  List<Widget> _getButtonsForRole(BuildContext context, Role userRole) {
    final buttons = <Widget>[];

    if (userRole == Role.asatidzPiketMaskan) {
      if (tab == DetailTab.periksa) {
        buttons.addAll([
          FilledButton.icon(
            onPressed: () => _handleEdit(context),
            icon: const Icon(Icons.edit),
            label: const Text('Edit'),
          ),
          SizedBox(height: AppSpacing.s),
          OutlinedButton.icon(
            onPressed: () => _handleDelete(context),
            icon: const Icon(Icons.delete),
            label: const Text('Hapus'),
            style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
          ),
        ]);
      } else if (tab == DetailTab.rujukan) {
        buttons.add(
          FilledButton.icon(
            onPressed: () => _handleScheduleTransport(context),
            icon: const Icon(Icons.directions_car),
            label: const Text('Jadwalkan Pengantaran'),
          ),
        );
      }
    } else if (userRole == Role.resepsionisKlinik) {
      if (tab == DetailTab.periksa) {
        buttons.addAll([
          FilledButton.icon(
            onPressed: () => _handleCreateKunjungan(context),
            icon: const Icon(Icons.add),
            label: const Text('Buat Kunjungan'),
          ),
          SizedBox(height: AppSpacing.s),
          OutlinedButton.icon(
            onPressed: () => _handleUpdateStatus(context),
            icon: const Icon(Icons.edit),
            label: const Text('Edit Status'),
          ),
        ]);
      } else if (tab == DetailTab.arahan) {
        buttons.addAll([
          FilledButton.icon(
            onPressed: () => _handleCreateRujukan(context),
            icon: const Icon(Icons.local_hospital),
            label: const Text('Rujuk RS'),
          ),
          SizedBox(height: AppSpacing.s),
          OutlinedButton.icon(
            onPressed: () => _handleUpdateStatusIstirahat(context),
            icon: const Icon(Icons.edit_calendar),
            label: const Text('Ubah Status'),
          ),
        ]);
      } else if (tab == DetailTab.rujukan) {
        buttons.addAll([
          FilledButton.icon(
            onPressed: () => _handleScheduleTransport(context),
            icon: const Icon(Icons.directions_car),
            label: const Text('Jadwalkan Pengantaran'),
          ),
          SizedBox(height: AppSpacing.s),
          OutlinedButton.icon(
            onPressed: () => _handleInputHasil(context),
            icon: const Icon(Icons.upload_file),
            label: const Text('Input Hasil'),
          ),
        ]);
      }
    } else if (userRole == Role.dokter) {
      if (tab == DetailTab.periksa) {
        buttons.add(
          FilledButton.icon(
            onPressed: () => _handlePemeriksaan(context),
            icon: const Icon(Icons.medical_services),
            label: const Text('Periksa'),
          ),
        );
      } else if (tab == DetailTab.arahan) {
        buttons.addAll([
          FilledButton.icon(
            onPressed: () => _handleEditCatatan(context),
            icon: const Icon(Icons.note_add),
            label: const Text('Edit Catatan'),
          ),
          SizedBox(height: AppSpacing.s),
          OutlinedButton.icon(
            onPressed: () => _handleCreateRujukan(context),
            icon: const Icon(Icons.local_hospital),
            label: const Text('Rujuk RS'),
          ),
        ]);
      } else if (tab == DetailTab.rujukan) {
        buttons.add(
          OutlinedButton.icon(
            onPressed: () => _handleViewHasil(context),
            icon: const Icon(Icons.visibility),
            label: const Text('Lihat Hasil'),
          ),
        );
      }
    }

    return buttons;
  }

  void _handleEdit(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur: Edit - Belum implementasi')),
    );
  }

  void _handleDelete(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur: Hapus - Belum implementasi')),
    );
  }

  void _handleCreateKunjungan(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur: Buat Kunjungan - Belum implementasi'),
      ),
    );
  }

  void _handleUpdateStatus(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur: Edit Status - Belum implementasi')),
    );
  }

  void _handleCreateRujukan(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur: Rujuk RS - Belum implementasi')),
    );
  }

  void _handleUpdateStatusIstirahat(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur: Ubah Status Istirahat - Belum implementasi'),
      ),
    );
  }

  void _handleScheduleTransport(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur: Jadwalkan Pengantaran - Belum implementasi'),
      ),
    );
  }

  void _handleInputHasil(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur: Input Hasil - Belum implementasi')),
    );
  }

  void _handlePemeriksaan(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur: Pemeriksaan - Belum implementasi')),
    );
  }

  void _handleEditCatatan(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur: Edit Catatan - Belum implementasi')),
    );
  }

  void _handleViewHasil(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur: Lihat Hasil - Belum implementasi')),
    );
  }
}
