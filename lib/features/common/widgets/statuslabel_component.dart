import 'package:flutter/material.dart';

Container statusLabel(Color statusColor, String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Color(0xFFDC2626),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
