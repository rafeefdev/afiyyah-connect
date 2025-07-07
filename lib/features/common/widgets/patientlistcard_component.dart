import 'package:afiyyah_connect/app/core/model/entities/santri.dart';
import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extensions.dart';
import 'package:flutter/material.dart';

String getInitials(String inputString) {
  if (inputString.isEmpty) {
    return ''; // Mengembalikan string kosong jika inputnya kosong
  }

  List<String> words = inputString.split(
    ' ',
  ); // Memisahkan string berdasarkan spasi
  String initials = '';

  for (String word in words) {
    if (word.isNotEmpty) {
      initials += word[0]
          .toUpperCase(); // Mengambil huruf pertama dan mengubahnya menjadi huruf kapital
    }
  }

  return initials;
}

Widget listCardItem(
  BuildContext context, {
  required Santri santri,
  String status = 'SEGERA RUJUK',
  bool isAlert = true,
  Color customStatusColor = Colors.red,
}) {
  String santriInitial = getInitials(santri.name);

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(child: Text(santriInitial)),
          SizedBox(width: AppSpacing.m),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
                  style: context.textTheme.labelSmall!.copyWith(
                    color: Colors.red.shade900,
                  ),
                ),
              ),
              Text(santri.name, style: context.textTheme.bodyLarge),
              Text(
                'Kelas 10A • Kamar A-15 • Alergi Akut',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          Spacer(),
          FilledButton(onPressed: () {}, child: const Text('proses')),
        ],
      ),
    ),
  );
}
