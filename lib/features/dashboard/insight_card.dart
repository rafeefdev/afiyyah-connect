import 'package:flutter/material.dart';

Widget insightCard(
  BuildContext context, {
  required String title,
  required String value,
  required String explanation,
}) {
  final textTheme = Theme.of(context).textTheme;
  return Expanded(
    child: SizedBox(
      height: 144,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey[300]!, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.titleSmall),
              const SizedBox(height: 4),
              Text(
                value,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                explanation,
                style: textTheme.bodySmall,
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
