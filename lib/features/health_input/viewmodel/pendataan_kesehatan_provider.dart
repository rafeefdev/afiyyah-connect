import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/features/health_input/data/model/periksaklinikstatus_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pendataan_kesehatan_provider.g.dart';

class PendataanKesehatanState {
  final Santri? santri;
  final List<String> keluhan;
  final DateTime? sickStartTime;
  final PeriksaKlinikStatus periksaKlinikStatus;
  final bool isSubmitting;

  PendataanKesehatanState({
    this.santri,
    this.keluhan = const [],
    this.sickStartTime,
    this.periksaKlinikStatus = PeriksaKlinikStatus.none,
    this.isSubmitting = false,
  });

  PendataanKesehatanState copyWith({
    Santri? santri,
    List<String>? keluhan,
    DateTime? sickStartTime,
    PeriksaKlinikStatus? periksaKlinikStatus,
    bool? isSubmitting,
  }) {
    return PendataanKesehatanState(
      santri: santri ?? this.santri,
      keluhan: keluhan ?? this.keluhan,
      sickStartTime: sickStartTime ?? this.sickStartTime,
      periksaKlinikStatus: periksaKlinikStatus ?? this.periksaKlinikStatus,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

@Riverpod(keepAlive: true)
class PendataanKesehatan extends _$PendataanKesehatan {
  @override
  PendataanKesehatanState build() {
    return PendataanKesehatanState();
  }

  void setSantri(Santri santri) {
    state = state.copyWith(santri: santri);
  }

  void toggleKeluhan(String keluhan) {
    final currentKeluhan = List<String>.from(state.keluhan);
    if (currentKeluhan.contains(keluhan)) {
      currentKeluhan.remove(keluhan);
    } else {
      currentKeluhan.add(keluhan);
    }
    state = state.copyWith(keluhan: currentKeluhan);
  }

  void setSickStartTime(DateTime sickStartTime) {
    state = state.copyWith(sickStartTime: sickStartTime);
  }

  void setKlinikStatus(PeriksaKlinikStatus status) {
    state = state.copyWith(periksaKlinikStatus: status);
  }

  Future<void> submitData() async {
    state = state.copyWith(isSubmitting: true);
    // Here you would typically send the data to a repository or API
    // For example: await ref.read(healthRepositoryProvider).addHealthRecord(state);
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    state = state.copyWith(isSubmitting: false);
    reset();
  }

  void reset() {
    state = PendataanKesehatanState();
  }
}
