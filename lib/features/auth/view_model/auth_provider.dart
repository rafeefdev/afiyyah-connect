// features/auth/viewmodel/auth_provider.dart

import 'dart:async';
import 'dart:developer';

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

  // Fungsi untuk mengirim OTP ke email
  Future<void> sendOtp(String email) async {
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

      // Mengirim OTP
      await authRepository.sendOtp(email);
      state = AuthState(AuthStatus.otpSent, 'Kode OTP berhasil dikirim. Silakan periksa email Anda.');
    } catch (e) {
      // Menangani error
      state = AuthState(AuthStatus.error, 'Terjadi kesalahan: ${e.toString()}');
      log('error : $e');
    }
  }

  // Fungsi untuk verifikasi OTP
  Future<void> verifyOtp(String email, String otp) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = AuthState(AuthStatus.loading);
    try {
      await authRepository.verifyOtp(email: email, otp: otp);
      state = AuthState(AuthStatus.success, 'Login berhasil!');
    } catch (e) {
      state = AuthState(AuthStatus.error, 'Gagal verifikasi OTP: ${e.toString()}');
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

  // Fungsi untuk update nama pengguna
  Future<void> updateUserName(String newName) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = AuthState(AuthStatus.loading);
    try {
      await authRepository.updateUserName(newName);
      // Tidak perlu mengubah state di sini karena UI akan di-refresh oleh appUserProvider
      state = AuthState(AuthStatus.success, 'Nama berhasil diperbarui.');
    } catch (e) {
      state = AuthState(AuthStatus.error, 'Gagal memperbarui nama: ${e.toString()}');
    }
  }
}
