import 'package:afiyyah_connect/app/core/extensions/texttheme_extension.dart';
import 'package:afiyyah_connect/app/core/model/hujroh.dart';
import 'package:afiyyah_connect/app/core/model/kelas.dart';
import 'package:afiyyah_connect/app/core/model/santri.dart';
import 'package:afiyyah_connect/features/common/widgets/displaycard_component.dart';
import 'package:afiyyah_connect/features/common/widgets/patientlistcard_component.dart';
import 'package:afiyyah_connect/features/common/widgets/statcard_component.dart';
import 'package:afiyyah_connect/features/dashboard/alertcardinfo_component.dart';
import 'package:afiyyah_connect/features/dashboard/timeserieschart_component.dart';
import 'package:afiyyah_connect/features/dashboard/timeserieschart_config.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatefulWidget {
  final String role;

  const DashboardPage({required this.role, super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  int selectedTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF3F4F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        title: Text(
          widget.role,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {},
          ),
          const CircleAvatar(
            radius: 16,
            backgroundColor: Colors.white,
            child: Text('A', style: TextStyle(color: Color(0xFF1976D2))),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateHeader(DateTime.now()),
            const SizedBox(height: 16),
            alertCard(
              context,
              title: 'Rujukan Rumah Sakit',
              alertMessage: '3 orang butuh rujukan rumah sakit',
              icon: Icons.local_hospital_rounded,
            ),
            const SizedBox(height: 16),
            _buildHealthStats(),
            const SizedBox(height: 16),
            _buildinsightCharts(),
            const SizedBox(height: 16),
            displayCard(
              context,
              backgroundColor: Color(0xFFE57373),
              label: 'Rujukan Rumah Sakit',
            ),
            const SizedBox(height: 16),
            _buildPatientsList(),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildDateHeader(DateTime date) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        // TODO : fix real DateTime converter
        date.toString(),
        style: context.textTheme.titleMedium,
      ),
    );
  }

  Widget _buildHealthStats() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'Total Sakit',
                value: '78',
                subtitle: '+12% vs minggu lalu',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: 'Kasus Terbanyak',
                value: 'Flu',
                subtitle: '35 siswa terdampak',
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'Butuh Istirahat Maskan',
                value: '23',
                subtitle: 'Disetujui : 18\nPending : 5',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: 'Kasus Baru Hari Ini',
                value: '12',
                subtitle: 'Perlu Kunjungan\n6 kasus flu, 4 demam, 2 lainnya',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildinsightCharts() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TabBar(
            controller: tabController,
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            dividerHeight: 0,
            labelStyle: context.textTheme.bodyMedium,
            tabs: [
              Tab(text: 'Ikhtisar'),
              Tab(text: 'Kelas'),
              Tab(text: 'Gedung'),
              Tab(text: 'Penyakit'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 320,
          child: TabBarView(
            controller: tabController,
            children: [
              Timeserieschart(
                title: 'Tren Mingguan',
                healthScores: [12, 23, 24, 8, 12, 17],
                config: ChartConfig(),
              ),
              Center(child: const Text('Kelas')),
              Center(child: const Text('Gedung')),
              Center(child: const Text('Penyakit')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPatientsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        patientCard(
          santri: Santri(
            name: 'John Doe',
            tahunMasuk: DateTime(2019),
            hujroh: Hujroh.aleppo,
            kelas: Kelas.viia1,
          ),
          condition: 'Demam tinggi 40°C 1 hari',
          avatar: 'IM',
          status: 'SEGERA RUJUK',
          statusColor: const Color(0xFFFF9800),
        ),
        const SizedBox(height: 8),
        patientCard(
          santri: Santri(
            name: 'John Doe',
            tahunMasuk: DateTime(2019),
            hujroh: Hujroh.damaskus,
            kelas: Kelas.xia2,
          ),
          condition: 'Flu berat 5 + Batuk 4 hari',
          avatar: 'AP',
          status: 'SEGERA RUJUK',
          statusColor: const Color(0xFFFF9800),
        ),
        patientCard(
          santri: Santri(
            name: 'John Doe',
            tahunMasuk: DateTime(2019),
            hujroh: Hujroh.gazza,
            kelas: Kelas.viia1,
          ),
          condition: 'Sakit THT • Flu • 2 hari',
          avatar: 'AS',
          status: 'SEGERA RUJUK',
          statusColor: const Color(0xFF4CAF50),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[600],
        shape: BoxShape.circle,
      ),
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF1976D2),
      unselectedItemColor: Colors.grey,
      currentIndex: selectedTabIndex,
      onTap: (index) {
        setState(() {
          selectedTabIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Beranda'),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Hari & Minggu',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Anak'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Profil'),
      ],
    );
  }
}
