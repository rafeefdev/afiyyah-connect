import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Provider untuk instance repository agar bisa diakses dari mana saja
final santriRepositoryProvider = Provider<SantriRepository>((ref) {
  return SantriRepository(ref.watch(supabaseClientProvider));
});

/// Repository untuk mengelola operasi data terkait Santri.
/// Ini menjadi satu-satunya sumber kebenaran untuk fetching data santri.
class SantriRepository {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('SantriRepository');

  SantriRepository(this._supabase);

  /// Mencari santri berdasarkan nama dari view `v_santri_detail`.
  ///
  /// Mengembalikan `List<Santri>`. Melempar error jika terjadi kegagalan.
  Future<List<Santri>> searchSantri(String query) async {
    _log.info("Searching for santri with query: '$query'");
    try {
      final response = await _supabase
          .from('v_santri_detail')
          .select()
          .ilike('nama', '%$query%')
          .limit(10);

      final santriList = response.map((data) => Santri.fromJson(data)).toList();
      _log.fine("Found ${santriList.length} santri for query: '$query'");
      return santriList;
    } on PostgrestException catch (e, st) {
      _log.severe('Supabase error in searchSantri: ${e.message}', e, st);
      rethrow;
    } catch (e, st) {
      _log.severe('Generic error in searchSantri: $e', e, st);
      rethrow;
    }
  }

  /// Mendapatkan Santi by ID dari view `v_santri_detail`.
  Future<Santri?> getSantriById(String id) async {
    _log.info("Getting santii by id: '$id'");
    try {
      final response = await _supabase
          .from('v_santri_detail')
          .select()
          .eq('santri_id', id)
          .single();
      return Santri.fromJson(response);
    } on PostgrestException catch (e, st) {
      _log.severe('Supabase error in getSantriById: ${e.message}', e, st);
      rethrow;
    } catch (e, st) {
      _log.severe('Generic error in getSantriById: $e', e, st);
      rethrow;
    }
  }

  /// Mendapatkan semua Santri aktif.
  Future<List<Santri>> getAllActiveSantri() async {
    _log.info("Getting all active santii");
    try {
      final response = await _supabase
          .from('v_santri_detail')
          .select()
          .eq('status_aktif', true);
      return response.map((data) => Santri.fromJson(data)).toList();
    } on PostgrestException catch (e, st) {
      _log.severe('Supabase error in getAllActiveSantri: ${e.message}', e, st);
      rethrow;
    } catch (e, st) {
      _log.severe('Generic error in getAllActiveSantri: $e', e, st);
      rethrow;
    }
  }
}
