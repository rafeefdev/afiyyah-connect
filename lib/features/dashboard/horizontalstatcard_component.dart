import 'package:flutter/material.dart';

class HealthStatusCard extends StatelessWidget {
  final String title;
  final int count;
  final List<String> caseDetails;

  const HealthStatusCard({
    super.key,
    required this.title,
    required this.count,
    required this.caseDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Menentukan ukuran font berdasarkan lebar container
          final double width = constraints.maxWidth;
          double titleFontSize = width > 120 ? 14 : 12;
          double countFontSize = width > 120 ? 28 : 24;
          double caseFontSize = width > 120 ? 12 : 10;
          double visitFontSize = width > 120 ? 11 : 9;

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: countFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Perlu Kunjungan",
                  style: TextStyle(
                    fontSize: visitFontSize,
                    color: Colors.red[700],
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 4,
                  runSpacing: 2,
                  children: caseDetails
                      .map(
                        (item) => Text(
                          item,
                          style: TextStyle(
                            fontSize: caseFontSize,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
