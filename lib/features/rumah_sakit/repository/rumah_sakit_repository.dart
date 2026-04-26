import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/app/core/model/entities/rumah_sakit_model.dart';
import 'package:logging/logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final rumahSakitRepositoryProvider = Provider<RumahSakitRepository>((ref) {
  return RumahSakitRepository(ref.watch(supabaseClientProvider));
});

class RumahSakitRepository {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('RumahSakitRepository');

  RumahSakitRepository(this._supabase);

  Future<List<RumahSakitModel>> getAll() async {
    _log.info('Getting all rumah_sakit');
    final response = await _supabase.from('rumah_sakit').select();
    return response.map((e) => RumahSakitModel.fromJson(e)).toList();
  }

  Future<RumahSakitModel?> getById(String id) async {
    _log.info('Getting rumah_sakit by id: $id');
    final response = await _supabase
        .from('rumah_sakit')
        .select()
        .eq('id', id)
        .single();
    return RumahSakitModel.fromJson(response);
  }
}
