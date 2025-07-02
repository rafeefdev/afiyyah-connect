import 'package:flutter/material.dart';

enum ChartPeriod {
  weekly(days: 7, label: 'Hari'),
  monthly(days: 31, label: 'Tanggal');

  const ChartPeriod({required this.days, required this.label});
  
  final int days;
  final String label;
}

/// Model untuk konfigurasi chart
class ChartConfig {
  final ChartPeriod period;
  final Color primaryColor;
  final Color backgroundColor;
  final double lineWidth;
  final double dotRadius;
  final double aspectRatio;
  final Duration animationDuration;
  final Curve animationCurve;
  final bool showGrid;
  final bool showHighestPointIndicator;
  
  const ChartConfig({
    this.period = ChartPeriod.weekly,
    this.primaryColor = Colors.blue,
    this.backgroundColor = Colors.transparent,
    this.lineWidth = 2.0,
    this.dotRadius = 4.0,
    this.aspectRatio = 2.4,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.showGrid = true,
    this.showHighestPointIndicator = true,
  });
  
  ChartConfig copyWith({
    ChartPeriod? period,
    Color? primaryColor,
    Color? backgroundColor,
    double? lineWidth,
    double? dotRadius,
    double? aspectRatio,
    Duration? animationDuration,
    Curve? animationCurve,
    bool? showGrid,
    bool? showHighestPointIndicator,
  }) {
    return ChartConfig(
      period: period ?? this.period,
      primaryColor: primaryColor ?? this.primaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      lineWidth: lineWidth ?? this.lineWidth,
      dotRadius: dotRadius ?? this.dotRadius,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      showGrid: showGrid ?? this.showGrid,
      showHighestPointIndicator: showHighestPointIndicator ?? this.showHighestPointIndicator,
    );
  }
}
