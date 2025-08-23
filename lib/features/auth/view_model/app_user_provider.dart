// lib/features/auth/view_model/app_user_provider.dart

import 'dart:async';

import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/features/auth/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'app_user_provider.g.dart';

@riverpod
Stream<UserModel?> appUser(ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final controller = StreamController<UserModel?>();

  // Langsung coba ambil user saat provider pertama kali dijalankan
  // untuk menangani sesi yang sudah ada.
  Future<void> initialCheck() async {
    try {
      if (authRepository.currentSession != null) {
        final userProfile = await authRepository.fetchUserProfile();
        if (!controller.isClosed) {
          controller.add(userProfile);
        }
      } else {
        if (!controller.isClosed) {
          controller.add(null);
        }
      }
    } catch (e) {
      // Jika gagal, anggap user tidak login
      if (!controller.isClosed) {
        controller.add(null);
      }
    }
  }

  initialCheck();

  // Dengarkan perubahan status otentikasi
  final subscription = authRepository.authStateChanges.listen(
    (AuthState state) async {
      final event = state.event;
      // Cek jika user login, refresh token, atau data user diupdate
      if (event == AuthChangeEvent.signedIn ||
          event == AuthChangeEvent.tokenRefreshed ||
          event == AuthChangeEvent.userUpdated) {
        try {
          final userProfile = await authRepository.fetchUserProfile();
          if (!controller.isClosed) {
            controller.add(userProfile);
          }
        } catch (e) {
          // Jika gagal fetch profil, kirim null
          if (!controller.isClosed) {
            controller.add(null);
          }
        }
      } else if (event == AuthChangeEvent.signedOut) {
        // Jika user logout, kirim null
        if (!controller.isClosed) {
          controller.add(null);
        }
      }
    },
    onError: (e) {
      // Jika ada error pada stream, kirim null
      if (!controller.isClosed) {
        controller.add(null);
      }
    },
  );

  // Pastikan untuk membersihkan resource saat provider di-dispose
  ref.onDispose(() {
    subscription.cancel();
    controller.close();
  });

  return controller.stream;
}
