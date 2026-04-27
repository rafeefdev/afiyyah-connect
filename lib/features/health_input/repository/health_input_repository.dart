import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/app/core/model/activities/pendataan_kesehatan_model.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'health_input_repository.g.dart';

abstract class HealthInputRepository {
  Future<void> addHealthEntry(PendataanKesehatanModel data);
  Future<bool> checkDuplicateToday(String santriId);
}

class HealthInputRepositoryImpl implements HealthInputRepository {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('HealthInputRepository');

  HealthInputRepositoryImpl(this._supabase);

  @override
  Future<bool> checkDuplicateToday(String santriId) async {
    // Use UTC timezone to match database storage
    final nowUtc = DateTime.now().toUtc();
    final startOfDayUtc = DateTime.utc(nowUtc.year, nowUtc.month, nowUtc.day);
    final endOfDayUtc = startOfDayUtc.add(const Duration(days: 1));

    _log.info(
      'Checking for duplicate health entry for santri: $santriId today (UTC: ${startOfDayUtc.toIso8601String()} to ${endOfDayUtc.toIso8601String()})',
    );
    final existingEntry = await _supabase
        .from('pendataan_kesehatan')
        .select()
        .eq('santri_id', santriId)
        .gte('created_at', startOfDayUtc.toIso8601String())
        .lt('created_at', endOfDayUtc.toIso8601String())
        .maybeSingle();

    final hasDuplicate = existingEntry != null;
    if (hasDuplicate) {
      _log.warning('Duplicate found for santri: $santriId on $startOfDayUtc');
    }
    return hasDuplicate;
  }

  @override
  Future<void> addHealthEntry(PendataanKesehatanModel data) async {
    final currentUser = _supabase.auth.currentUser;
    if (currentUser == null) {
      throw Exception('User is not authenticated.');
    }

    // Use UTC timezone to match database storage
    final nowUtc = DateTime.now().toUtc();
    final startOfDayUtc = DateTime.utc(nowUtc.year, nowUtc.month, nowUtc.day);
    final endOfDayUtc = startOfDayUtc.add(const Duration(days: 1));

    _log.info(
      'Checking for duplicate health entry for santri: ${data.santuarioId} today (UTC: ${startOfDayUtc.toIso8601String()} to ${endOfDayUtc.toIso8601String()})',
    );
    final existingEntry = await _supabase
        .from('pendataan_kesehatan')
        .select()
        .eq('santri_id', data.santuarioId)
        .gte('created_at', startOfDayUtc.toIso8601String())
        .lt('created_at', endOfDayUtc.toIso8601String())
        .maybeSingle();

    if (existingEntry != null) {
      _log.warning(
        'Duplicate health entry detected for santri: ${data.santuarioId} on $startOfDayUtc',
      );
      throw Exception(
        'Santri ini sudah didata hari ini. Tidak dapat menambahkan data duplikat.',
      );
    }

    final dataToInsert = data.toJson()..['user_id'] = currentUser.id;

    _log.info('Adding health entry for santri: ${data.santuarioId}');
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
