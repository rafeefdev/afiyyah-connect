import 'package:afiyyah_connect/app/themes/app_themedata.dart';
import 'package:afiyyah_connect/features/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: const DashboardPage(role: 'petugas klinik'),
    );
  }
}
