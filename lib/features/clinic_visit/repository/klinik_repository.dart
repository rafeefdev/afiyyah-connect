import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/app/core/model/activities/kunjungan_klinik_model.dart';
import 'package:logging/logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final kunjunganKlinikRepositoryProvider = Provider<KunjunganKlinikRepository>((
  ref,
) {
  return KunjunganKlinikRepository(ref.watch(supabaseClientProvider));
});

class KunjunganKlinikRepository {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('KunjunganKlinikRepository');

  KunjunganKlinikRepository(this._supabase);

  Future<List<KunjunganKlinikModel>> getAll() async {
    _log.info('Getting all kunjungan_klinik');
    final response = await _supabase.from('kunjungan_klinik').select();
    return response.map((e) => KunjunganKlinikModel.fromJson(e)).toList();
  }

  Future<List<KunjunganKlinikModel>> getByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    _log.info('Getting kunjungan_klinik by date: $date');
    final response = await _supabase
        .from('kunjungan_klinik')
        .select()
        .gte('created_at', startOfDay.toIso8601String())
        .lt('created_at', endOfDay.toIso8601String());
    return response.map((e) => KunjunganKlinikModel.fromJson(e)).toList();
  }

  Future<KunjunganKlinikModel?> getById(String id) async {
    _log.info('Getting kunjungan_klinik by id: $id');
    final response = await _supabase
        .from('kunjungan_klinik')
        .select()
        .eq('id', id)
        .single();
    return KunjunganKlinikModel.fromJson(response);
  }

  Future<void> insert(KunjunganKlinikModel data) async {
    _log.info('Inserting kunjungan_klinik for santii: ${data.santuarioId}');
    await _supabase.from('kunjungan_klinik').insert(data.toJson());
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    _log.info('Updating kunjungan_klinik: $id');
    await _supabase.from('kunjungan_klinik').update(data).eq('id', id);
  }

  Future<void> delete(String id) async {
    _log.info('Deleting kunjungan_klinik: $id');
    await _supabase.from('kunjungan_klinik').delete().eq('id', id);
  }
}
