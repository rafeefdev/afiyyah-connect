import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:afiyyah_connect/features/health_input/constants/health_input_strings.dart';
import 'package:afiyyah_connect/features/health_input/view_model/pendataan_kesehatan_provider.dart';
import 'package:afiyyah_connect/features/health_input/view_model/stepcontroller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class Step4SejakKapan extends ConsumerStatefulWidget {
  static String stepTitle = HealthInputStrings.step4Title;

  const Step4SejakKapan({super.key});

  @override
  ConsumerState<Step4SejakKapan> createState() => _Step4SejakKapanState();
}

class _Step4SejakKapanState extends ConsumerState<Step4SejakKapan> {
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize fields if data already exists in the provider
    final sickTime = ref.read(pendataanKesehatanProvider).sickStartTime;
    if (sickTime != null) {
      _dateController.text = DateFormat('d MMMM y').format(sickTime);
      _timeController.text = DateFormat('HH:mm').format(sickTime);
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final notifier = ref.read(pendataanKesehatanProvider.notifier);
    final currentState = ref.read(pendataanKesehatanProvider);
    final initialDate = currentState.sickStartTime ?? DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2025, 1, 1),
      lastDate: DateTime(2030, 12, 30),
      initialDate: initialDate,
    );

    if (pickedDate != null) {
      final currentSickTime = currentState.sickStartTime ?? DateTime.now();
      final newSickTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        currentSickTime.hour,
        currentSickTime.minute,
      );
      notifier.setSickStartTime(newSickTime);
      setState(() {
        _dateController.text = DateFormat('d MMMM y').format(newSickTime);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final notifier = ref.read(pendataanKesehatanProvider.notifier);
    final currentState = ref.read(pendataanKesehatanProvider);
    final initialTime = TimeOfDay.fromDateTime(
      currentState.sickStartTime ?? DateTime.now(),
    );

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      final currentSickTime = currentState.sickStartTime ?? DateTime.now();
      final newSickTime = DateTime(
        currentSickTime.year,
        currentSickTime.month,
        currentSickTime.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      notifier.setSickStartTime(newSickTime);
      setState(() {
        _timeController.text = DateFormat('HH:mm').format(newSickTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: _dateController.text.isEmpty || _timeController.text.isEmpty,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Text(
              HealthInputStrings.emptyTimeInfoMessage,
              style: context.textTheme.labelLarge!.copyWith(color: Colors.red),
            ),
          ),
        ),
        Row(
          children: [
            Flexible(
              child: TextField(
                controller: _dateController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  label: Text(HealthInputStrings.dateHint),
                  // hintText: HealthInputStrings.dateHint,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
            ),
            SizedBox(width: AppSpacing.m),
            Flexible(
              child: TextField(
                controller: _timeController,
                readOnly: true,
                onTap: () => _selectTime(context),
                decoration: InputDecoration(
                  // hintText: HealthInputStrings.timeHint,
                  label: Text(HealthInputStrings.timeHint),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.access_time),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                fixedSize: Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () =>
                  ref.read(stepcontrollerProviderProvider.notifier).previous(),
              child: const Text(HealthInputStrings.previous),
            ),
            SizedBox(width: AppSpacing.m),
            FilledButton(
              onPressed: () {
                // when datetime didn't changed
                if (_dateController.text.isNotEmpty &&
                    _timeController.text.isNotEmpty) {
                  ref.read(stepcontrollerProviderProvider.notifier).next();
                }
              },
              child: const Text(HealthInputStrings.next),
            ),
          ],
        ),
      ],
    );
  }
}
