import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatefulWidget {
  final String role;

  const DashboardPage({required this.role, super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
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
              title: 'Rujukan Rumah Sakit',
              alertMessage: '3 orang butuh rujukan rumah sakit',
              icon: Icons.local_hospital_rounded,
            ),
            const SizedBox(height: 16),
            _buildHealthStats(),
            const SizedBox(height: 16),
            _buildTrendChart(),
            const SizedBox(height: 16),
            _buildRujukanButton(),
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
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget alertCard({
    required String title,
    required String alertMessage,
    IconData icon = Icons.dangerous_rounded,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE57373), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFFE57373)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFD32F2F),
                  ),
                ),
                Text(
                  alertMessage,
                  style: TextStyle(fontSize: 12, color: Color(0xFFD32F2F)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFD32F2F),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'Lihat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Sakit',
            value: '78',
            subtitle: 'Orang mengalami sakit',
            color: const Color(0xFFE57373),
            icon: Icons.sick,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Flu',
            value: '49',
            subtitle: 'Anak terkena influenza',
            color: const Color(0xFF64B5F6),
            icon: Icons.coronavirus,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600, color: color),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tren Mingguan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3),
                      FlSpot(1, 5),
                      FlSpot(2, 4),
                      FlSpot(3, 6),
                      FlSpot(4, 4),
                      FlSpot(5, 3),
                      FlSpot(6, 2),
                    ],
                    isCurved: true,
                    color: const Color(0xFF1976D2),
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Grafik: Tingkat Sehat tertinggi adalah pada hari Minggu, menunjukkan pola yang konsisten dengan jadwal istirahat.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildRujukanButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE57373),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Rujukan Rumah Sakit',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildPatientsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SEDANG SAKIT',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        _buildPatientCard(
          name: 'Iriya Muhammad',
          condition: 'Demam tinggi 40°C 1 hari',
          avatar: 'IM',
          status: 'Proses',
          statusColor: const Color(0xFFFF9800),
        ),
        const SizedBox(height: 8),
        _buildPatientCard(
          name: 'Ahmad Pratama',
          condition: 'Flu berat 5 + Batuk 4 hari',
          avatar: 'AP',
          status: 'Proses',
          statusColor: const Color(0xFFFF9800),
        ),
        const SizedBox(height: 16),
        const Text(
          'SUDAH SAKIT HARI INI',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        _buildPatientCard(
          name: 'Ahmad S.',
          condition: 'Sakit THT • Flu • 2 hari',
          avatar: 'AS',
          status: 'Sehat',
          statusColor: const Color(0xFF4CAF50),
        ),
        const SizedBox(height: 8),
        _buildPatientCard(
          name: 'Budi P.',
          condition: 'Sakit THT • Demam • 1 hari',
          avatar: 'BP',
          status: 'Sehat',
          statusColor: const Color(0xFF4CAF50),
        ),
        const SizedBox(height: 8),
        _buildPatientCard(
          name: 'Cindy R.',
          condition: 'Sakit Perut • Mual • 1 hari',
          avatar: 'CR',
          status: 'Sehat',
          statusColor: const Color(0xFF4CAF50),
        ),
      ],
    );
  }

  Widget _buildPatientCard({
    required String name,
    required String condition,
    required String avatar,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF1976D2),
            child: Text(
              avatar,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  condition,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
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
