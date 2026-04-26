import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/app/core/model/activities/pendataan_kesehatan_model.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PendataanKesehatanRepository {
  Future<List<PendataanKesehatanModel>> getAll();
  Future<List<PendataanKesehatanModel>> getByDate(DateTime date);
  Future<List<PendataanKesehatanModel>> getToday();
  Future<PendataanKesehatanModel?> getById(String id);
  Future<void> insert(PendataanKesehatanModel data);
  Future<void> update(String id, Map<String, dynamic> data);
  Future<void> delete(String id);
}

class PendataanKesehatanRepositoryImpl implements PendataanKesehatanRepository {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('PendataanKesehatanRepository');

  PendataanKesehatanRepositoryImpl(this._supabase);

  @override
  Future<List<PendataanKesehatanModel>> getAll() async {
    _log.info('Getting all pendataan_kesehatan');
    final response = await _supabase
        .from('pendataan_kesehatan')
        .select()
        .order('created_at', ascending: false);
    return response.map((e) => PendataanKesehatanModel.fromJson(e)).toList();
  }

  @override
  Future<List<PendataanKesehatanModel>> getByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    _log.info('Getting pendataan_kesehatan by date: $date');
    final response = await _supabase
        .from('pendataan_kesehatan')
        .select()
        .gte('created_at', startOfDay.toIso8601String())
        .lt('created_at', endOfDay.toIso8601String())
        .order('created_at', ascending: false);
    return response.map((e) => PendataanKesehatanModel.fromJson(e)).toList();
  }

  @override
  Future<List<PendataanKesehatanModel>> getToday() async {
    return getByDate(DateTime.now());
  }

  @override
  Future<PendataanKesehatanModel?> getById(String id) async {
    _log.info('Getting pendataan_kesehatan by id: $id');
    final response = await _supabase
        .from('pendataan_kesehatan')
        .select()
        .eq('id', id)
        .single();
    return PendataanKesehatanModel.fromJson(response);
  }

  @override
  Future<void> insert(PendataanKesehatanModel data) async {
    final currentUser = _supabase.auth.currentUser;
    if (currentUser == null) {
      throw Exception('User is not authenticated.');
    }
    final dataToInsert = data.toJson()..['user_id'] = currentUser.id;
    _log.info('Inserting pendataan_kesehatan for santii: ${data.santuarioId}');
    await _supabase.from('pendataan_kesehatan').insert(dataToInsert);
  }

  @override
  Future<void> update(String id, Map<String, dynamic> data) async {
    _log.info('Updating pendataan_kesehatan: $id');
    await _supabase.from('pendataan_kesehatan').update(data).eq('id', id);
  }

  @override
  Future<void> delete(String id) async {
    _log.info('Deleting pendataan_kesehatan: $id');
    await _supabase.from('pendataan_kesehatan').delete().eq('id', id);
  }
}

@riverpod
PendataanKesehatanRepository pendataanKesehatanRepository(ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return PendataanKesehatanRepositoryImpl(supabase);
}
