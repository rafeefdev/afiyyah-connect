import 'package:afiyyah_connect/app/core/model/activities/kunjungan_klinik_model.dart';
import 'package:afiyyah_connect/app/core/model/activities/klinik_enums.dart';
import 'package:afiyyah_connect/app/core/model/activities/pemeriksaan_dokter_model.dart';
import 'package:afiyyah_connect/app/core/model/activities/periksaklinikstatus_model.dart';
import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/features/clinic_visit/repository/klinik_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final pemeriksaanServiceProvider = Provider<PemeriksaanService>((ref) {
  return PemeriksaanService(ref.watch(supabaseClientProvider));
});

class PemeriksaanService {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('PemeriksaanService');

  PemeriksaanService(this._supabase);

  Future<KunjunganKlinikModel> buatKunjunganKlinik({
    required String santuarioId,
    String? pendataanId,
    required SumberKunjungan sumberKunjungan,
    StatusPengarahan statusPengarahan = StatusPengarahan.masukSekolah,
  }) async {
    _log.info('Membuat kunjungan klinik untuk santo: $santuarioId');

    final data = KunjunganKlinikModel(
      pendataanId: pendataanId,
      santuarioId: santuarioId,
      sumberKunjungan: sumberKunjungan,
      statusPengarahan: statusPengarahan,
    );

    final klinikRepo = KunjunganKlinikRepository(_supabase);
    await klinikRepo.insert(data);

    final inserted = await klinikRepo.getBySantriId(data.santuarioId);
    if (inserted.isNotEmpty) {
      return inserted.first;
    }

    throw Exception('Gagal membuat kunjungan klinik');
  }

  Future<PemeriksaanDokterModel> simpanPemeriksaan({
    required String kunjunganId,
    required String idDokter,
    String? diagnosa,
    String? resep,
  }) async {
    _log.info('Menyimpan pemeriksaan untuk kunjungan: $kunjunganId');

    final data = PemeriksaanDokterModel(
      kunjunganId: kunjunganId,
      idDokter: idDokter,
      diagnosa: diagnosa,
      resep: resep,
    );

    await _supabase.from('pemeriksaan_dokter').insert(data.toJson());
    _log.fine('Pemeriksaan berhasil disimpan');

    return data;
  }

  Future<void> updateStatusPemeriksaan({
    required String pendataanId,
    required PeriksaKlinikStatus status,
  }) async {
    _log.info('Mengupdate status periksa: $pendataanId -> $status');

    await _supabase
        .from('pendataan_kesehatan')
        .update({'status_periksa': status.value})
        .eq('id', pendataanId);
  }

  Future<PemeriksaanDokterModel?> getPemeriksaanByKunjungan(
    String kunjunganId,
  ) async {
    _log.info('Mendapatkan pemeriksaan untuk kunjungan: $kunjunganId');

    final response = await _supabase
        .from('pemeriksaan_dokter')
        .select()
        .eq('kunjungan_id', kunjunganId)
        .maybeSingle();

    if (response == null) return null;
    return PemeriksaanDokterModel.fromJson(response);
  }
}
