import 'dart:io';
import 'package:afiyyah_connect/app/core/model/activities/pengantaran_rujukan_model.dart';
import 'package:afiyyah_connect/app/core/model/activities/kwitansi_pengantaran_model.dart';
import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/app/core/services/storage_repository.dart';
import 'package:afiyyah_connect/features/pengantaran/repository/pengantaran_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final pengantaranServiceProvider = Provider<PengantaranService>((ref) {
  return PengantaranService(ref.watch(supabaseClientProvider));
});

class PengantaranService {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('PengantaranService');

  PengantaranService(this._supabase);

  Future<PengantaranRujukanModel> jadwalkanPengantaran({
    required String rujukanId,
    String? idPetugas,
    DateTime? tanggalPengantaran,
    String? sumberDana,
  }) async {
    _log.info('Menjadwalkan pengantaran untuk rujukan: $rujukanId');

    final data = PengantaranRujukanModel(
      rujukanId: rujukanId,
      idPetugas: idPetugas,
      tanggalPengantaran: tanggalPengantaran ?? DateTime.now(),
      sumberDana: sumberDana,
    );

    await _supabase.from('pengantaran_rujukan').insert(data.toJson());
    _log.fine('Pengantaran berhasil dijadwalkan');

    final inserted = await _supabase
        .from('pengantaran_rujukan')
        .select()
        .eq('rujukan_id', rujukanId)
        .order('created_at', ascending: false)
        .maybeSingle();

    if (inserted != null) {
      return PengantaranRujukanModel.fromJson(inserted);
    }

    throw Exception('Gagal menjadwalkan pengantaran');
  }

  Future<KwitansiPengantaranModel> uploadKwitansi({
    required String pengantaranId,
    required File file,
    required String jenisKwitansi,
  }) async {
    _log.info('Mengupload kwitansi untuk pengantaran: $pengantaranId');

    final storageRepo = StorageRepositoryImpl(_supabase);
    final url = await storageRepo.uploadKwitansi(file, pengantaranId);

    final data = KwitansiPengantaranModel(
      pengantaranId: pengantaranId,
      namaFile: file.path.split('/').last,
      pathFile: url,
    );

    await _supabase.from('kwitansi_pengantaran').insert(data.toJson());
    _log.fine('Kwitansi berhasil disimpan');

    return data;
  }

  Future<void> updatePengantaran({
    required String pengantaranId,
    String? idPetugas,
    DateTime? tanggalPengantaran,
    String? sumberDana,
  }) async {
    _log.info('Mengupdate pengantaran: $pengantaranId');

    final Map<String, dynamic> data = {};
    if (idPetugas != null) data['id_petugas'] = idPetugas;
    if (tanggalPengantaran != null) {
      data['tanggal_pengantaran'] = tanggalPengantaran.toIso8601String();
    }
    if (sumberDana != null) data['sumber_dana'] = sumberDana;

    await _supabase
        .from('pengantaran_rujukan')
        .update(data)
        .eq('id', pengantaranId);
    _log.fine('Pengantaran berhasil diupdate');
  }

  Future<PengantaranRujukanModel?> getPengantaranByRujukan(
    String rujukanId,
  ) async {
    _log.info('Mendapatkan pengantaran untuk rujukan: $rujukanId');

    final repo = PengantaranRepository(_supabase);
    final list = await repo.getByRujukanId(rujukanId);
    return list.isNotEmpty ? list.first : null;
  }

  Future<List<KwitansiPengantaranModel>> getKwitansiByPengantaran(
    String pengantaranId,
  ) async {
    _log.info('Mendapatkan kwitansi untuk pengantaran: $pengantaranId');

    final response = await _supabase
        .from('kwitansi_pengantaran')
        .select()
        .eq('pengantaran_id', pengantaranId);

    return response.map((e) => KwitansiPengantaranModel.fromJson(e)).toList();
  }
}
