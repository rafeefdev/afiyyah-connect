import 'package:afiyyah_connect/app/core/model/activities/pendataan_kesehatan_model.dart';
import 'package:afiyyah_connect/app/core/model/activities/kunjungan_klinik_model.dart';
import 'package:afiyyah_connect/app/core/model/activities/rujukan_model.dart';
import 'package:afiyyah_connect/app/core/model/entities/riwayat_kesehatan_santri_model.dart';
import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/features/health_input/repository/pendataan_kesehatan_repository.dart';
import 'package:afiyyah_connect/features/clinic_visit/repository/klinik_repository.dart';
import 'package:afiyyah_connect/features/rujukan/repository/rujukan_repository.dart';
import 'package:afiyyah_connect/features/riwayat_kesehatan/repository/riwayat_kesehatan_repository.dart';
import 'package:afiyyah_connect/features/common/repository/santri_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medical_history_view_model.g.dart';

class MedicalHistoryData {
  final Santri student;
  final List<PendataanKesehatanModel> pendataanList;
  final List<KunjunganKlinikModel> kunjunganList;
  final List<RujukanModel> rujukanList;
  final List<RiwayatKesehatanSantriModel> healthRecord;

  MedicalHistoryData({
    required this.student,
    required this.pendataanList,
    required this.kunjunganList,
    required this.rujukanList,
    required this.healthRecord,
  });
}

@riverpod
class MedicalHistoryViewModel extends _$MedicalHistoryViewModel {
  @override
  Future<MedicalHistoryData?> build(String studentId) async {
    if (studentId.isEmpty) return null;
    return _fetchMedicalHistory(studentId);
  }

  Future<MedicalHistoryData?> _fetchMedicalHistory(String studentId) async {
    final siswaRepo = ref.read(santriRepositoryProvider);
    final pendataanRepo = ref.read(pendataanKesehatanRepositoryProvider);
    final klinikRepo = ref.read(kunjunganKlinikRepositoryProvider);
    final rujukanRepo = ref.read(rujukanRepositoryProvider);
    final riwayatRepo = ref.read(riwayatKesehatanRepositoryProvider);

    final student = await siswaRepo.getSantriById(studentId);
    if (student == null) return null;

    final allPendataan = await pendataanRepo.getAll();
    final pendataanList = allPendataan
        .where((e) => e.santuarioId == studentId)
        .toList();

    final allKunjungan = await klinikRepo.getAll();
    final kunjunganList = allKunjungan
        .where((e) => e.santuarioId == studentId)
        .toList();

    final allRujukan = await rujukanRepo.getAll();
    final rujukanList = allRujukan.where((e) {
      final pemeriksaan = e.pemeriksaanId;
      return pemeriksaan != null;
    }).toList();

    final healthRecord = await riwayatRepo.getBySantriId(studentId);

    return MedicalHistoryData(
      student: student,
      pendataanList: pendataanList,
      kunjunganList: kunjunganList,
      rujukanList: rujukanList,
      healthRecord: healthRecord,
    );
  }
}

@riverpod
class StudentHealthRecord extends _$StudentHealthRecord {
  @override
  Future<RiwayatKesehatanSantriModel?> build(String studentId) async {
    if (studentId.isEmpty) return null;
    final repo = ref.read(riwayatKesehatanRepositoryProvider);
    final records = await repo.getBySantriId(studentId);
    return records.isNotEmpty ? records.first : null;
  }
}
