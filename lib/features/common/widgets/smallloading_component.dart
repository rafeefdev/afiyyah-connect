import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final String title;
  final String? description;

  const LoadingPage({required this.title, this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        // spacing: AppSpacing.xl,
        children: [
          Text(title, style: context.textTheme.titleLarge),
          CircularProgressIndicator(),
          Text(description ?? '', style: context.textTheme.bodyLarge),
        ],
      ),
    );
  }
}
