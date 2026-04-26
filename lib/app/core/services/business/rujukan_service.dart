import 'package:afiyyah_connect/app/core/model/activities/rujukan_model.dart';
import 'package:afiyyah_connect/app/core/model/activities/rujukan_enums.dart';
import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/features/rujukan/repository/rujukan_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final rujukanServiceProvider = Provider<RujukanService>((ref) {
  return RujukanService(ref.watch(supabaseClientProvider));
});

class RujukanService {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('RujukanService');

  RujukanService(this._supabase);

  Future<RujukanModel> buatRujukan({
    required String pemeriksaanId,
    required String rumahSakitId,
    StatusRujukan status = StatusRujukan.menunggu,
  }) async {
    _log.info('Membuat rujukan untuk pemeriksaan: $pemeriksaanId');

    final data = RujukanModel(
      pemeriksaanId: pemeriksaanId,
      rumahSakitId: rumahSakitId,
      statusRujukan: status,
    );

    await _supabase.from('rujukan').insert(data.toJson());
    _log.fine('Rujukan berhasil dibuat');

    final inserted = await _supabase
        .from('rujukan')
        .select()
        .eq('pemeriksaan_id', pemeriksaanId)
        .order('created_at', ascending: false)
        .maybeSingle();

    if (inserted != null) {
      return RujukanModel.fromJson(inserted);
    }

    throw Exception('Gagal membuat rujukan');
  }

  Future<void> updateStatusRujukan({
    required String rujukanId,
    required StatusRujukan status,
  }) async {
    _log.info('Mengupdate status rujukan: $rujukanId -> $status');

    await _supabase
        .from('rujukan')
        .update({'status_rujukan': status.value})
        .eq('id', rujukanId);

    _log.fine('Status rujukan berhasil diupdate');
  }

  Future<RujukanModel?> getRujukanByPemeriksaan(String pemeriksaanId) async {
    _log.info('Mendapatkan rujukan untuk pemeriksaan: $pemeriksaanId');

    final response = await _supabase
        .from('rujukan')
        .select()
        .eq('pemeriksaan_id', pemeriksaanId)
        .maybeSingle();

    if (response == null) return null;
    return RujukanModel.fromJson(response);
  }

  Future<List<RujukanModel>> getRujukanAktif() async {
    _log.info('Mendapatkan rujukan aktif');
    final repo = RujukanRepository(_supabase);
    final all = await repo.getAll();
    return all
        .where(
          (e) =>
              e.statusRujukan == StatusRujukan.menunggu ||
              e.statusRujukan == StatusRujukan.terjadwal,
        )
        .toList();
  }
}
