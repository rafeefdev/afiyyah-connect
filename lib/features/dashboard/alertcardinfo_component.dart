import 'package:afiyyah_connect/features/common/utils/extensions.dart';
import 'package:flutter/material.dart';

Widget alertCard(
  BuildContext context, {
  required String title,
  required String alertMessage,
  IconData icon = Icons.dangerous_rounded,
}) {
  return Card(
    color: Colors.red[50],
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red[700]),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  alertMessage,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
