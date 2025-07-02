import 'package:afiyyah_connect/app/core/model/santri.dart';
import 'package:afiyyah_connect/features/common/widgets/statuslabel_component.dart';
import 'package:flutter/material.dart';

Widget patientCard({
    required Santri santri,
    required String condition,
    required String avatar,
    required String status,
    required Color statusColor,
    bool isReferral = true,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: isReferral ? Colors.red : Color(0xFF1976D2),
            child: Text(
              avatar,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                statusLabel(isReferral ? Color(0xFFFEE2E2) : statusColor, status),
                Text(
                  santri.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${santri.kelas} · ${santri.hujroh} · $condition',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          FilledButton(onPressed: () {}, child: const Text('detail')),
        ],
      ),
    );
  }
