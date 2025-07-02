import 'package:afiyyah_connect/features/common/widgets/statcard_component.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class DashboardPage extends StatefulWidget {
  final String role;
  const DashboardPage({required this.role, super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.typography;

    return FScaffold(
      header: FHeader(title: const Text('Beranda')),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              DateTime.now().toString(),
              style: textTheme.base.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            FAlert(
              title: const Text('Rujukan Rumah Sakit'),
              subtitle: const Text('2 Santri butuh penangangan rumah sakit'),
              icon: Icon(FIcons.badgeAlert),
              style: FAlertStyle.destructive,
            ),
            SizedBox(height: 16),
            Row(
              spacing: 8,
              children: [
                insightCard(
                  textTheme,
                  title: 'Total Sakit',
                  value: '78',
                  explanation: '+12% dari pekan lalu',
                ),
                insightCard(
                  textTheme,
                  title: 'Kasus Terbanyak',
                  value: 'Flu',
                  explanation: '35 siswa terdampak',
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              spacing: 8,
              children: [
                insightCard(
                  textTheme,
                  title: 'Butuh Istirahat Maskan',
                  value: '23',
                  explanation: 'Disetujui : 18\nPending : 5',
                ),
                insightCard(
                  textTheme,
                  title: 'Kasus Hari Ini',
                  value: '12',
                  explanation: '6 Kasus flu, 4 demam, 2 lainnya',
                ),
              ],
            ),
            const SizedBox(height: 16),
            FTabs(
              children: [
                FTabEntry(
                  label: const Text('Ikhtisar'),
                  child: FCard(child: const Text('Weekly Tren')),
                ),
                FTabEntry(
                  label: const Text('Kelas'),
                  child: FCard(
                    child: const Text('Disease Distribution on Clases'),
                  ),
                ),
                FTabEntry(
                  label: const Text('Gedung'),
                  child: FCard(
                    child: const Text(
                      'Grafik Distribusi Penyakit berdasarkan gedung ',
                    ),
                  ),
                ),
                FTabEntry(
                  label: const Text('Penyakit'),
                  child: FCard(
                    child: const Text('Grafik persebaran jenis penyakit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget insightCard(
    FTypography textTheme, {
    required String title,
    required String value,
    required String explanation,
  }) {
    return Expanded(
      child: SizedBox(
        height: 144,
        child: FCard(
          title: Text(title),
          subtitle: Text(value),
          style: FCardStyle(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.065),
              borderRadius: BorderRadius.circular(10),
            ),
            contentStyle: FCardContentStyle(
              titleTextStyle: textTheme.base.copyWith(
                fontWeight: FontWeight.w300,
              ),
              subtitleTextStyle: textTheme.xl2.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fontSize = 12;
              if (constraints.maxWidth < 150) {
                fontSize = 10;
              } else if (constraints.maxWidth < 100) {
                fontSize = 8;
              }
              return Text(
                explanation,
                style: context.theme.typography.sm,
                overflow: TextOverflow.visible,
              );
            },
          ),
        ),
      ),
    );
  }
}
