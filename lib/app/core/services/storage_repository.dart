import 'dart:io';
import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'storage_repository.g.dart';

abstract class StorageRepository {
  Future<String?> uploadKwitansi(File file, String pengantaranId);
  Future<String?> uploadDokumenRujukan(File file, String hasilRujukanId);
  Future<String> getPublicUrl(String bucket, String fileName);
  Future<void> deleteFile(String bucket, String fileName);
}

class StorageRepositoryImpl implements StorageRepository {
  final SupabaseClient _supabase;
  final Logger _log = LoggerService.getLogger('StorageRepository');

  StorageRepositoryImpl(this._supabase);

  @override
  Future<String?> uploadKwitansi(File file, String pengantaranId) async {
    _log.info('Uploading kwitansi for pengantaran: $pengantaranId');
    try {
      final fileName =
          '${pengantaranId}_${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
      await _supabase.storage.from('kwitansi').upload(fileName, file);
      return getPublicUrl('kwitansi', fileName);
    } catch (e, st) {
      _log.severe('Failed to upload kwitansi', e, st);
      rethrow;
    }
  }

  @override
  Future<String?> uploadDokumenRujukan(File file, String hasilRujukanId) async {
    _log.info('Uploading dokumen rujukan for hasil: $hasilRujukanId');
    try {
      final fileName =
          'hasil_${hasilRujukanId}_${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
      await _supabase.storage.from('dokumen-rujukan').upload(fileName, file);
      return getPublicUrl('dokumen-rujukan', fileName);
    } catch (e, st) {
      _log.severe('Failed to upload dokumen rujukan', e, st);
      rethrow;
    }
  }

  @override
  Future<String> getPublicUrl(String bucket, String fileName) async {
    return _supabase.storage.from(bucket).getPublicUrl(fileName);
  }

  @override
  Future<void> deleteFile(String bucket, String fileName) async {
    _log.info('Deleting file: $fileName from bucket: $bucket');
    await _supabase.storage.from(bucket).remove([fileName]);
  }
}

@riverpod
StorageRepository storageRepository(ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return StorageRepositoryImpl(supabase);
}
