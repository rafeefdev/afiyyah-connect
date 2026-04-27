import 'package:afiyyah_connect/app/core/model/activities/kunjungan_klinik_model.dart';
import 'package:afiyyah_connect/app/core/model/activities/klinik_enums.dart';
import 'package:afiyyah_connect/app/core/model/activities/pendataan_kesehatan_model.dart';
import 'package:afiyyah_connect/app/core/model/activities/periksaklinikstatus_model.dart';
import 'package:afiyyah_connect/app/core/model/activities/rujukan_model.dart';
import 'package:afiyyah_connect/app/core/model/activities/rujukan_enums.dart';
import 'package:afiyyah_connect/app/core/model/activities/monitoring_models.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/app/core/services/logger_service.dart';
import 'package:afiyyah_connect/features/clinic_visit/repository/klinik_repository.dart';
import 'package:afiyyah_connect/features/health_input/repository/pendataan_kesehatan_repository.dart';
import 'package:afiyyah_connect/features/rujukan/repository/rujukan_repository.dart';
import 'package:logging/logging.dart';
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
  final Logger _log = LoggerService.getLogger('MonitoringViewModel');

  @override
  Future<MonitoringData> build() async {
    return _fetchMonitoringData();
  }

  Future<MonitoringData> _fetchMonitoringData() async {
    _log.info('Fetching monitoring data');
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
    _log.info('Refreshing monitoring data');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchMonitoringData());
  }
}

@riverpod
Future<List<PendataanWithSantri>> periksaListToday(ref) async {
  final Logger _log = LoggerService.getLogger('periksaListToday');
  _log.info('Fetching periksa list today');

  final supabase = ref.watch(supabaseClientProvider);
  // final response = await supabase
  //     .from('v_pendataan_santri_today')
  //     .select()
  //     .eq('status_periksa', 'belum');
  
  final response = await supabase.from("v_pendataan_santri_today").select();

  _log.fine('Found ${response.length} records');

  return (response as List<dynamic>)
      .map(
        (e) =>
            PendataanWithSantri.fromJson(Map<String, dynamic>.from(e as Map)),
      )
      .toList();
}

@riverpod
Future<List<KunjunganWithSantri>> arahanListToday(ref) async {
  final Logger _log = LoggerService.getLogger('arahanListToday');
  _log.info('Fetching arahan list today');

  final supabase = ref.watch(supabaseClientProvider);
  final response = await supabase
      .from('v_kunjungan_butuh_tindakan')
      .select()
      .eq('status_pengarahan', 'istirahat_asrama');

  _log.fine('Found ${response.length} records');

  return (response as List<dynamic>)
      .map(
        (e) =>
            KunjunganWithSantri.fromJson(Map<String, dynamic>.from(e as Map)),
      )
      .toList();
}

@riverpod
Future<List<RujukanBelumDitindaklanjuti>> rujukanListToday(ref) async {
  final Logger _log = LoggerService.getLogger('rujukanListToday');
  _log.info('Fetching rujukan list today');

  final supabase = ref.watch(supabaseClientProvider);
  final response = await supabase
      .from('v_rujukan_belum_ditindaklanjuti')
      .select()
      .eq('belum_diantar', true);

  _log.fine('Found ${response.length} records');

  return (response as List<dynamic>)
      .map(
        (e) => RujukanBelumDitindaklanjuti.fromJson(
          Map<String, dynamic>.from(e as Map),
        ),
      )
      .toList();
}

@riverpod
Future<int> totalSantriSakit(ref) async {
  final Logger log = LoggerService.getLogger('totalSakitToday');
  log.info('fetching total santri sakit today');

  final supabase = ref.watch(supabaseClientProvider);
  final response = await supabase.from('v_total_today').select().single();
  
  log.info("response data: $response");
  
  var total = response['count'];
  return total;
}