import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInfo extends StatelessWidget {
  const DateInfo({
    super.key,
    required this.textTheme,
    this.date,
    this.customTextStyle,
    this.customTextAlign
  });

  final TextTheme textTheme;
  final DateTime? date;
  final TextStyle? customTextStyle;
  final TextAlign? customTextAlign;

  @override
  Widget build(BuildContext context) {
    final now = date ?? DateTime.now();
    final formatter = DateFormat(
      'EEEE\nd MMMM y',
    ); // Dibuat const untuk efisiensi
    final formatted = formatter.format(now);

    return Text(
      formatted,
      textAlign: customTextAlign ?? TextAlign.right,
      style:
          customTextStyle ?? textTheme.labelLarge?.copyWith(color: Colors.grey),
    );
  }
}
