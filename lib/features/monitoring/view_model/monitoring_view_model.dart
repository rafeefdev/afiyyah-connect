import 'package:afiyyah_connect/app/core/model/activities/kunjungan_klinik_model.dart';
import 'package:afiyyah_connect/app/core/model/activities/klinik_enums.dart';
import 'package:afiyyah_connect/app/core/model/activities/pendataan_kesehatan_model.dart';
import 'package:afiyyah_connect/app/core/model/activities/periksaklinikstatus_model.dart';
import 'package:afiyyah_connect/app/core/model/activities/rujukan_model.dart';
import 'package:afiyyah_connect/app/core/model/activities/rujukan_enums.dart';
import 'package:afiyyah_connect/features/clinic_visit/repository/klinik_repository.dart';
import 'package:afiyyah_connect/features/health_input/repository/pendataan_kesehatan_repository.dart';
import 'package:afiyyah_connect/features/rujukan/repository/rujukan_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'monitoring_view_model.g.dart';

class MonitoringData {
  final List<PendataanKesehatanModel> belumDiperiksa;
  final List<KunjunganKlinikModel> arahanList;
  final List<RujukanModel> rujukanList;

  MonitoringData({
    required this.belumDiperiksa,
    required this.arahanList,
    required this.rujukanList,
  });
}

@riverpod
class MonitoringViewModel extends _$MonitoringViewModel {
  @override
  Future<MonitoringData> build() async {
    return _fetchMonitoringData();
  }

  Future<MonitoringData> _fetchMonitoringData() async {
    final pendataanRepo = ref.read(pendataanKesehatanRepositoryProvider);
    final klinikRepo = ref.read(kunjunganKlinikRepositoryProvider);
    final rujukanRepo = ref.read(rujukanRepositoryProvider);

    final allPendataan = await pendataanRepo.getAll();
    final belumDiperiksa = allPendataan
        .where((e) => e.statusPeriksa == PeriksaKlinikStatus.belum)
        .toList();

    final allKunjungan = await klinikRepo.getAll();
    final arahanList = allKunjungan
        .where((e) => e.statusPengarahan == StatusPengarahan.istirahatAsrama)
        .toList();

    final allRujukan = await rujukanRepo.getAll();
    final activeRujukan = allRujukan
        .where(
          (e) =>
              e.statusRujukan?.value == 'menunggu' ||
              e.statusRujukan?.value == 'terjadwal',
        )
        .toList();

    return MonitoringData(
      belumDiperiksa: belumDiperiksa,
      arahanList: arahanList,
      rujukanList: activeRujukan,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchMonitoringData());
  }
}

@riverpod
class PeriksaList extends _$PeriksaList {
  @override
  Future<List<PendataanKesehatanModel>> build() async {
    final repo = ref.read(pendataanKesehatanRepositoryProvider);
    final allData = await repo.getAll();
    return allData
        .where((e) => e.statusPeriksa == PeriksaKlinikStatus.belum)
        .toList();
  }
}

@riverpod
class ArahanList extends _$ArahanList {
  @override
  Future<List<KunjunganKlinikModel>> build() async {
    final repo = ref.read(kunjunganKlinikRepositoryProvider);
    final allData = await repo.getAll();
    return allData
        .where((e) => e.statusPengarahan == StatusPengarahan.istirahatAsrama)
        .toList();
  }
}

@riverpod
class RujukanList extends _$RujukanList {
  @override
  Future<List<RujukanModel>> build() async {
    final repo = ref.read(rujukanRepositoryProvider);
    final allData = await repo.getAll();
    return allData
        .where(
          (e) =>
              e.statusRujukan?.value == 'menunggu' ||
              e.statusRujukan?.value == 'terjadwal',
        )
        .toList();
  }
}
