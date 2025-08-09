// lib/features/auth/view_model/app_user_provider.dart

import 'dart:async';

import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/features/auth/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'app_user_provider.g.dart';

@riverpod
Stream<UserModel?> appUser(AppUserRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  // Mendengarkan perubahan status otentikasi dari Supabase
  return authRepository.authStateChanges.asyncMap((state) async {
    // Jika ada sesi yang aktif (baik login baru atau sesi yang dipulihkan),
    // coba ambil profil pengguna.
    if (state.session != null) {
      try {
        // Ambil profil pengguna dari database
        final userProfile = await authRepository.fetchUserProfile();
        return userProfile;
      } catch (e) {
        // Jika gagal mengambil profil, logout pengguna untuk keamanan
        // dan kembalikan null.
        await authRepository.signOut();
        return null;
      }
    }
    // Jika tidak ada sesi, kembalikan null.
    return null;
  });
}
