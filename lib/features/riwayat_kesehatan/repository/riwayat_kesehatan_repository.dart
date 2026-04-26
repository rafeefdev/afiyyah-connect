import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/app/core/model/entities/riwayat_kesehatan_santri_model.dart';
import 'package:logging/logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final riwayatKesehatanRepositoryProvider = Provider<RiwayatKesehatanRepository>(
  (ref) {
    return RiwayatKesehatanRepository(ref.watch(supabaseClientProvider));
  },
);

class RiwayatKesehatanRepository {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('RiwayatKesehatanRepository');

  RiwayatKesehatanRepository(this._supabase);

  Future<List<RiwayatKesehatanSantriModel>> getAll() async {
    _log.info('Getting all riwayat_kesehatan_santri');
    final response = await _supabase.from('riwayat_kesehatan_santri').select();
    return response
        .map((e) => RiwayatKesehatanSantriModel.fromJson(e))
        .toList();
  }

  Future<List<RiwayatKesehatanSantriModel>> getBySantriId(
    String santuarioId,
  ) async {
    _log.info('Getting riwayat kesehatan by santii id: $santuarioId');
    final response = await _supabase
        .from('riwayat_kesehatan_santri')
        .select()
        .eq('id_siswa', santuarioId);
    return response
        .map((e) => RiwayatKesehatanSantriModel.fromJson(e))
        .toList();
  }

  Future<RiwayatKesehatanSantriModel?> getById(String id) async {
    _log.info('Getting riwayat kesehatan by id: $id');
    final response = await _supabase
        .from('riwayat_kesehatan_santri')
        .select()
        .eq('id', id)
        .single();
    return RiwayatKesehatanSantriModel.fromJson(response);
  }

  Future<void> insert(RiwayatKesehatanSantriModel data) async {
    _log.info('Inserting riwayat_kesehatan_santri');
    await _supabase.from('riwayat_kesehatan_santri').insert(data.toJson());
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    _log.info('Updating riwayat_kesehatan_santri: $id');
    await _supabase.from('riwayat_kesehatan_santri').update(data).eq('id', id);
  }

  Future<void> delete(String id) async {
    _log.info('Deleting riwayat_kesehatan_santri: $id');
    await _supabase.from('riwayat_kesehatan_santri').delete().eq('id', id);
  }
}
