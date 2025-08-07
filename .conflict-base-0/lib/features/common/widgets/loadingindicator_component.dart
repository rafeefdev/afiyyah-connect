import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    required this.isLoading,
    this.loadingSize = 18,
    this.strokeWidth = 2.6,
  });

  final double strokeWidth;
  final double loadingSize;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: SizedBox(
        height: loadingSize,
        width: loadingSize,
        child: CircularProgressIndicator(strokeWidth: strokeWidth),
      ),
    );
  }
}
