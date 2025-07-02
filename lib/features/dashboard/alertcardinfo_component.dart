import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

Widget alertCard(
  BuildContext context, {
  required String title,
  required String alertMessage,
  IconData icon = Icons.dangerous_rounded,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFFEBEE),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE57373), width: 1),
    ),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFFE57373)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.theme.typography.xl2),
              Text(alertMessage, style: context.theme.typography.sm),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFD32F2F),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text('Lihat', style: context.theme.typography.xl),
        ),
      ],
    ),
  );
}
