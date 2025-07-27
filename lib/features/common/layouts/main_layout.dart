import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/features/dashboard/model/dashboard_data.dart';
import 'package:afiyyah_connect/features/dashboard/view/dashboard_page.dart';
import 'package:afiyyah_connect/features/medical_history/view/history_page.dart';
import 'package:afiyyah_connect/features/profile/view/profile_page.dart';
import 'package:afiyyah_connect/features/monitoring/view/monitoring_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:afiyyah_connect/features/common/view_model/main_layout_view_model.dart';

class MainLayout extends ConsumerWidget {
  MainLayout({super.key});

  // Daftar halaman yang akan ditampilkan sesuai dengan tab yang dipilih
  final List<Widget> _pages = <Widget>[
    DashboardPage(role: Role.asatidzPiketMaskan, data: DashboardData.dummy()),
    MonitoringPage(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mendengarkan perubahan indeks dari ViewModel
    final currentIndex = ref.watch(mainLayoutViewModelProvider);

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => ref
            .read(mainLayoutViewModelProvider.notifier)
            .onDestinationSelected(index),
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.send),
            icon: Icon(Icons.send_outlined),
            label: 'Arahan & Rujukan',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.history),
            icon: Icon(Icons.history_outlined),
            label: 'Data & Riwayat',
          ),
        ],
      ),
    );
  }
}
