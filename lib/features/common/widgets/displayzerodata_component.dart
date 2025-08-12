import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:flutter/material.dart';

class DisplayZeroData extends StatelessWidget {
  final IconData icon;
  final String message;
  final double? height;

  const DisplayZeroData({
    super.key,
    required this.icon,
    required this.message,
    this.height = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mq.size.width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black54,
          width: 0.2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          Icon(icon, color: Colors.blueGrey),
          Text(
            message,
            textAlign: TextAlign.center,

            style: context.textTheme.bodyLarge!.copyWith(
              color: Colors.blueGrey,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
