import 'package:afiyyah_connect/app/core/services/supabase_service.dart';
import 'package:afiyyah_connect/features/dashboard/model/dashboard_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_provider.g.dart';

@Riverpod(keepAlive: true)
class DashboardNotifier extends _$DashboardNotifier {
  @override
  Future<DashboardData> build() async {
    final client = ref.watch(supabaseClientProvider);
    client.from('pendataan_kesehatan');
    return DashboardData();
  }
}
