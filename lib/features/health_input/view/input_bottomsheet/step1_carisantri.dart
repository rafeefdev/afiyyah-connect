import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:afiyyah_connect/features/common/view_model/santri_search_viewmodel.dart'; // DIUBAH: Import provider baru
import 'package:afiyyah_connect/features/common/widgets/loadingindicator_component.dart';
import 'package:afiyyah_connect/features/health_input/constants/health_input_strings.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/pendataan_kesehatan_provider.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/stepcontroller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Step1CariSantri extends ConsumerStatefulWidget {
  const Step1CariSantri({super.key});

  @override
  ConsumerState<Step1CariSantri> createState() => _Step1CariSantriState();
}

class _Step1CariSantriState extends ConsumerState<Step1CariSantri> {
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Panggil search saat ada perubahan teks
    _nameController.addListener(() {
      ref
          .read(santriSearchViewModelProvider.notifier) // DIUBAH: Gunakan notifier baru
          .search(_nameController.text);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // DIUBAH: Pantau state dari provider baru
    final searchState = ref.watch(santriSearchViewModelProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchNameField(searchState.isLoading),
          SizedBox(height: AppSpacing.s),
          searchState.when(
            data: (result) => _buildSearchResult(context, ref, result: result),
            loading: () => SizedBox(
              height: context.mq.size.height * 0.3,
              child: const Center(child: Text(HealthInputStrings.searching)),
            ),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
          SizedBox(height: AppSpacing.l),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(HealthInputStrings.cancel),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextField _buildSearchNameField(bool isLoading) {
    return TextField(
      controller: _nameController,
      autofocus: true,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: HealthInputStrings.searchHint,
        labelText: HealthInputStrings.searchLabel,
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LoadingIndicator(isLoading: isLoading, loadingSize: 8),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildSearchResult(
    BuildContext context,
    WidgetRef ref, {
    required List<Santri> result,
  }) {
    final containerHeight = context.mq.size.height * 0.3;

    if (_nameController.text.trim().isEmpty) {
      return SizedBox(
        height: containerHeight,
        child: const Center(
          child: Text(
            HealthInputStrings.searchPrompt,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (result.isEmpty) {
      return SizedBox(
        height: containerHeight,
        child: const Center(child: Text(HealthInputStrings.notFound)),
      );
    }

    return Container(
      height: containerHeight,
      margin: const EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        border: Border.all(width: 0.05, color: Colors.grey.shade800),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        itemCount: result.length,
        itemBuilder: (context, index) {
          final santri = result[index];
          return InkWell(
            onTap: () {
              // Set santri yang dipilih ke provider utama
              ref.read(pendataanKesehatanProvider.notifier).setSantri(santri);
              // Pindah ke step selanjutnya
              ref.read(stepcontrollerProviderProvider.notifier).next();
            },
            // Menampilkan nama dan hujroh pada hasil pencarian
            child: ListTile(
              title: Text(santri.nama),
              subtitle: Text(santri.namaHujroh ?? HealthInputStrings.noHujrohData),
            ),
          );
        },
      ),
    );
  }
}