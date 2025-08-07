import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/app/themes/app_themedata.dart';
import 'package:afiyyah_connect/features/auth/repository/auth_repository.dart';
import 'package:afiyyah_connect/features/auth/view/auth_page.dart';
import 'package:afiyyah_connect/features/auth/view_model/app_user_provider.dart';
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
    authOptions: const FlutterAuthClientOptions(authFlowType: AuthFlowType.pkce),
  );

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: appTheme,
      home: const AuthWrapper(),
    );
  }
}

// Widget ini HANYA bertanggung jawab untuk memeriksa status otentikasi.
class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);

    return authState.when(
      data: (state) {
        if (state.session != null) {
          // Pengguna sudah login, serahkan ke MainLayoutWrapper untuk mengambil profil.
          return const MainLayoutWrapper();
        } else {
          // Pengguna belum login.
          return const AuthPage();
        }
      },
      loading: () => const Scaffold(body: Center(child: LoadingIndicator(isLoading: true))),
      error: (err, st) => Scaffold(body: Center(child: Text("Authentication Error: $err"))),
    );
  }
}

// Widget ini HANYA bertanggung jawab untuk mengambil profil PENGGUNA YANG SUDAH LOGIN.
class MainLayoutWrapper extends ConsumerWidget {
  const MainLayoutWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUserState = ref.watch(appUserProvider);

    return appUserState.when(
      data: (user) {
        if (user != null) {
          // Profil berhasil didapatkan.
          return MainLayout(user: user);
        }
        // Ini bisa terjadi jika user ada di Supabase auth tapi tidak di tabel 'profiles'.
        return Scaffold(body: Center(child: Text("Gagal mengambil data pengguna.")));
      },
      loading: () => const Scaffold(body: Center(child: LoadingIndicator(isLoading: true))),
      error: (err, st) => Scaffold(body: Center(child: Text("Error loading profile: $err"))),
    );
  }
}