import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:flutter/material.dart';

class ReferralInfoCard extends StatelessWidget {
  final int rujukanId;

  const ReferralInfoCard({super.key, required this.rujukanId});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.local_hospital_outlined, color: Colors.red),
                SizedBox(width: AppSpacing.s),
                Text(
                  'Info Rujukan',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.m),
            FutureBuilder<Map<String, dynamic>>(
              future: _fetchReferral(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return Text(
                    'Tidak ada data rujukan',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  );
                }
                return _buildReferralDetail(context, snapshot.data!);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchReferral() async {
    return {};
  }

  Widget _buildReferralDetail(BuildContext context, Map<String, dynamic> data) {
    if (data.isEmpty) {
      return Text(
        'Tidak ada data rujukan',
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DetailRow(label: 'RS', value: data['rumah_sakit'] ?? '-'),
        _DetailRow(label: 'Tanggal', value: data['tanggal'] ?? '-'),
        _DetailRow(label: 'Status', value: data['status'] ?? '-'),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
