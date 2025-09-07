import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/features/health_input/model/pendataan_kesehatan_model.dart';
import 'package:afiyyah_connect/features/health_input/model/periksaklinikstatus_model.dart';
import 'package:afiyyah_connect/features/health_input/view_model/health_input_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pendataan_kesehatan_provider.g.dart';

class PendataanKesehatanState {
  final Santri? santri;
  final List<String> keluhan;
  final DateTime? sickStartTime;
  final PeriksaKlinikStatus periksaKlinikStatus;
  final bool isSubmitting;
  final String? errorMessage; // Tambahkan field untuk error message

  PendataanKesehatanState({
    this.santri,
    this.keluhan = const [],
    this.sickStartTime,
    this.periksaKlinikStatus = PeriksaKlinikStatus.none,
    this.isSubmitting = false,
    this.errorMessage, // Hapus inisialisasi redundan
  });

  PendataanKesehatanState copyWith({
    Santri? santri,
    List<String>? keluhan,
    DateTime? sickStartTime,
    PeriksaKlinikStatus? periksaKlinikStatus,
    bool? isSubmitting,
    String? errorMessage, // Tambahkan parameter untuk error message
  }) {
    return PendataanKesehatanState(
      santri: santri ?? this.santri,
      keluhan: keluhan ?? this.keluhan,
      sickStartTime: sickStartTime ?? this.sickStartTime,
      periksaKlinikStatus: periksaKlinikStatus ?? this.periksaKlinikStatus,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage, // Salin field error message
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
    // Reset error message sebelum submit
    if (state.errorMessage != null) {
      state = state.copyWith(errorMessage: null);
    }

    state = state.copyWith(isSubmitting: true);

    try {
      await ref.read(healthInputViewModelProvider.notifier).submitData(
            PendataanKesehatanModel(
              keluhan: state.keluhan,
              mulaiSakit: state.sickStartTime!,
              santriId: state.santri!.id,
              statusPeriksa: state.periksaKlinikStatus,
              // Tambahkan field lain jika diperlukan, misalnya waktuMulaiSakit
            ),
          );
      // Jika berhasil, reset form
      reset();
    } on Exception catch (e) {
      // Tangani error secara spesifik
      final errorMessage = e.toString(); // Atau buat pesan yang lebih user-friendly
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: errorMessage,
      );
      // Anda bisa melempar ulang error jika perlu ditangani di layer UI
      // rethrow;
    } catch (e) {
      // Tangani error non-Exception
      final errorMessage = 'An unexpected error occurred.';
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: errorMessage,
      );
      // Log error jika diperlukan
      // Logger.severe('Unexpected error in submitData', e);
    }
    // Tidak perlu reset() atau setState isSubmitting=false di luar blok try/catch
    // karena reset() sudah ada di dalam blok sukses, dan setState ada di blok error.
  }

  void reset() {
    state = PendataanKesehatanState(); // Ini akan mereset semua field ke default
  }
}
