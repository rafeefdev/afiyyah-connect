import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/app/core/model/entities/asrama_model.dart';
import 'package:logging/logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final asramaRepositoryProvider = Provider<AsramaRepository>((ref) {
  return AsramaRepository(ref.watch(supabaseClientProvider));
});

class AsramaRepository {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('AsramaRepository');

  AsramaRepository(this._supabase);

  Future<List<AsramaModel>> getAll() async {
    _log.info('Getting all asrama');
    final response = await _supabase.from('asrama').select();
    return response.map((e) => AsramaModel.fromJson(e)).toList();
  }

  Future<AsramaModel?> getById(String id) async {
    _log.info('Getting asrama by id: $id');
    final response = await _supabase
        .from('asrama')
        .select()
        .eq('id', id)
        .single();
    return AsramaModel.fromJson(response);
  }
}
