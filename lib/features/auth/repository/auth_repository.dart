import 'package:afiyyah_connect/app/core/model/user.dart';
import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:logging/logging.dart';
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
  final supabase.SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('AuthRepository');

  AuthRepositoryImpl(this._supabase);

  @override
  Future<bool> isEmailAllowed(String email) async {
    _log.info('Checking if email is allowed: $email');
    try {
      final response = await _supabase.rpc(
        'is_email_allowed',
        params: {'input_email': email},
      );
      final isAllowed = response as bool? ?? false;
      _log.fine('Email $email allowed: $isAllowed');
      return isAllowed;
    } catch (e, st) {
      _log.severe('Failed to check if email is allowed', e, st);
      rethrow;
    }
  }

  @override
  Future<void> sendOtp(String email) async {
    _log.info('Sending OTP to: $email');
    try {
      await _supabase.auth.signInWithOtp(
        email: email,
      );
      _log.fine('OTP sent successfully to $email');
    } catch (e, st) {
      _log.severe('Failed to send OTP to $email', e, st);
      rethrow;
    }
  }

  @override
  Future<void> verifyOtp({required String email, required String otp}) async {
    _log.info('Verifying OTP for: $email');
    try {
      await _supabase.auth.verifyOTP(
        type: supabase.OtpType.email,
        token: otp,
        email: email,
      );
      _log.fine('OTP verified successfully for $email');
    } catch (e, st) {
      _log.severe('Failed to verify OTP for $email', e, st);
      rethrow;
    }
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
    _log.info('Signing out');
    try {
      await _supabase.auth.signOut();
      _log.fine('Signed out successfully');
    } catch (e, st) {
      _log.severe('Failed to sign out', e, st);
      rethrow;
    }
  }

  @override
  Future<UserModel> fetchUserProfile() async {
    _log.info('Fetching user profile');
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

      final user = UserModel.fromProfile(
        profileJson: response,
        email: currentUser.email!,
      );
      _log.fine('User profile fetched successfully for ${user.email}');
      return user;
    } catch (e, st) {
      _log.severe('Failed to fetch user profile', e, st);
      throw Exception('Gagal mengambil profil pengguna: $e');
    }
  }

  @override
  Future<void> updateUserName(String newName) async {
    _log.info('Updating user name to: $newName');
    try {
      await _supabase.rpc(
        'update_user_name',
        params: {'new_name': newName},
      );
      _log.fine('User name updated successfully');
    } catch (e, st) {
      _log.severe('Failed to update user name', e, st);
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
