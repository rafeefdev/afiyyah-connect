import 'dart:async';

import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/features/common/repository/santri_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'santri_search_viewmodel.g.dart';

@riverpod
class SantriSearchViewModel extends _$SantriSearchViewModel {
  Timer? _debounce;

  @override
  Future<List<Santri>> build() async {
    // Batalkan timer saat provider tidak lagi digunakan
    ref.onDispose(() {
      _debounce?.cancel();
    });
    // State awal adalah list kosong, tidak ada data untuk ditampilkan
    return [];
  }

  /// Memulai pencarian santri dengan mekanisme debounce untuk efisiensi.
  Future<void> search(String query) async {
    // Jika query kosong, langsung kembalikan state ke data kosong.
    if (query.trim().isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    // Batalkan timer sebelumnya jika ada, untuk memulai yang baru
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    
    // Atur timer debounce
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      // Set state ke loading sesaat sebelum memanggil repository
      state = const AsyncValue.loading();
      try {
        // Ambil repository dan panggil method search
        final repository = ref.read(santriRepositoryProvider);
        final santriList = await repository.searchSantri(query);
        
        // Update state dengan data baru
        state = AsyncValue.data(santriList);
      } catch (e, s) {
        // Update state dengan error
        state = AsyncValue.error(e, s);
      }
    });
  }
}
