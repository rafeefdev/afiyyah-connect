// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dashboardViewModelHash() =>
    r'9965f1189416a9484575b2db68acc83ae60772ec';

/// See also [DashboardViewModel].
@ProviderFor(DashboardViewModel)
final dashboardViewModelProvider =
    AutoDisposeAsyncNotifierProvider<
      DashboardViewModel,
      DashboardStats
    >.internal(
      DashboardViewModel.new,
      name: r'dashboardViewModelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$dashboardViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DashboardViewModel = AutoDisposeAsyncNotifier<DashboardStats>;
String _$casesPerDayHash() => r'd445f06bd704b31014804f6060167105cbfc56df';

/// See also [CasesPerDay].
@ProviderFor(CasesPerDay)
final casesPerDayProvider =
    AutoDisposeAsyncNotifierProvider<CasesPerDay, Map<String, int>>.internal(
      CasesPerDay.new,
      name: r'casesPerDayProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$casesPerDayHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CasesPerDay = AutoDisposeAsyncNotifier<Map<String, int>>;
String _$referralStatsHash() => r'b052d5cf00f2fbf513c5de1a99b379a7c32a0593';

/// See also [ReferralStats].
@ProviderFor(ReferralStats)
final referralStatsProvider =
    AutoDisposeAsyncNotifierProvider<ReferralStats, Map<String, int>>.internal(
      ReferralStats.new,
      name: r'referralStatsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$referralStatsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ReferralStats = AutoDisposeAsyncNotifier<Map<String, int>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
