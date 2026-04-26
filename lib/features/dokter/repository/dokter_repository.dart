import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/app/core/model/entities/dokter_model.dart';
import 'package:logging/logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final dokterRepositoryProvider = Provider<DokterRepository>((ref) {
  return DokterRepository(ref.watch(supabaseClientProvider));
});

class DokterRepository {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('DokterRepository');

  DokterRepository(this._supabase);

  Future<List<DokterModel>> getAll() async {
    _log.info('Getting all dokter');
    final response = await _supabase.from('dokter').select();
    return response.map((e) => DokterModel.fromJson(e)).toList();
  }

  Future<DokterModel?> getById(String id) async {
    _log.info('Getting dokter by id: $id');
    final response = await _supabase
        .from('dokter')
        .select()
        .eq('id', id)
        .single();
    return DokterModel.fromJson(response);
  }
}
