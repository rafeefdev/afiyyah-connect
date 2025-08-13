import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BarData {
  const BarData({
    required this.color,
    required this.label,
    required this.value,
  });

  final Color color;
  final String label;
  final double value;
}

class AdaptiveHorizontalBarChart extends StatefulWidget {
  const AdaptiveHorizontalBarChart({
    super.key,
    required this.dataList,
    required this.title,
    this.maxValue,
    this.interval = 5.0,
    this.autoScale = true,
    this.rodWidth = 28,
    this.showGrid = true,
    this.showLegend = true,
    this.customChartAspectRatio = 1.8,
    this.totalUnitLabel = 'Santri',
  });

  final List<BarData> dataList;
  final String title;
  final double? maxValue;
  final double interval;
  final double rodWidth;
  final bool autoScale;
  final bool showGrid;
  final bool showLegend;
  final double customChartAspectRatio;
  final String totalUnitLabel;

  final Color shadowColor = const Color(0xFFCCCCCC);

  @override
  State<AdaptiveHorizontalBarChart> createState() =>
      _AdaptiveHorizontalBarChartState();
}

class _AdaptiveHorizontalBarChartState
    extends State<AdaptiveHorizontalBarChart> {
  int touchedGroupIndex = -1;

  double get currentInterval => widget.interval;

  double get effectiveMaxValue {
    if (widget.maxValue != null) {
      return widget.maxValue!;
    }
    return _calculateOptimalMaxY();
  }

  /// Generates horizontal bar group data
  /// Each group represents one asrama with patient count
  BarChartGroupData generateBarGroup(int x, Color color, double value) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: widget.rodWidth, // Optimal width for horizontal bars
          borderRadius: BorderRadius.circular(4),
          // Subtle gradient for better visual hierarchy
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 0.8), color],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  @override
  Widget build(BuildContext context) {
    final barGroups = widget.dataList.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      return generateBarGroup(index, data.color, data.value);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 8),
          AspectRatio(
            aspectRatio: widget.customChartAspectRatio,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceEvenly,
                rotationQuarterTurns: 1,
                borderData: _borderData(),
                titlesData: _titlesData(),
                gridData: _gridData(),
                barGroups: barGroups,
                maxY: _maxY(),
                minY: 0,
                barTouchData: _barTouchData(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Visibility(visible: widget.showLegend, child: _buildLegendSummary()),
        ],
      ),
    );
  }

  /// Header with contextual information
  Widget _buildHeader(BuildContext context) {
    final totalPatients = widget.dataList.fold<double>(
      0,
      (sum, data) => sum + data.value,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Total: ${totalPatients.toInt()} ${widget.totalUnitLabel}',
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Legend summary that adapts to the number of items using Wrap.
  Widget _buildLegendSummary() {
    final itemCount = widget.dataList.length;

    // Adapt font size based on item count to save space.
    // The more items, the smaller the font, down to a minimum.
    final double baseFontSize = context.textTheme.labelMedium?.fontSize ?? 12.0;
    final double adaptiveFontSize =
        (baseFontSize - (itemCount > 4 ? (itemCount - 4) * 0.5 : 0)).clamp(
          10.0,
          baseFontSize,
        );

    // Adapt spacing based on item count.
    final double adaptiveSpacing =
        (24.0 - (itemCount > 6 ? (itemCount - 6) * 2.0 : 0.0)).clamp(8.0, 24.0);

    // Always use a Wrap for better space utilization and to avoid scrolling.
    return Wrap(
      spacing: adaptiveSpacing, // Horizontal space between items
      runSpacing: 8, // Vertical space between lines
      children: widget.dataList.map((data) {
        return _buildLegendItem(data, adaptiveFontSize);
      }).toList(),
    );
  }

  Widget _buildLegendItem(BarData data, double fontSize) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: data.color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '${data.label}: ${data.value.toInt()}',
          style: context.textTheme.labelMedium?.copyWith(fontSize: fontSize),
        ),
      ],
    );
  }

  BarTouchData _barTouchData() {
    return BarTouchData(
      enabled: true,
      handleBuiltInTouches: false,
      touchTooltipData: BarTouchTooltipData(
        fitInsideHorizontally: true,
        fitInsideVertically: true,
        getTooltipColor: (group) => Colors.black87,
        tooltipMargin: 8,
        tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        tooltipBorderRadius: BorderRadius.circular(8),
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          final data = widget.dataList[groupIndex];
          final total = widget.dataList.fold<double>(
            0,
            (sum, d) => sum + d.value,
          );
          final percentage = total > 0
              ? ((data.value / total) * 100).toStringAsFixed(1)
              : "0.0";

          return BarTooltipItem(
            '',
            const TextStyle(),
            children: [
              TextSpan(
                text: '${data.value.toInt()} ${widget.totalUnitLabel}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                text: '$percentage% dari total',
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                text: data.label,
                style: const TextStyle(color: Colors.white60, fontSize: 10),
              ),
            ],
          );
        },
      ),
      touchCallback: (event, response) {
        setState(() {
          if (event.isInterestedForInteractions && response?.spot != null) {
            touchedGroupIndex = response!.spot!.touchedBarGroupIndex;
          } else {
            touchedGroupIndex = -1;
          }
        });
      },
    );
  }

  double _calculateOptimalMaxY() {
    if (widget.dataList.isEmpty) {
      return widget.interval * 5; // Default max Y if no data
    }
    final maxDataValue = widget.dataList.map((e) => e.value).reduce(math.max);

    if (widget.autoScale) {
      final roundedMax =
          ((maxDataValue / currentInterval).ceil() * currentInterval)
              .toDouble();
      return roundedMax + currentInterval;
    } else {
      return maxDataValue + (maxDataValue * 0.1); // 10% buffer
    }
  }

  double _maxY() {
    return effectiveMaxValue;
  }

  FlGridData _gridData() {
    return FlGridData(
      show: widget.showGrid,
      drawVerticalLine: false,
      horizontalInterval: currentInterval,
      getDrawingHorizontalLine: (value) => FlLine(
        color: Colors.grey.withValues(alpha: 0.2),
        strokeWidth: 0.8,
        dashArray: [3, 3],
      ),
    );
  }

  FlTitlesData _titlesData() {
    return FlTitlesData(
      show: true,
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 50,
          interval: currentInterval,
          getTitlesWidget: (value, meta) {
            if (value % currentInterval == 0 && value <= effectiveMaxValue) {
              return Transform.rotate(
                angle: -1.5708,
                child: Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 100,
          getTitlesWidget: (value, meta) {
            int index = value.toInt();
            if (index < 0 || index >= widget.dataList.length) {
              return const SizedBox.shrink();
            }

            final label = widget.dataList[index].label;

            return SideTitleWidget(
              space: 8.0,
              meta: meta,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 80),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          },
        ),
      ),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  FlBorderData _borderData() {
    return FlBorderData(
      show: true,
      border: Border.symmetric(
        horizontal: BorderSide(color: Colors.grey.withValues(alpha: 0.3), width: 1),
      ),
    );
  }
}

/// Extension untuk business logic yang lebih clean
extension BarDataAnalytics on List<BarData> {
  double get totalValue => fold(0.0, (sum, data) => sum + data.value);

  BarData? get maxData =>
      isEmpty ? null : reduce((a, b) => a.value > b.value ? a : b);

  BarData? get minData =>
      isEmpty ? null : reduce((a, b) => a.value < b.value ? a : b);

  double get averageValue => isEmpty ? 0.0 : totalValue / length;

  /// Healthcare-specific: Check for capacity distribution balance
  bool get isBalancedDistribution {
    if (isEmpty) return true;
    final avg = averageValue;
    return every((data) => (data.value - avg).abs() <= (avg * 0.3));
  }
}
