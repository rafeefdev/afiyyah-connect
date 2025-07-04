import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:forui/forui.dart';

// Model untuk data penyakit
class DiseaseData {
  final String name;
  final int count;
  final Color color;

  const DiseaseData({
    required this.name,
    required this.count,
    required this.color,
  });
}

// Widget reusable untuk pie chart distribusi penyakit
class DiseaseDistributionChart extends StatefulWidget {
  final List<DiseaseData> diseaseData;
  final String title;
  final double? width;
  final double? height;
  final bool showLegend;
  final bool showPercentage;
  final TextStyle? titleStyle;
  final TextStyle? legendStyle;
  final double radius;
  final double? centerSpaceRadius;

  const DiseaseDistributionChart({
    Key? key,
    required this.diseaseData,
    this.title = 'Distribusi Penyakit',
    this.width,
    this.height,
    this.showLegend = true,
    this.showPercentage = true,
    this.titleStyle,
    this.legendStyle,
    this.radius = 100,
    this.centerSpaceRadius,
  }) : super(key: key);

  @override
  State<DiseaseDistributionChart> createState() =>
      _DiseaseDistributionChartState();
}

class _DiseaseDistributionChartState extends State<DiseaseDistributionChart> {
  int touchedIndex = -1;
  bool _isHovering = false;
  static const int maxLegendItems = 5;

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;

    // Total semua penyakit
    final totalCount = widget.diseaseData.fold<int>(
      0,
      (sum, item) => sum + item.count,
    );

    // Urutkan dan grup jika lebih dari batas
    final sortedData = [...widget.diseaseData]
      ..sort((a, b) => b.count.compareTo(a.count));
    final displayedData = sortedData.take(maxLegendItems).toList();
    final remaining = sortedData.skip(maxLegendItems).toList();

    if (remaining.isNotEmpty) {
      final othersTotal = remaining.fold<int>(
        0,
        (sum, item) => sum + item.count,
      );
      displayedData.add(
        DiseaseData(
          name: 'Lainnya',
          count: othersTotal,
          color: Colors.grey[400]!,
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final radius = max(40.0, width * 0.13);
        final centerSpaceRadius = radius * 0.8;
        final titleFontSize = min(12.0, width * 0.08);
        final legendFontSize = min(13.0, width * 0.05);

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style:
                    widget.titleStyle ??
                    typography.lg.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              // Chart dan Legend
              Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: MouseRegion(
                          onEnter: (_) => setState(() => _isHovering = true),
                          onExit: (_) => setState(() {
                            _isHovering = false;
                            touchedIndex = -1;
                          }),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AspectRatio(
                                aspectRatio: 2.4,
                                child: PieChart(
                                  PieChartData(
                                    pieTouchData: _pieTouchData(),
                                    borderData: FlBorderData(show: false),
                                    sectionsSpace: 1,
                                    centerSpaceRadius: centerSpaceRadius,
                                    sections: _buildPieChartSections(
                                      displayedData,
                                      totalCount,
                                      radius,
                                      titleFontSize,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    totalCount.toString(),
                                    style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Siswa',
                                    style: TextStyle(fontSize: legendFontSize),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Floating Legend
                  if (widget.showLegend && _isHovering && touchedIndex != -1)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: _buildFloatingLegend(
                        displayedData[touchedIndex],
                        totalCount,
                        legendFontSize,
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  PieTouchData _pieTouchData() {
    return PieTouchData(
      touchCallback: (event, pieTouchResponse) {
        setState(() {
          if (!event.isInterestedForInteractions ||
              pieTouchResponse == null ||
              pieTouchResponse.touchedSection == null) {
            touchedIndex = -1;
            return;
          }
          touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
        });
      },
    );
  }

  Widget _buildFloatingLegend(DiseaseData item, int total, double fontSize) {
    final percentage = ((item.count / total) * 100).toStringAsFixed(1);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.75),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: item.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${item.name}: ${item.count} ($percentage%)',
            style:
                widget.legendStyle ??
                context.theme.typography.sm.copyWith(
                  fontSize: fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(
    List<DiseaseData> dataList,
    int total,
    double radius,
    double fontSize,
  ) {
    return dataList.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      final isTouched = index == touchedIndex;
      final sectionRadius = isTouched ? radius + 10 : radius;
      final percentage = ((data.count / total) * 100).toStringAsFixed(1);

      return PieChartSectionData(
        color: data.color,
        value: data.count.toDouble(),
        title: entry.value.name,
        // widget.showPercentage ? '$percentage%' : '',
        radius: sectionRadius,
        titleStyle: context.theme.typography.xs.copyWith(color: Colors.white),
      );
    }).toList();
  }
}

// Factory method untuk kemudahan penggunaan
class DiseaseChartFactory {
  static const Map<String, Color> _defaultColors = {
    'Flu': Color(0xFFFF6B35),
    'Demam': Color(0xFFF7931E),
    'Batuk': Color(0xFFFFD23F),
    'Sakit Perut': Color(0xFF06A5FF),
    'Alergi': Color(0xFF8B5FBF),
    'Maag': Colors.teal,
  };

  static List<DiseaseData> createSampleData() {
    return [
      DiseaseData(name: 'Flu', count: 35, color: _defaultColors['Flu']!),
      DiseaseData(name: 'Demam', count: 25, color: _defaultColors['Demam']!),
      DiseaseData(name: 'Batuk', count: 22, color: _defaultColors['Batuk']!),
      DiseaseData(
        name: 'Sakit Perut',
        count: 15,
        color: _defaultColors['Sakit Perut']!,
      ),
      DiseaseData(name: 'Alergi', count: 8, color: _defaultColors['Alergi']!),
      DiseaseData(name: 'Maag', count: 4, color: _defaultColors['Maag']!),
      DiseaseData(name: 'Gatal2', count: 4, color: _defaultColors['Maag']!),
    ];
  }

  static DiseaseDistributionChart createChart({
    List<DiseaseData>? data,
    String title = 'Distribusi Penyakit',
    double? width,
    double? height,
    bool showLegend = true,
    bool showPercentage = true,
  }) {
    return DiseaseDistributionChart(
      diseaseData: data ?? createSampleData(),
      title: title,
      width: width,
      height: height,
      showLegend: showLegend,
      showPercentage: showPercentage,
    );
  }
}
