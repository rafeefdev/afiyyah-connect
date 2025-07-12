import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInfo extends StatelessWidget {
  const DateInfo({
    super.key,
    required this.textTheme,
    this.date,
  });

  final TextTheme textTheme;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    final now = date ?? DateTime.now();
    final formatter = DateFormat('EEEE, d MMMM y'); // Dibuat const untuk efisiensi
    final formatted = formatter.format(now);

    return Text(
      formatted,
      style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
    );
  }
}