// lib/features/auth/repository/auth_repository.dart

import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// Mengimpor paket Supabase dengan alias 'supabase' untuk menghindari konflik nama.
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<bool> isEmailAllowed(String email);
  Future<void> sendMagicLink(String email);
  // Tipe data dikoreksi untuk menggunakan AuthState dari paket Supabase.
  Stream<supabase.AuthState> get authStateChanges;
  // Tipe data dikoreksi untuk menggunakan Session dari paket Supabase.
  supabase.Session? get currentSession;
  Future<void> signOut();

  Future<UserModel> fetchUserProfile();
}

class AuthRepositoryImpl implements AuthRepository {
  // Tipe data dikoreksi untuk menggunakan SupabaseClient dari paket Supabase.
  final supabase.SupabaseClient _supabase;
  AuthRepositoryImpl(this._supabase);

  @override
  Future<bool> isEmailAllowed(String email) async {
    final response = await _supabase.rpc(
      'is_email_allowed',
      params: {'input_email': email},
    );
    return response as bool? ?? false;
  }

  @override
  Future<void> sendMagicLink(String email) async {
    await _supabase.auth.signInWithOtp(
      email: email,
      emailRedirectTo: 'com.example.afiyyah_connect://login-callback',
      // emailRedirectTo: 'io.supabase.flutterquickstart://login-callback/',
    );
  }

  @override
  // Tipe data kembalian dikoreksi.
  Stream<supabase.AuthState> get authStateChanges =>
      _supabase.auth.onAuthStateChange;

  @override
  // Tipe data kembalian dikoreksi.
  supabase.Session? get currentSession => _supabase.auth.currentSession;

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  @override
  Future<UserModel> fetchUserProfile() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('Tidak ada pengguna yang sedang login.');
      }

      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      return UserModel.fromJson(response);
    } catch (e) {
      throw Exception('Gagal mengambil profil pengguna: $e');
    }
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return AuthRepositoryImpl(supabase);
}

@riverpod
// Tipe data kembalian stream pada provider juga dikoreksi.
Stream<supabase.AuthState> authStateChanges(AuthStateChangesRef ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}
