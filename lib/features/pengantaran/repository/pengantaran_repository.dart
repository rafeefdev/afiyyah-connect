import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/app/core/model/activities/pengantaran_rujukan_model.dart';
import 'package:logging/logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final pengantaranRepositoryProvider = Provider<PengantaranRepository>((ref) {
  return PengantaranRepository(ref.watch(supabaseClientProvider));
});

class PengantaranRepository {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('PengantaranRepository');

  PengantaranRepository(this._supabase);

  Future<List<PengantaranRujukanModel>> getAll() async {
    _log.info('Getting all pengantaran_rujukan');
    final response = await _supabase
        .from('pengantaran_rujukan')
        .select()
        .order('created_at', ascending: false);
    return response.map((e) => PengantaranRujukanModel.fromJson(e)).toList();
  }

  Future<List<PengantaranRujukanModel>> getByRujukanId(String rujukanId) async {
    _log.info('Getting pengantaran by rujukan id: $rujukanId');
    final response = await _supabase
        .from('pengantaran_rujukan')
        .select()
        .eq('rujukan_id', rujukanId);
    return response.map((e) => PengantaranRujukanModel.fromJson(e)).toList();
  }

  Future<PengantaranRujukanModel?> getById(String id) async {
    _log.info('Getting pengantaran by id: $id');
    final response = await _supabase
        .from('pengantaran_rujukan')
        .select()
        .eq('id', id)
        .single();
    return PengantaranRujukanModel.fromJson(response);
  }

  Future<void> insert(PengantaranRujukanModel data) async {
    _log.info('Inserting pengantaran_rujukan');
    await _supabase.from('pengantaran_rujukan').insert(data.toJson());
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    _log.info('Updating pengantaran_rujukan: $id');
    await _supabase.from('pengantaran_rujukan').update(data).eq('id', id);
  }

  Future<void> delete(String id) async {
    _log.info('Deleting pengantaran_rujukan: $id');
    await _supabase.from('pengantaran_rujukan').delete().eq('id', id);
  }
}
