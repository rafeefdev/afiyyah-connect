import 'package:afiyyah_connect/app/themes/app_themedata.dart';
import 'package:afiyyah_connect/features/auth/repository/auth_repository.dart';
import 'package:afiyyah_connect/features/auth/view/auth_page.dart';
import 'package:afiyyah_connect/features/common/layouts/main_layout.dart';
import 'package:afiyyah_connect/features/common/widgets/loadingindicator_component.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: appTheme,
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mendengarkan stream perubahan status otentikasi
    final authState = ref.watch(authStateChangesProvider);

    return authState.when(
      data: (state) {
        // Jika ada sesi yang aktif (pengguna sudah login)
        if (state.session != null) {
          return MainLayout();
        }
        // Jika tidak ada sesi (pengguna belum login)
        return const AuthPage();
      },
      // Tampilkan loading indicator saat stream sedang menunggu data awal
      loading: () => const Scaffold(
        body: Center(child: LoadingIndicator(isLoading: true)),
      ),
      // Tampilkan pesan error jika terjadi masalah pada stream
      error: (error, stackTrace) =>
          Scaffold(body: Center(child: Text('Terjadi kesalahan: $error'))),
    );
  }
}
