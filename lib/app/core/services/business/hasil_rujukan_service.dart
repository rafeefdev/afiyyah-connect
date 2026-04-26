import 'dart:io';
import 'package:afiyyah_connect/app/core/model/activities/hasil_rujukan_model.dart';
import 'package:afiyyah_connect/app/core/model/activities/dokumen_hasil_rujukan_model.dart';
import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/app/core/services/storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final hasilRujukanServiceProvider = Provider<HasilRujukanService>((ref) {
  return HasilRujukanService(ref.watch(supabaseClientProvider));
});

class HasilRujukanService {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('HasilRujukanService');

  HasilRujukanService(this._supabase);

  Future<HasilRujukanModel> simpanHasil({
    required String rujukanId,
    DateTime? tanggalHasil,
    String? dokumentasi,
  }) async {
    _log.info('Menyimpan hasil rujukan untuk rujukan: $rujukanId');

    final data = HasilRujukanModel(
      rujukanId: rujukanId,
      tanggalHasil: tanggalHasil ?? DateTime.now(),
      dokumentasi: dokumentasi,
    );

    await _supabase.from('hasil_rujukan').insert(data.toJson());
    _log.fine('Hasil rujukan berhasil disimpan');

    final inserted = await _supabase
        .from('hasil_rujukan')
        .select()
        .eq('rujukan_id', rujukanId)
        .order('created_at', ascending: false)
        .maybeSingle();

    if (inserted != null) {
      return HasilRujukanModel.fromJson(inserted);
    }

    throw Exception('Gagal menyimpan hasil rujukan');
  }

  Future<DokumenHasilRujukanModel> uploadDokumen({
    required String hasilRujukanId,
    required File file,
    required String jenisDokumen,
  }) async {
    _log.info('Mengupload dokumen untuk hasil: $hasilRujukanId');

    final storageRepo = StorageRepositoryImpl(_supabase);
    final url = await storageRepo.uploadDokumenRujukan(file, hasilRujukanId);

    final data = DokumenHasilRujukanModel(
      hasilRujukanId: hasilRujukanId,
      namaFile: file.path.split('/').last,
      pathFile: url,
    );

    await _supabase.from('dokumen_hasil_rujukan').insert(data.toJson());
    _log.fine('Dokumen berhasil disimpan');

    return data;
  }

  Future<HasilRujukanModel?> getHasilByRujukan(String rujukanId) async {
    _log.info('Mendapatkan hasil untuk rujukan: $rujukanId');

    final response = await _supabase
        .from('hasil_rujukan')
        .select()
        .eq('rujukan_id', rujukanId)
        .maybeSingle();

    if (response == null) return null;
    return HasilRujukanModel.fromJson(response);
  }

  Future<List<DokumenHasilRujukanModel>> getDokumenByHasil(
    String hasilRujukanId,
  ) async {
    _log.info('Mendapatkan dokumen untuk hasil: $hasilRujukanId');

    final response = await _supabase
        .from('dokumen_hasil_rujukan')
        .select()
        .eq('hasil_rujukan_id', hasilRujukanId);

    return response.map((e) => DokumenHasilRujukanModel.fromJson(e)).toList();
  }

  Future<void> updateHasil({
    required String hasilId,
    DateTime? tanggalHasil,
    String? dokumentasi,
  }) async {
    _log.info('Mengupdate hasil rujukan: $hasilId');

    final Map<String, dynamic> data = {};
    if (tanggalHasil != null) {
      data['tanggal_hasil'] = tanggalHasil.toIso8601String();
    }
    if (dokumentasi != null) data['dokumentasi'] = dokumentasi;

    await _supabase.from('hasil_rujukan').update(data).eq('id', hasilId);
    _log.fine('Hasil rujukan berhasil diupdate');
  }
}
