// lib/features/auth/repository/auth_repository.dart

import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_repository.g.dart';

// Interface (Abstract Class) untuk AuthRepository
// Ini mendefinisikan 'kontrak' atau fungsi apa saja yang harus dimiliki oleh repositori otentikasi.
abstract class AuthRepository {
  /// Mengecek apakah email yang diberikan diizinkan untuk login.
  Future<bool> isEmailAllowed(String email);

  /// Mengirimkan magic link untuk proses login tanpa kata sandi.
  Future<void> sendMagicLink(String email);

  /// Mendapatkan stream perubahan status otentikasi (misalnya, login, logout).
  Stream<AuthState> get authStateChanges;

  /// Mendapatkan sesi pengguna saat ini jika ada.
  Session? get currentSession;

  /// Proses logout pengguna.
  Future<void> signOut();
}

// Implementasi konkret dari AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _supabase;

  // Konstruktor yang menerima instance SupabaseClient.
  // Ini memungkinkan kita untuk 'menyuntikkan' dependensi, membuatnya lebih mudah untuk diuji.
  AuthRepositoryImpl(this._supabase);

  @override
  Future<bool> isEmailAllowed(String email) async {
    // Memanggil Remote Procedure Call (RPC) di Supabase untuk validasi email.
    final response = await _supabase.rpc(
      'is_email_allowed',
      params: {'input_email': email},
    );
    // Mengembalikan true jika response adalah true, jika tidak, false.
    return response as bool? ?? false;
  }

  @override
  Future<void> sendMagicLink(String email) async {
    // Menggunakan Supabase Auth untuk mengirim One-Time Password (OTP) via email (Magic Link).
    await _supabase.auth.signInWithOtp(
      email: email,
      // TODO: Tambahkan email redirect URL yang benar untuk deep linking
      // emailRedirectTo: 'io.supabase.flutterquickstart://login-callback/',
    );
  }

  @override
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  @override
  Session? get currentSession => _supabase.auth.currentSession;

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}

// Provider Riverpod untuk instance AuthRepository.
// Ini memungkinkan widget/provider lain untuk mengakses AuthRepository.
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  // Mengambil supabaseClient dari provider lain dan menyuntikkannya ke AuthRepositoryImpl.
  final supabase = ref.watch(supabaseClientProvider);
  return AuthRepositoryImpl(supabase);
}

// Provider Riverpod untuk stream status otentikasi.
// Ini akan secara otomatis memberi tahu listener setiap kali status otentikasi berubah.
@riverpod
Stream<AuthState> authStateChanges(AuthStateChangesRef ref) {
  // Mengawasi authRepositoryProvider dan mengembalikan stream authStateChanges-nya.
  return ref.watch(authRepositoryProvider).authStateChanges;
}
