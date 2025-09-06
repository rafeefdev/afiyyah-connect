import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/health_input/constants/health_enum.dart';
import 'package:afiyyah_connect/features/health_input/model/pendataan_kesehatan_model.dart';
import 'package:afiyyah_connect/features/health_input/view/widgets/student_search_delegate.dart';
import 'package:afiyyah_connect/features/health_input/view_model/health_input_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HealthInputScreen extends ConsumerStatefulWidget {
  const HealthInputScreen({super.key});

  @override
  ConsumerState<HealthInputScreen> createState() => _HealthInputScreenState();
}

class _HealthInputScreenState extends ConsumerState<HealthInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _santriController = TextEditingController();
  final _keluhanController = TextEditingController();

  String? _selectedSantriId;
  DateTime _mulaiSakit = DateTime.now();
  TimeOfDay _waktuMulaiSakit = TimeOfDay.now();
  final List<String> _keluhanList = [];
  PeriksaKlinikStatus _statusPeriksa = PeriksaKlinikStatus.belumDiperiksa;

  bool _showKeluhanError = false;

  @override
  void dispose() {
    _santriController.dispose();
    _keluhanController.dispose();
    super.dispose();
  }

  void _addKeluhan() {
    if (_keluhanController.text.isNotEmpty) {
      setState(() {
        _showKeluhanError = false; // Hide error when a complaint is added
        _keluhanList.add(_keluhanController.text);
        _keluhanController.clear();
      });
    }
  }

  void _submitForm() {
    // Run final validation before submitting. The button's state should prevent this
    // from being called if invalid, but this is a safeguard.
    if (!_formKey.currentState!.validate() || _keluhanList.isEmpty) {
      // If the list is empty, show the error message.
      setState(() {
        _showKeluhanError = _keluhanList.isEmpty;
      });
      return;
    }

    final model = PendataanKesehatanModel(
      keluhan: _keluhanList,
      mulaiSakit: _mulaiSakit,
      santriId: _selectedSantriId!,
      statusPeriksa: _statusPeriksa,
      waktuMulaiSakit: _waktuMulaiSakit,
    );

    ref.read(healthInputViewModelProvider.notifier).submitData(model);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(healthInputViewModelProvider, (_, state) {
      state.when(
        error: (err, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menyimpan: ${err.toString()}')),
          );
        },
        loading: () => {}, // Optionally show a loading dialog
        data: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data berhasil disimpan')),
          );
          Navigator.of(context).pop();
        },
      );
    });

    final state = ref.watch(healthInputViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Input Data Kesehatan')),
      body: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Santri Search
              TextFormField(
                controller: _santriController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Santri',
                  hintText: 'Cari nama santri',
                  suffixIcon: Icon(Icons.search),
                ),
                onTap: () async {
                  final result = await showSearch<String?>(
                    context: context,
                    delegate: StudentSearchDelegate(),
                  );
                  if (result != null) {
                    setState(() {
                      _selectedSantriId = result;
                      _santriController.text = 'Santri ID: $result';
                    });
                  }
                },
                validator: (value) =>
                    _selectedSantriId == null ? 'Santri harus dipilih' : null,
              ),
              SizedBox(height: AppSpacing.l),

              // Keluhan Input
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _keluhanController,
                      decoration: const InputDecoration(
                        labelText: 'Keluhan',
                        hintText: 'Contoh: Pusing',
                      ),
                      onFieldSubmitted: (_) => _addKeluhan(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addKeluhan,
                  ),
                ],
              ),
              Visibility(
                visible: _showKeluhanError,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Keluhan tidak boleh kosong.',
                    style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
                  ),
                ),
              ),
              Wrap(
                spacing: 8.0,
                children: _keluhanList
                    .map(
                      (keluhan) => Chip(
                        label: Text(keluhan),
                        onDeleted: () =>
                            setState(() => _keluhanList.remove(keluhan)),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: AppSpacing.l),

              // Mulai Sakit (Date & Time)
              _DateTimePickerTile(
                selectedDate: _mulaiSakit,
                selectedTime: _waktuMulaiSakit,
                onChanged: (date, time) {
                  setState(() {
                    _mulaiSakit = date;
                    _waktuMulaiSakit = time;
                  });
                },
              ),
              SizedBox(height: AppSpacing.l),

              // Status Periksa
              DropdownButtonFormField<PeriksaKlinikStatus>(
                initialValue: _statusPeriksa,
                decoration: const InputDecoration(labelText: 'Status Periksa'),
                items: PeriksaKlinikStatus.values
                    .map(
                      (status) => DropdownMenuItem(
                        value: status,
                        child: Text(status.value),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _statusPeriksa = value);
                  }
                },
              ),
              SizedBox(height: AppSpacing.xxl),

              // Submit Button
              ElevatedButton(
                onPressed: state.isLoading ? null : _submitForm,
                child: state.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateTimePickerTile extends StatelessWidget {
  const _DateTimePickerTile({
    required this.selectedDate,
    required this.selectedTime,
    required this.onChanged,
  });

  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final Function(DateTime, TimeOfDay) onChanged;

  @override
  Widget build(BuildContext context) {
    final formattedTime = selectedTime.format(context);
    final formattedDate = DateFormat.yMd().format(selectedDate);

    return ListTile(
      title: const Text('Mulai Sakit'),
      subtitle: Text('$formattedDate $formattedTime'),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
        );
        if (date == null) return;

        // ignore: use_build_context_synchronously
        final time = await showTimePicker(
          context: context,
          initialTime: selectedTime,
        );
        if (time == null) return;

        onChanged(date, time);
      },
    );
  }
}