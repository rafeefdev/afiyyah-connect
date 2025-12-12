import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/features/dashboard/view/dashboard_page.dart';
import 'package:afiyyah_connect/features/medical_history/view/history_page.dart';
import 'package:afiyyah_connect/features/monitoring/view/monitoring_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:afiyyah_connect/features/common/view_model/main_layout_view_model.dart';

class MainLayout extends ConsumerWidget {
  final UserModel user;
  const MainLayout({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Daftar halaman yang akan ditampilkan sesuai dengan role dan tab
    final List<Widget> pages = _getPagesForRole(role: user.role);

    final currentIndex = ref.watch(mainLayoutViewModelProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex < pages.length ? currentIndex : 0,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex < pages.length ? currentIndex : 0,
        onDestinationSelected: (index) => ref
            .read(mainLayoutViewModelProvider.notifier)
            .onDestinationSelected(index),
        destinations: _getDestinationsForRole(user.role),
      ),
    );
  }

  // Helper untuk menentukan halaman berdasarkan role
  List<Widget> _getPagesForRole({required Role role}) {
    // TODO: Sesuaikan halaman yang bisa diakses untuk setiap role
    switch (role) {
      case Role.asatidzPiketMaskan:
        return [
          DashboardPage(user: user),
          const MonitoringPage(),
          const HistoryPage(),
        ];
      case Role.resepsionisKlinik:
        return [DashboardPage(user: user), const HistoryPage()];
      case Role.dokter:
        return [const HistoryPage()];
      default:
        return [const Center(child: Text('Role tidak dikenali.'))];
    }
  }

  // Helper untuk menentukan item navigasi berdasarkan role
  List<NavigationDestination> _getDestinationsForRole(Role role) {
    // TODO: Sesuaikan destinasi navigasi untuk setiap role
    switch (role) {
      case Role.asatidzPiketMaskan:
        return const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.send),
            icon: Icon(Icons.send_outlined),
            label: 'Arahan',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.history),
            icon: Icon(Icons.history_outlined),
            label: 'Riwayat',
          ),
        ];
      case Role.resepsionisKlinik:
        return const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.history),
            icon: Icon(Icons.history_outlined),
            label: 'Riwayat',
          ),
        ];
      case Role.dokter:
        return const [
          NavigationDestination(
            selectedIcon: Icon(Icons.history),
            icon: Icon(Icons.history_outlined),
            label: 'Riwayat',
          ),
        ];
      default:
        return [];
    }
  }
}
