import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/app/core/model/activities/rujukan_model.dart';
import 'package:logging/logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final rujukanRepositoryProvider = Provider<RujukanRepository>((ref) {
  return RujukanRepository(ref.watch(supabaseClientProvider));
});

class RujukanRepository {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('RujukanRepository');

  RujukanRepository(this._supabase);

  Future<List<RujukanModel>> getAll() async {
    _log.info('Getting all rujukan');
    final response = await _supabase
        .from('rujukan')
        .select()
        .order('created_at', ascending: false);
    return response.map((e) => RujukanModel.fromJson(e)).toList();
  }

  Future<List<RujukanModel>> getByStatus(String status) async {
    _log.info('Getting rujukan by status: $status');
    final response = await _supabase
        .from('rujukan')
        .select()
        .eq('status_rujukan', status)
        .order('created_at', ascending: false);
    return response.map((e) => RujukanModel.fromJson(e)).toList();
  }

  Future<List<RujukanModel>> getToday() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    _log.info('Getting today rujukan');
    final response = await _supabase
        .from('rujukan')
        .select()
        .gte('created_at', startOfDay.toIso8601String())
        .lt('created_at', endOfDay.toIso8601String());
    return response.map((e) => RujukanModel.fromJson(e)).toList();
  }

  Future<RujukanModel?> getById(String id) async {
    _log.info('Getting rujukan by id: $id');
    final response = await _supabase
        .from('rujukan')
        .select()
        .eq('id', id)
        .single();
    return RujukanModel.fromJson(response);
  }

  Future<void> insert(RujukanModel data) async {
    _log.info('Inserting rujukan');
    await _supabase.from('rujukan').insert(data.toJson());
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    _log.info('Updating rujukan: $id');
    await _supabase.from('rujukan').update(data).eq('id', id);
  }

  Future<void> delete(String id) async {
    _log.info('Deleting rujukan: $id');
    await _supabase.from('rujukan').delete().eq('id', id);
  }
}
