import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_layout_view_model.g.dart';

@riverpod
class MainLayoutViewModel extends _$MainLayoutViewModel {
  @override
  int build() {
    // Mengatur indeks awal ke 0 (Tab 'Beranda')
    return 0;
  }

  /// Memperbarui state saat item navigasi dipilih.
  void onDestinationSelected(int index) {
    state = index;
  }
}
