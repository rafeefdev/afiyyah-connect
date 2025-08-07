import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/pendataan_kesehatan_provider.dart';
import 'package:afiyyah_connect/features/health_input/viewmodel/stepcontroller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TODO : connect keluhan list with list of real list of disease
final keluhanList = [
  'Batuk',
  'Pusing',
  'Demam / Panas',
  'Pilek',
  'Masuk Angin',
  'Maag / Asam Lambung',
];

const String lainnya = 'lainnya ...';

class Step3Keluhan extends ConsumerStatefulWidget {
  static String stepTitle = 'Apa Saja yang Dikeluhkan ?';

  const Step3Keluhan({super.key, required this.keluhanList});

  final List<String> keluhanList;

  @override
  ConsumerState<Step3Keluhan> createState() => _Step3KeluhanState();
}

class _Step3KeluhanState extends ConsumerState<Step3Keluhan> {
  bool _isLainnyaSelected = false;
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final healthState = ref.watch(pendataanKesehatanProvider);
    final healthNotifier = ref.read(pendataanKesehatanProvider.notifier);
    final selectedKeluhan = healthState.keluhan;

    // Gabungkan list default dengan keluhan custom dari state, kecuali yang sudah ada
    final allKeluhan = <dynamic>{
      ...widget.keluhanList,
      ...selectedKeluhan.where((k) => !widget.keluhanList.contains(k) && k != lainnya)
    }.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...allKeluhan.map(
              (keluhan) => FilterChip(
                label: Text(keluhan),
                selected: selectedKeluhan.contains(keluhan),
                onSelected: (_) => healthNotifier.toggleKeluhan(keluhan),
              ),
            ),
            FilterChip(
              label: const Text(lainnya),
              selected: _isLainnyaSelected,
              onSelected: (_) {
                setState(() {
                  _isLainnyaSelected = !_isLainnyaSelected;
                });
              },
            ),
          ],
        ),
        if (_isLainnyaSelected) ...[
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan keluhan lain',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Tambah'),
                onPressed: () {
                  if (_textController.text.isNotEmpty) {
                    healthNotifier.toggleKeluhan(_textController.text);
                    _textController.clear();
                  }
                },
              )
            ],
          ),
        ],
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () =>
                  ref.read(stepcontrollerProviderProvider.notifier).previous(),
              child: const Text('kembali'),
            ),
            SizedBox(width: AppSpacing.l),
            FilledButton(
              onPressed: () {
                ref.read(stepcontrollerProviderProvider.notifier).next();
              },
              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size.fromWidth(120)),
              ),
              child: const Text('lanjut'),
            ),
          ],
        ),
      ],
    );
  }
}
