import 'package:afiyyah_connect/features/common/utils/extension/extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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

class DormBarChartComponent extends StatefulWidget {
  const DormBarChartComponent({
    super.key,
    required this.dataList,
    required this.title,
    this.maxValue,
    this.interval = 5.0,
    this.autoScale = true,
    this.showGrid = true,
  });

  final List<BarData> dataList;
  final String title;
  final double? maxValue;
  final double interval;
  final bool autoScale;
  final bool showGrid;

  final Color shadowColor = const Color(0xFFCCCCCC);

  @override
  State<DormBarChartComponent> createState() => _DormBarChartState();
}

class _DormBarChartState extends State<DormBarChartComponent> {
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
          width: 28, // Optimal width for horizontal bars
          borderRadius: BorderRadius.circular(4),
          // Subtle gradient for better visual hierarchy
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color],
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
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          AspectRatio(
            // Optimized for horizontal layout with multiple items
            aspectRatio: 1.8,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceEvenly,
                // Key: Rotate for horizontal presentation
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
          const SizedBox(height: 12),
          _buildLegendSummary(),
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
          'Total: ${totalPatients.toInt()} Santri',
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Legend summary untuk context tambahan
  Widget _buildLegendSummary() {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: widget.dataList.map((data) {
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
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        );
      }).toList(),
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
          final percentage = ((data.value / total) * 100).toStringAsFixed(1);

          return BarTooltipItem(
            '',
            const TextStyle(),
            children: [
              // // Status indicator
              // TextSpan(text: '📊 ', style: const TextStyle(fontSize: 14)),
              // // Primary metric
              TextSpan(
                text: '${data.value.toInt()} Santri',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: '\n'),
              // Secondary context
              TextSpan(
                text: '$percentage% dari total',
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
              const TextSpan(text: '\n'),
              // Location identifier
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
    final maxDataValue = widget.dataList
        .map((e) => e.value)
        .reduce((a, b) => a > b ? a : b);

    if (widget.autoScale) {
      // Business rule: Always provide some headroom for visualization clarity
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
        color: Colors.grey.withOpacity(0.2),
        strokeWidth: 0.8,
        dashArray: [3, 3], // Subtle dashed lines
      ),
    );
  }

  FlTitlesData _titlesData() {
    return FlTitlesData(
      show: true,
      // Y-axis (values) - rotated to be horizontal scale
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 50,
          interval: currentInterval,
          getTitlesWidget: (value, meta) {
            if (value % currentInterval == 0 && value <= effectiveMaxValue) {
              return Transform.rotate(
                angle: -1.5708, // Counter-rotate for readability
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
      // X-axis (categories) - rotated to be vertical labels
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 100, // Increased for better label accommodation
          getTitlesWidget: (value, meta) {
            int index = value.toInt();
            if (index < 0 || index >= widget.dataList.length) {
              return const SizedBox.shrink();
            }

            final label = widget.dataList[index].label;

            return SideTitleWidget(
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
                  textAlign: TextAlign.start,
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
        horizontal: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
      ),
    );
  }
}

/// Extension untuk business logic yang lebih clean
extension BarDataAnalytics on List<BarData> {
  double get totalValue => fold(0.0, (sum, data) => sum + data.value);

  BarData get maxData => reduce((a, b) => a.value > b.value ? a : b);

  BarData get minData => reduce((a, b) => a.value < b.value ? a : b);

  double get averageValue => totalValue / length;

  /// Healthcare-specific: Check for capacity distribution balance
  bool get isBalancedDistribution {
    final avg = averageValue;
    return every((data) => (data.value - avg).abs() <= (avg * 0.3));
  }
}
