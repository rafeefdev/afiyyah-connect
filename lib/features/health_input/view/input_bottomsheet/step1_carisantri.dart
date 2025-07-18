import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
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
          SizedBox(height: AppSpacing.s),
          // TODO : display search result. Replace index with result lenght
          _buildSearchResult(
            context,
            result: List.generate(0, (index) => Santri.generateDummyData()),
          ),
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

Widget _buildSearchResult(
  BuildContext context, {
  required List<Santri> result,
}) {
  return Container(
    height: context.mq.size.height * 0.3,
    margin: EdgeInsets.only(top: 8.0),
    decoration: BoxDecoration(
      border: Border.all(width: 0.05, color: Colors.grey.shade800),
      borderRadius: BorderRadius.circular(10),
    ),
    child: result.isEmpty
        ? Center(
            child: const Text(
              'nama santri yang dicari\nakan ditampilkan di sini',
            ),
          )
        : ListView.builder(
            itemCount: result.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  //TODO : add selected name to form state
                },
                child: ListTile(title: Text(result[index].name)),
              );
            },
          ),
  );
}
