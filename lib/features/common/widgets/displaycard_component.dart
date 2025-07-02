import 'package:afiyyah_connect/app/core/extensions/texttheme_extension.dart';
import 'package:flutter/material.dart';

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
    child: Center(
      child: Text(
        label,
        style: context.textTheme.titleMedium!.copyWith(color: Colors.white),
      ),
    ),
  );
}
