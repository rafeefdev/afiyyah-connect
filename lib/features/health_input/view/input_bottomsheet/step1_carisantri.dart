import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:afiyyah_connect/features/common/widgets/loadingindicator_component.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/stepcontroller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Step1CariSantri extends ConsumerWidget {
  final nameController = TextEditingController();

  Step1CariSantri({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO : insert search state here (make sure this variable is assigned to future value)
    bool isLoading = true;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchNameField(isLoading),
          // TODO : display search result. Replace index with result lenght
          ..._buildNameResult(context, resultLength: 5),
          SizedBox(height: AppSpacing.l),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: AppSpacing.m,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('batal'),
              ),
              FilledButton(
                onPressed: () {
                  //TODO : implement search algorythm
                  ref.read(stepcontrollerProviderProvider.notifier).next();
                },
                child: const Text('cari'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextField _buildSearchNameField(bool isLoading) {
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hint: const Text('Ketik untuk mencari nama santri'),
        label: const Text('Nama Santri'),
        prefixIcon: const Icon(Icons.search_rounded),
        suffix: LoadingIndicator(isLoading: isLoading, strokeWidth: 2.6),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

List<Widget> _buildNameResult(
  BuildContext context, {
  required int resultLength,
}) {
  return List.generate(resultLength, (index) {
    return InkWell(
      onTap: () {
        // TODO : add selected name to input data
      },
      child: ListTile(
        title: Text(
          'Fathan bin Fulan',
          style: context.textTheme.bodyLarge!.copyWith(
            color: Colors.grey.shade800,
          ),
        ),
      ),
    );
  });
}
