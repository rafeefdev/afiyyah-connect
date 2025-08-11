import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:flutter/material.dart';

Widget tabLegend(
  BuildContext context, {
  required List<Color> indicatorColors,
  required List<String> labels,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ...List.generate(indicatorColors.length, (index) {
        return Row(
          spacing: 8,
          children: [
            Container(height: 18, width: 18, color: indicatorColors[index]),
            Text(labels[index], style: context.textTheme.labelSmall),
          ],
        );
      }),
    ],
  );
}
