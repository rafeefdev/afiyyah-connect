
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyHealthChart extends StatefulWidget {
  final List<double> healthScores; // Misalnya [4.0, 5.5, 5.0, 6.0, 4.5, 4.0, 3.5]

  const WeeklyHealthChart({super.key, required this.healthScores});

  @override
  State<WeeklyHealthChart> createState() => _WeeklyHealthChartState();
}

class _WeeklyHealthChartState extends State<WeeklyHealthChart> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    final List<double> paddedScores = List.from(widget.healthScores);
    while (paddedScores.length < 7) {
      paddedScores.add(0);
    }
    final highestIndex = _findMaxIndex(paddedScores);
    return AspectRatio(
      aspectRatio: 1.7,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                axisNameWidget: const Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Text('Hari', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                ),
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _dayLabel(value.toInt()),
                      style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                    ),
                  ),
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (color)=> Colors.blueAccent,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((spot) {
                    return LineTooltipItem(
                      '${spot.y}',
                      const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    );
                  }).toList();
                },
              ),
              touchCallback: (event, response) {
                setState(() {
                  if (!event.isInterestedForInteractions || response == null || response.lineBarSpots == null) {
                    touchedIndex = null;
                    return;
                  }
                  touchedIndex = response.lineBarSpots!.first.spotIndex;
                });
              },
              handleBuiltInTouches: true,
            ),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(
                  paddedScores.length,
                  (i) => FlSpot(i.toDouble(), paddedScores[i]),
                ),
                isCurved: true,
                color: Colors.blue,
                barWidth: 2,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: Colors.blue,
                      strokeWidth: 1,
                      strokeColor: Colors.white,
                    );
                  },
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [Colors.blue.withOpacity(0.3), Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                isStrokeCapRound: true,
                curveSmoothness: 0.2,
              )
            ],
            extraLinesData: ExtraLinesData(
              extraLinesOnTop: true,
              verticalLines: [
                VerticalLine(
                  x: highestIndex.toDouble(),
                  color: Colors.blue,
                  strokeWidth: 1.5,
                  dashArray: [4, 2],
                ),
              ],
            ),
          ),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  int _findMaxIndex(List<double> list) {
    double maxVal = list[0];
    int maxIndex = 0;
    for (int i = 1; i < list.length; i++) {
      if (list[i] > maxVal) {
        maxVal = list[i];
        maxIndex = i;
      }
    }
    return maxIndex;
  }

  String _dayLabel(int index) {
    const days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    return days[index % 7];
  }
}
