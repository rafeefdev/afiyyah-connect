import 'package:afiyyah_connect/app/core/extensions/texttheme_extension.dart';
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  String title;
  String value;
  String subtitle;
  StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 0.1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(alignment: Alignment.topRight, child: CircleAvatar()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textTheme.titleMedium!.copyWith(
                  color: Color(0xff64748B),
                ),
              ),
              Text(
                value,
                style: context.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  double fontSize = 12;
                  if (constraints.maxWidth < 150) {
                    fontSize = 10;
                  } else if (constraints.maxWidth < 100) {
                    fontSize = 8;
                  }
                  return Text(
                    subtitle,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: Color(0xff64748B),
                      fontSize: 12
                    ),
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
