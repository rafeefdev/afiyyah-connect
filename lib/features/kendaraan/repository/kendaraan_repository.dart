import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/app/core/model/entities/kendaraan_model.dart';
import 'package:logging/logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final kendaraanRepositoryProvider = Provider<KendaraanRepository>((ref) {
  return KendaraanRepository(ref.watch(supabaseClientProvider));
});

class KendaraanRepository {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('KendaraanRepository');

  KendaraanRepository(this._supabase);

  Future<List<KendaraanModel>> getAll() async {
    _log.info('Getting all kendaraan');
    final response = await _supabase.from('kendaraan').select();
    return response.map((e) => KendaraanModel.fromJson(e)).toList();
  }

  Future<KendaraanModel?> getById(String id) async {
    _log.info('Getting kendaraan by id: $id');
    final response = await _supabase
        .from('kendaraan')
        .select()
        .eq('id', id)
        .single();
    return KendaraanModel.fromJson(response);
  }
}
