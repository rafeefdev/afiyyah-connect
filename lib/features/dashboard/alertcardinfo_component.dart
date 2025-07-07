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
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rujukan Rumah Sakit',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('2 Santri butuh penangangan rumah sakit'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
