import 'dart:async';
import 'dart:developer';

import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'santri_search_provider.g.dart';

@riverpod
class SantriSearch extends _$SantriSearch {
  Timer? _debounce;

  @override
  Future<List<Santri>> build() async {
    // Batalkan timer saat provider di-dispose untuk mencegah memory leak
    ref.onDispose(() {
      _debounce?.cancel();
    });
    // Kembalikan list kosong di awal, kita menunggu input pengguna
    return [];
  }

  Future<void> search(String query) async {
    // Jika query kosong, bersihkan hasil dan hentikan proses
    if (query.trim().isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    // Debounce query untuk mencegah panggilan API berlebihan
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      // Atur state ke loading HANYA KETIKA pencarian akan dimulai
      state = const AsyncValue.loading();
      try {
        final supabase = ref.read(supabaseClientProvider);
        // TODO: Ganti 'santri' dengan nama tabel Anda dan 'name' dengan nama kolom yang sesuai
        final response = await supabase
            .from('data_santri')
            .select()
            .ilike('nama', '%$query%')
            .limit(10); // Batasi hasil untuk performa

        log(response.toString());

        final santriList =
            response.map((data) => Santri.fromJson(data)).toList();
        state = AsyncValue.data(santriList);
      } catch (e, s) {
        state = AsyncValue.error(e, s);
      }
    });
  }
}
