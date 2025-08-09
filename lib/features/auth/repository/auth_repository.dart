// lib/features/auth/repository/auth_repository.dart

import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// Mengimpor paket Supabase dengan alias 'supabase' untuk menghindari konflik nama.
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<bool> isEmailAllowed(String email);
  Future<void> sendOtp(String email);
  Future<void> verifyOtp({required String email, required String otp});
  // Tipe data dikoreksi untuk menggunakan AuthState dari paket Supabase.
  Stream<supabase.AuthState> get authStateChanges;
  // Tipe data dikoreksi untuk menggunakan Session dari paket Supabase.
  supabase.Session? get currentSession;
  Future<void> signOut();

  Future<UserModel> fetchUserProfile();
  Future<void> updateUserName(String newName);
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
  Future<void> sendOtp(String email) async {
    await _supabase.auth.signInWithOtp(
      email: email,
    );
  }

  @override
  Future<void> verifyOtp({required String email, required String otp}) async {
    await _supabase.auth.verifyOTP(
      type: supabase.OtpType.email,
      token: otp,
      email: email,
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
      final currentUser = _supabase.auth.currentUser;
      if (currentUser == null) {
        throw Exception('Tidak ada pengguna yang sedang login.');
      }
      if (currentUser.email == null) {
        throw Exception('Email pengguna tidak ditemukan.');
      }

      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', currentUser.id)
          .single();

      return UserModel.fromProfile(
        profileJson: response,
        email: currentUser.email!,
      );
    } catch (e) {
      throw Exception('Gagal mengambil profil pengguna: $e');
    }
  }

  @override
  Future<void> updateUserName(String newName) async {
    try {
      await _supabase.rpc(
        'update_user_name',
        params: {'new_name': newName},
      );
    } catch (e) {
      throw Exception('Gagal memperbarui nama pengguna: $e');
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
