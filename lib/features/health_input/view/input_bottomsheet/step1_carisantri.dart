import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:afiyyah_connect/features/common/widgets/loadingindicator_component.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/pendataan_kesehatan_provider.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/santri_search_provider.dart';
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
    _nameController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _nameController.removeListener(_onSearchChanged);
    _nameController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    ref.read(santriSearchProvider.notifier).search(_nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(santriSearchProvider);

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
              child: const Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
          SizedBox(height: AppSpacing.l),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
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
        hintText: 'Ketik untuk mencari nama santri',
        labelText: 'Nama Santri',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LoadingIndicator(isLoading: isLoading, strokeWidth: 2.6),
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
            'Ketik nama santri untuk memulai pencarian',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (result.isEmpty) {
      return SizedBox(
        height: containerHeight,
        child: const Center(
          child: Text('Santri tidak ditemukan.'),
        ),
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
            child: ListTile(title: Text(santri.name)),
          );
        },
      ),
    );
  }
}
