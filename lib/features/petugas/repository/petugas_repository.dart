import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/app/core/model/entities/petugas_model.dart';
import 'package:logging/logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final petugasRepositoryProvider = Provider<PetugasRepository>((ref) {
  return PetugasRepository(ref.watch(supabaseClientProvider));
});

class PetugasRepository {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('PetugasRepository');

  PetugasRepository(this._supabase);

  Future<List<PetugasModel>> getAll() async {
    _log.info('Getting all petugas');
    final response = await _supabase.from('petugas').select();
    return response.map((e) => PetugasModel.fromJson(e)).toList();
  }

  Future<PetugasModel?> getById(String id) async {
    _log.info('Getting petugas by id: $id');
    final response = await _supabase
        .from('petugas')
        .select()
        .eq('id', id)
        .single();
    return PetugasModel.fromJson(response);
  }
}
