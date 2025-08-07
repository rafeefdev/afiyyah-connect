import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Provider untuk instance repository agar bisa diakses dari mana saja
final santriRepositoryProvider = Provider<SantriRepository>((ref) {
  return SantriRepository(ref.watch(supabaseClientProvider));
});

/// Repository untuk mengelola operasi data terkait Santri.
/// Ini menjadi satu-satunya sumber kebenaran untuk fetching data santri.
class SantriRepository {
  final SupabaseClient _supabase;

  SantriRepository(this._supabase);

  /// Mencari santri berdasarkan nama dari view `v_santri_detail`.
  ///
  /// Mengembalikan `List<Santri>`. Melempar error jika terjadi kegagalan.
  Future<List<Santri>> searchSantri(String query) async {
    try {
      final response = await _supabase
          .from('v_santri_detail')
          .select()
          .ilike('nama', '%$query%')
          .limit(10);

      return response.map((data) => Santri.fromJson(data)).toList();
    } on PostgrestException catch (e) {
      // Bisa ditambahkan logging atau error handling spesifik di sini
      print('Supabase error in searchSantri: ${e.message}');
      rethrow;
    } catch (e) {
      print('Generic error in searchSantri: $e');
      rethrow;
    }
  }

  /// Di masa depan, Anda bisa menambahkan method lain di sini.
  /// Contoh:
  /// Future<Santri?> getSantriById(String id) async {
  ///   final response = await _supabase
  ///       .from('v_santri_detail')
  ///       .select()
  ///       .eq('santri_id', id)
  ///       .single();
  ///   return Santri.fromJson(response);
  /// }
}
