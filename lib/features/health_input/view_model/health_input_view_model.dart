import 'package:afiyyah_connect/features/health_input/model/pendataan_kesehatan_model.dart';
import 'package:afiyyah_connect/features/health_input/repository/health_input_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'health_input_view_model.g.dart';

@riverpod
class HealthInputViewModel extends _$HealthInputViewModel {
  @override
  FutureOr<void> build() {
    // No-op, initial state is AsyncData(null)
  }

  Future<void> submitData(PendataanKesehatanModel data) async {
    final repository = ref.read(healthInputRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repository.addHealthEntry(data));
  }
}
