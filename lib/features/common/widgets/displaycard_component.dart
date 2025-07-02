import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

Widget displayCard(
  BuildContext context, {
  required String label,
  required Color backgroundColor,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
      color: backgroundColor,
      border: Border.all(color: Colors.black, width: 0.2),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(child: Text(label, style: context.theme.typography.xl2)),
  );
}
