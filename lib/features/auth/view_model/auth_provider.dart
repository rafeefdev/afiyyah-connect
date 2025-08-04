// features/auth/viewmodel/auth_provider.dart

import 'dart:async';

import 'package:afiyyah_connect/features/auth/model/authstate_model.dart';
import 'package:afiyyah_connect/features/auth/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthProvider extends _$AuthProvider {
  @override
  AuthState build() {
    // State awal diatur ke idle
    return AuthState(AuthStatus.idle);
  }

  // Fungsi untuk login dengan email
  Future<void> loginWithEmail(String email) async {
    // Mengambil AuthRepository
    final authRepository = ref.read(authRepositoryProvider);
    
    // Mengatur state ke loading
    state = AuthState(AuthStatus.loading);

    try {
      // Memeriksa apakah email diizinkan
      final isAllowed = await authRepository.isEmailAllowed(email);
      if (!isAllowed) {
        state = AuthState(AuthStatus.error, 'Email Anda tidak terdaftar.');
        return;
      }

      // Mengirim magic link
      await authRepository.sendMagicLink(email);
      state = AuthState(AuthStatus.success, 'Magic link berhasil dikirim. Silakan periksa email Anda.');
    } catch (e) {
      // Menangani error
      state = AuthState(AuthStatus.error, 'Terjadi kesalahan: ${e.toString()}');
    }
  }

  // Fungsi untuk logout
  Future<void> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = AuthState(AuthStatus.loading);
    try {
      await authRepository.signOut();
      state = AuthState(AuthStatus.idle, 'Berhasil logout.');
    } catch (e) {
      state = AuthState(AuthStatus.error, 'Gagal logout: ${e.toString()}');
    }
  }
}
