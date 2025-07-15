import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:flutter/material.dart';

class OverlayImageCard extends StatelessWidget {
  final String imageLink;
  final String title;
  final VoidCallback? onTap;

  const OverlayImageCard({
    super.key,
    required this.imageLink,
    required this.title,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              // color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 0.01),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageLink),
              ),
            ),
          ),
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                // stops: [0.1, 0.2, 0.4],
                colors: [Colors.black, Colors.transparent],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: context.textTheme.titleMedium!.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
