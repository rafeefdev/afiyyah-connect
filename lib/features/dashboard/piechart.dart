import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
    this.radius = 80,
    this.centerSpaceRadius,
  }) : super(key: key);

  @override
  State<DiseaseDistributionChart> createState() => _DiseaseDistributionChartState();
}

class _DiseaseDistributionChartState extends State<DiseaseDistributionChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final totalCount = widget.diseaseData.fold<int>(0, (sum, item) => sum + item.count);
    
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            widget.title,
            style: widget.titleStyle ?? 
              const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
          ),
          const SizedBox(height: 20),
          
          // Chart dan Legend
          Flexible(
            child: Row(
              children: [
                // Pie Chart
                Expanded(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 2.4,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 2,
                        centerSpaceRadius: widget.centerSpaceRadius ?? 0,
                        sections: _buildPieChartSections(totalCount),
                      ),
                    ),
                  ),
                ),
                
                // Legend
                if (widget.showLegend) ...[
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: _buildLegend(totalCount),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(int totalCount) {
    return widget.diseaseData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 16.0 : 12.0;
      final radius = isTouched ? widget.radius + 10 : widget.radius;
      final percentage = ((data.count / totalCount) * 100).toStringAsFixed(1);

      return PieChartSectionData(
        color: data.color,
        value: data.count.toDouble(),
        title: widget.showPercentage ? '$percentage%' : '',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: const [
            Shadow(
              color: Colors.black26,
              offset: Offset(1, 1),
              blurRadius: 2,
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildLegend(int totalCount) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.diseaseData.map((data) {
        final percentage = ((data.count / totalCount) * 100).toStringAsFixed(1);
        
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: data.color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: widget.legendStyle ?? 
                        const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${data.count} siswa ($percentage%)',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
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
  };

  static List<DiseaseData> createSampleData() {
    return [
      DiseaseData(name: 'Flu', count: 35, color: _defaultColors['Flu']!),
      DiseaseData(name: 'Demam', count: 25, color: _defaultColors['Demam']!),
      DiseaseData(name: 'Batuk', count: 22, color: _defaultColors['Batuk']!),
      DiseaseData(name: 'Sakit Perut', count: 15, color: _defaultColors['Sakit Perut']!),
      DiseaseData(name: 'Alergi', count: 8, color: _defaultColors['Alergi']!),
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

// Example usage widget
class DiseaseChartExample extends StatelessWidget {
  const DiseaseChartExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease Distribution Chart'),
        backgroundColor: Colors.blue.shade50,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Contoh penggunaan dengan factory
            DiseaseChartFactory.createChart(
              title: 'Distribusi Penyakit Siswa',
              height: 300,
            ),
            
            const SizedBox(height: 20),
            
            // Contoh penggunaan dengan custom data
            DiseaseDistributionChart(
              diseaseData: [
                const DiseaseData(name: 'Hipertensi', count: 45, color: Colors.red),
                const DiseaseData(name: 'Diabetes', count: 30, color: Colors.orange),
                const DiseaseData(name: 'Jantung', count: 20, color: Colors.purple),
                const DiseaseData(name: 'Stroke', count: 15, color: Colors.blue),
              ],
              title: 'Distribusi Penyakit Dewasa',
              height: 300,
              radius: 70,
              centerSpaceRadius: 20,
            ),
          ],
        ),
      ),
    );
  }
}