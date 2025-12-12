import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/app/core/model/activities/pendataan_kesehatan_model.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'health_input_repository.g.dart';

abstract class HealthInputRepository {
  Future<void> addHealthEntry(PendataanKesehatanModel data);
}

class HealthInputRepositoryImpl implements HealthInputRepository {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('HealthInputRepository');

  HealthInputRepositoryImpl(this._supabase);

  @override
  Future<void> addHealthEntry(PendataanKesehatanModel data) async {
    final currentUser = _supabase.auth.currentUser;
    if (currentUser == null) {
      throw Exception('User is not authenticated.');
    }

    final dataToInsert = data.toJson()..['user_id'] = currentUser.id;

    _log.info('Adding health entry for santri: ${data.santriId}');
    try {
      await _supabase.from('pendataan_kesehatan').insert(dataToInsert);
      _log.fine('Health entry added successfully.');
    } catch (e, st) {
      _log.severe('Failed to add health entry', e, st);
      rethrow;
    }
  }
}

@riverpod
HealthInputRepository healthInputRepository(ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return HealthInputRepositoryImpl(supabase);
}
