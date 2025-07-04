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
  final double? maxValue; // Nilai maksimal custom
  final double interval; // Interval yang dapat dikustomisasi
  final bool autoScale; // Apakah menggunakan auto scaling
  final bool showGrid; // Kontrol tampilan grid

  final Color shadowColor = const Color(0xFFCCCCCC);

  @override
  State<DormBarChartComponent> createState() => _DormBarChartState();
}

class _DormBarChartState extends State<DormBarChartComponent> {
  int touchedGroupIndex = -1;
  int rotationTurns = 1;

  // Getter untuk interval yang dapat dikustomisasi
  double get currentInterval => widget.interval;

  // Getter untuk nilai maksimal yang fleksibel
  double get effectiveMaxValue {
    if (widget.maxValue != null) {
      return widget.maxValue!;
    }
    return _calculateOptimalMaxY();
  }

  BarChartGroupData generateBarGroup(int x, Color color, double value) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 52,
          borderRadius: BorderRadius.circular(10),
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
        children: [
          Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          Expanded(
            child: AspectRatio(
              aspectRatio: 2.4,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  rotationQuarterTurns: rotationTurns,
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
          ),
        ],
      ),
    );
  }

  BarTouchData _barTouchData() {
    return BarTouchData(
      enabled: true,
      handleBuiltInTouches: false,
      touchTooltipData: BarTouchTooltipData(
        fitInsideHorizontally: true,
        fitInsideVertically: true,
        getTooltipColor: (group) => Colors.black.withOpacity(0.8),
        tooltipMargin: 8,
        tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        tooltipBorderRadius: BorderRadius.circular(8),
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          final data = widget.dataList[groupIndex];

          // Menggunakan Rich Text dengan TextSpan untuk styling yang kompleks
          return BarTooltipItem(
            '',
            const TextStyle(),
            children: [
              // Color indicator menggunakan Unicode character
              TextSpan(
                text: '● ',
                style: TextStyle(
                  color: data.color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Main value
              TextSpan(
                text: '${data.value.toInt()} Orang',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Line break
              const TextSpan(text: '\n'),
              // Category label
              TextSpan(
                text: data.label,
                style: const TextStyle(color: Colors.white70, fontSize: 10),
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
      // Auto scaling: bulatkan ke atas ke kelipatan interval terdekat
      final roundedMax =
          ((maxDataValue / currentInterval).ceil() * currentInterval)
              .toDouble();
      return roundedMax + currentInterval;
    } else {
      // Manual scaling: gunakan nilai maksimal data + buffer
      return maxDataValue + 2;
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
      getDrawingHorizontalLine: (value) =>
          FlLine(color: Colors.grey.withOpacity(0.3), strokeWidth: 1),
    );
  }

  FlTitlesData _titlesData() {
    return FlTitlesData(
      show: true,
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 80,
          interval: currentInterval,
          getTitlesWidget: (value, meta) {
            // Untuk horizontal chart, left titles menjadi bottom labels
            if (value % currentInterval == 0 && value <= effectiveMaxValue) {
              return Transform.rotate(
                angle:
                    -1.5708, // Counter-rotate 90 derajat untuk horizontal readability
                child: Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
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
          reservedSize: 80,
          getTitlesWidget: (value, meta) {
            int index = value.toInt();
            if (index < 0 || index >= widget.dataList.length) {
              return const SizedBox.shrink();
            }
            // Counter-rotate untuk readability dalam horizontal chart
            return Transform.rotate(
              angle: -1.5708, // Counter-rotate 90 derajat
              child: SideTitleWidget(
                meta: meta,
                child: Text(
                  widget.dataList[index].label,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      rightTitles: const AxisTitles(),
      topTitles: const AxisTitles(),
    );
  }

  FlBorderData _borderData() {
    return FlBorderData(
      show: true,
      border: Border.symmetric(
        horizontal: const BorderSide(color: Colors.black),
      ),
    );
  }
}
