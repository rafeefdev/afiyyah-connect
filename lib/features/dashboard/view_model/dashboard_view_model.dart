import 'package:afiyyah_connect/app/core/model/activities/pendataan_kesehatan_model.dart';
import 'package:afiyyah_connect/app/core/model/activities/periksaklinikstatus_model.dart';
import 'package:afiyyah_connect/app/core/model/activities/rujukan_enums.dart';
import 'package:afiyyah_connect/features/health_input/repository/pendataan_kesehatan_repository.dart';
import 'package:afiyyah_connect/features/rujukan/repository/rujukan_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_view_model.g.dart';

class DashboardStats {
  final int totalIllnessThisWeek;
  final int totalIllnessLastWeek;
  final double comparisonPercentage;
  final String mostCommonCase;
  final int mostCommonCaseCount;
  final int needToRestCount;
  final int newCasesToday;
  final int referralsToday;
  final int sickToday;

  DashboardStats({
    required this.totalIllnessThisWeek,
    required this.totalIllnessLastWeek,
    required this.comparisonPercentage,
    required this.mostCommonCase,
    required this.mostCommonCaseCount,
    required this.needToRestCount,
    required this.newCasesToday,
    required this.referralsToday,
    required this.sickToday,
  });
}

@riverpod
class DashboardViewModel extends _$DashboardViewModel {
  @override
  Future<DashboardStats> build() async {
    return _calculateStats();
  }

  Future<DashboardStats> _calculateStats() async {
    final pendataanRepo = ref.read(pendataanKesehatanRepositoryProvider);
    final rujukanRepo = ref.read(rujukanRepositoryProvider);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    final startOfLastWeek = startOfWeek.subtract(const Duration(days: 7));
    final endOfLastWeek = startOfWeek;

    final thisWeekData = await _getDataInRange(
      pendataanRepo,
      startOfWeek,
      endOfWeek,
    );
    final lastWeekData = await _getDataInRange(
      pendataanRepo,
      startOfLastWeek,
      endOfLastWeek,
    );
    final todayData = await _getDataInRange(
      pendataanRepo,
      today,
      today.add(const Duration(days: 1)),
    );
    final referralsTodayData = await _getReferralsInRange(
      rujukanRepo,
      today,
      today.add(const Duration(days: 1)),
    );

    final mostCommon = _getMostCommonCase(thisWeekData);
    final sickCount = todayData
        .where((e) => e.statusPeriksa != PeriksaKlinikStatus.sudah)
        .length;

    final comparison = lastWeekData.isEmpty
        ? 0.0
        : ((thisWeekData.length - lastWeekData.length) / lastWeekData.length) *
              100;

    return DashboardStats(
      totalIllnessThisWeek: thisWeekData.length,
      totalIllnessLastWeek: lastWeekData.length,
      comparisonPercentage: comparison,
      mostCommonCase: mostCommon.$1,
      mostCommonCaseCount: mostCommon.$2,
      needToRestCount: todayData
          .where((e) => e.statusPeriksa == PeriksaKlinikStatus.belum)
          .length,
      newCasesToday: todayData.length,
      referralsToday: referralsTodayData.length,
      sickToday: sickCount,
    );
  }

  Future<List<PendataanKesehatanModel>> _getDataInRange(
    PendataanKesehatanRepository repo,
    DateTime start,
    DateTime end,
  ) async {
    final allData = await repo.getAll();
    return allData.where((e) {
      if (e.createdAt == null) return false;
      return e.createdAt!.isAfter(start) && e.createdAt!.isBefore(end);
    }).toList();
  }

  Future<List<dynamic>> _getReferralsInRange(
    RujukanRepository repo,
    DateTime start,
    DateTime end,
  ) async {
    final allData = await repo.getAll();
    return allData.where((e) {
      if (e.createdAt == null) return false;
      return e.createdAt!.isAfter(start) && e.createdAt!.isBefore(end);
    }).toList();
  }

  (String, int) _getMostCommonCase(List<PendataanKesehatanModel> data) {
    if (data.isEmpty) return ('N/A', 0);

    final Map<String, int> caseCount = {};
    for (final entry in data) {
      for (final keluhan in entry.keluhan) {
        caseCount[keluhan] = (caseCount[keluhan] ?? 0) + 1;
      }
    }

    if (caseCount.isEmpty) return ('N/A', 0);

    final sorted = caseCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return (sorted.first.key, sorted.first.value);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _calculateStats());
  }
}

@riverpod
class CasesPerDay extends _$CasesPerDay {
  @override
  Future<Map<String, int>> build() async {
    final repo = ref.read(pendataanKesehatanRepositoryProvider);
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));

    final allData = await repo.getAll();
    final weekData = allData.where((e) {
      if (e.createdAt == null) return false;
      return e.createdAt!.isAfter(weekAgo);
    }).toList();

    final Map<String, int> result = {};
    for (int i = 0; i < 7; i++) {
      final day = weekAgo.add(Duration(days: i + 1));
      final dayStr = '${day.month}/${day.day}';
      result[dayStr] = weekData.where((e) {
        return e.createdAt?.day == day.day && e.createdAt?.month == day.month;
      }).length;
    }
    return result;
  }
}

@riverpod
class ReferralStats extends _$ReferralStats {
  @override
  Future<Map<String, int>> build() async {
    final repo = ref.read(rujukanRepositoryProvider);
    final allData = await repo.getAll();

    final Map<String, int> result = {
      'menunggu': 0,
      'terjadwal': 0,
      'selesai': 0,
      'dibatalkan': 0,
    };

    for (final rujukan in allData) {
      final status = rujukan.statusRujukan?.value;
      if (status != null && result.containsKey(status)) {
        result[status] = result[status]! + 1;
      }
    }
    return result;
  }
}
