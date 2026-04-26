// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_history_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$medicalHistoryViewModelHash() =>
    r'ab53da4e7cb76f31bf50d650780ba7ee211693c3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$MedicalHistoryViewModel
    extends BuildlessAutoDisposeAsyncNotifier<MedicalHistoryData?> {
  late final String studentId;

  FutureOr<MedicalHistoryData?> build(String studentId);
}

/// See also [MedicalHistoryViewModel].
@ProviderFor(MedicalHistoryViewModel)
const medicalHistoryViewModelProvider = MedicalHistoryViewModelFamily();

/// See also [MedicalHistoryViewModel].
class MedicalHistoryViewModelFamily
    extends Family<AsyncValue<MedicalHistoryData?>> {
  /// See also [MedicalHistoryViewModel].
  const MedicalHistoryViewModelFamily();

  /// See also [MedicalHistoryViewModel].
  MedicalHistoryViewModelProvider call(String studentId) {
    return MedicalHistoryViewModelProvider(studentId);
  }

  @override
  MedicalHistoryViewModelProvider getProviderOverride(
    covariant MedicalHistoryViewModelProvider provider,
  ) {
    return call(provider.studentId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'medicalHistoryViewModelProvider';
}

/// See also [MedicalHistoryViewModel].
class MedicalHistoryViewModelProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          MedicalHistoryViewModel,
          MedicalHistoryData?
        > {
  /// See also [MedicalHistoryViewModel].
  MedicalHistoryViewModelProvider(String studentId)
    : this._internal(
        () => MedicalHistoryViewModel()..studentId = studentId,
        from: medicalHistoryViewModelProvider,
        name: r'medicalHistoryViewModelProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$medicalHistoryViewModelHash,
        dependencies: MedicalHistoryViewModelFamily._dependencies,
        allTransitiveDependencies:
            MedicalHistoryViewModelFamily._allTransitiveDependencies,
        studentId: studentId,
      );

  MedicalHistoryViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.studentId,
  }) : super.internal();

  final String studentId;

  @override
  FutureOr<MedicalHistoryData?> runNotifierBuild(
    covariant MedicalHistoryViewModel notifier,
  ) {
    return notifier.build(studentId);
  }

  @override
  Override overrideWith(MedicalHistoryViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: MedicalHistoryViewModelProvider._internal(
        () => create()..studentId = studentId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        studentId: studentId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    MedicalHistoryViewModel,
    MedicalHistoryData?
  >
  createElement() {
    return _MedicalHistoryViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MedicalHistoryViewModelProvider &&
        other.studentId == studentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, studentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MedicalHistoryViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<MedicalHistoryData?> {
  /// The parameter `studentId` of this provider.
  String get studentId;
}

class _MedicalHistoryViewModelProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          MedicalHistoryViewModel,
          MedicalHistoryData?
        >
    with MedicalHistoryViewModelRef {
  _MedicalHistoryViewModelProviderElement(super.provider);

  @override
  String get studentId => (origin as MedicalHistoryViewModelProvider).studentId;
}

String _$studentHealthRecordHash() =>
    r'3d2229ec5b446b7fff728535b088a12367b57082';

abstract class _$StudentHealthRecord
    extends BuildlessAutoDisposeAsyncNotifier<RiwayatKesehatanSantriModel?> {
  late final String studentId;

  FutureOr<RiwayatKesehatanSantriModel?> build(String studentId);
}

/// See also [StudentHealthRecord].
@ProviderFor(StudentHealthRecord)
const studentHealthRecordProvider = StudentHealthRecordFamily();

/// See also [StudentHealthRecord].
class StudentHealthRecordFamily
    extends Family<AsyncValue<RiwayatKesehatanSantriModel?>> {
  /// See also [StudentHealthRecord].
  const StudentHealthRecordFamily();

  /// See also [StudentHealthRecord].
  StudentHealthRecordProvider call(String studentId) {
    return StudentHealthRecordProvider(studentId);
  }

  @override
  StudentHealthRecordProvider getProviderOverride(
    covariant StudentHealthRecordProvider provider,
  ) {
    return call(provider.studentId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'studentHealthRecordProvider';
}

/// See also [StudentHealthRecord].
class StudentHealthRecordProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          StudentHealthRecord,
          RiwayatKesehatanSantriModel?
        > {
  /// See also [StudentHealthRecord].
  StudentHealthRecordProvider(String studentId)
    : this._internal(
        () => StudentHealthRecord()..studentId = studentId,
        from: studentHealthRecordProvider,
        name: r'studentHealthRecordProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$studentHealthRecordHash,
        dependencies: StudentHealthRecordFamily._dependencies,
        allTransitiveDependencies:
            StudentHealthRecordFamily._allTransitiveDependencies,
        studentId: studentId,
      );

  StudentHealthRecordProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.studentId,
  }) : super.internal();

  final String studentId;

  @override
  FutureOr<RiwayatKesehatanSantriModel?> runNotifierBuild(
    covariant StudentHealthRecord notifier,
  ) {
    return notifier.build(studentId);
  }

  @override
  Override overrideWith(StudentHealthRecord Function() create) {
    return ProviderOverride(
      origin: this,
      override: StudentHealthRecordProvider._internal(
        () => create()..studentId = studentId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        studentId: studentId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    StudentHealthRecord,
    RiwayatKesehatanSantriModel?
  >
  createElement() {
    return _StudentHealthRecordProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StudentHealthRecordProvider && other.studentId == studentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, studentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StudentHealthRecordRef
    on AutoDisposeAsyncNotifierProviderRef<RiwayatKesehatanSantriModel?> {
  /// The parameter `studentId` of this provider.
  String get studentId;
}

class _StudentHealthRecordProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          StudentHealthRecord,
          RiwayatKesehatanSantriModel?
        >
    with StudentHealthRecordRef {
  _StudentHealthRecordProviderElement(super.provider);

  @override
  String get studentId => (origin as StudentHealthRecordProvider).studentId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
