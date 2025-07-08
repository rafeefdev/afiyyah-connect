import 'package:afiyyah_connect/app/themes/app_themedata.dart';
import 'package:afiyyah_connect/features/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: appTheme,
        home: const DashboardPage(role: 'petugas klinik'),
      ),
    );
  }
}
