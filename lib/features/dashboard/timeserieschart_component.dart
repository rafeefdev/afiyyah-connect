import 'package:afiyyah_connect/features/dashboard/timeserieschart_config.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Widget untuk menampilkan chart kesehatan dengan periode weekly/monthly
class Timeserieschart extends StatefulWidget {
  final List<double> healthScores;
  final ChartConfig config;
  final String? title;
  final ValueChanged<int>? onPointTapped;

  const Timeserieschart({
    super.key,
    required this.healthScores,
    this.config = const ChartConfig(),
    this.title,
    this.onPointTapped,
  });

  @override
  State<Timeserieschart> createState() => _TimeSeriesChartState();
}

class _TimeSeriesChartState extends State<Timeserieschart> {
  int? _touchedIndex;
  late List<double> _processedScores;
  late int _highestScoreIndex;
  late double _maxValue;
  late double _optimalMaxY;

  @override
  void initState() {
    super.initState();
    _processData();
  }

  @override
  void didUpdateWidget(Timeserieschart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.healthScores != widget.healthScores ||
        oldWidget.config.period != widget.config.period) {
      _processData();
    }
  }

  /// Memproses data untuk memastikan sesuai dengan periode yang dipilih
  void _processData() {
    _processedScores = _padScoresToPeriod(
      widget.healthScores,
      widget.config.period,
    );
    _highestScoreIndex = _findHighestScoreIndex(_processedScores);
    _maxValue = _processedScores.isEmpty
        ? 0
        : _processedScores.reduce((a, b) => a > b ? a : b);
    _optimalMaxY = _calculateOptimalMaxY(_maxValue);
  }

  /// Menghitung nilai maksimal Y yang optimal untuk interval 10
  double _calculateOptimalMaxY(double maxValue) {
    if (maxValue <= 0) return 10;

    // Tambahkan buffer 20% dan bulatkan ke kelipatan 10 terdekat
    final bufferedMax = maxValue * 1.2;
    final roundedMax = (bufferedMax / 10).ceil() * 10;

    // Pastikan minimal ada 2 interval (minimal maxY = 20)
    return roundedMax < 20 ? 20 : roundedMax.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 0.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.title!,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
          AspectRatio(
            aspectRatio: widget.config.aspectRatio,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: LineChart(
                _buildLineChartData(),
                duration: widget.config.animationDuration,
                curve: widget.config.animationCurve,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Menambahkan padding ke data jika kurang dari periode yang ditentukan
  List<double> _padScoresToPeriod(List<double> scores, ChartPeriod period) {
    final paddedScores = List<double>.from(scores);

    while (paddedScores.length < period.days) {
      paddedScores.add(0.0);
    }

    // Potong jika melebihi periode
    if (paddedScores.length > period.days) {
      return paddedScores.take(period.days).toList();
    }

    return paddedScores;
  }

  /// Mencari index dengan skor tertinggi
  int _findHighestScoreIndex(List<double> scores) {
    if (scores.isEmpty) return 0;

    double maxValue = scores.first;
    int maxIndex = 0;

    for (int i = 1; i < scores.length; i++) {
      if (scores[i] > maxValue) {
        maxValue = scores[i];
        maxIndex = i;
      }
    }

    return maxIndex;
  }

  /// Mendapatkan label untuk sumbu X berdasarkan periode
  String _getXAxisLabel(int index, ChartPeriod period) {
    switch (period) {
      case ChartPeriod.weekly:
        const weekDays = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
        return weekDays[index % weekDays.length];
      case ChartPeriod.monthly:
        return '${index + 1}';
    }
  }

  /// Membuat konfigurasi tooltip
  LineTouchTooltipData _buildTooltipConfig() {
    return LineTouchTooltipData(
      getTooltipColor: (color) => widget.config.primaryColor,
      tooltipPadding: const EdgeInsets.all(8),
      getTooltipItems: (touchedSpots) {
        return touchedSpots.map((spot) {
          final period = widget.config.period == ChartPeriod.weekly
              ? 'Hari'
              : 'Tanggal';
          final label = _getXAxisLabel(spot.x.toInt(), widget.config.period);

          return LineTooltipItem(
            '$period $label\n${spot.y.toStringAsFixed(0)} santri',
            const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          );
        }).toList();
      },
    );
  }

  /// Membuat konfigurasi garis vertikal untuk indikator tertinggi
  List<VerticalLine> _buildHighestPointIndicator() {
    if (!widget.config.showHighestPointIndicator) return [];

    return [
      VerticalLine(
        x: _highestScoreIndex.toDouble(),
        color: widget.config.primaryColor.withOpacity(0.7),
        strokeWidth: 1.5,
        dashArray: [4, 2],
        label: VerticalLineLabel(
          show: true,
          alignment: Alignment.topCenter,
          style: TextStyle(
            color: widget.config.primaryColor,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
          labelResolver: (line) => 'Tertinggi',
        ),
      ),
    ];
  }

  LineChartData _buildLineChartData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
        horizontalInterval: 10, // Interval horizontal setiap 10 unit
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.3),
            strokeWidth: 0.8,
            // dashArray: [5, 5], // Garis putus-putus untuk estetika
          );
        },
      ),
      titlesData: _buildTitlesData(),
      borderData: FlBorderData(show: false),
      lineTouchData: _buildLineTouchData(),
      lineBarsData: [_buildLineChartBarData()],
      extraLinesData: ExtraLinesData(
        extraLinesOnTop: true,
        verticalLines: _buildHighestPointIndicator(),
      ),
      minX: 0,
      maxX: (_processedScores.length - 1).toDouble(),
      minY: 0,
      maxY: _optimalMaxY, // Menggunakan maxY yang sudah dioptimalkan
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        axisNameWidget: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Text(
            widget.config.period.label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: (value, meta) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _getXAxisLabel(value.toInt(), widget.config.period),
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 10, // Interval label Y setiap 10 unit
          reservedSize: 40, // Ruang yang cukup untuk angka 2-3 digit
          getTitlesWidget: (value, meta) {
            // Hanya tampilkan label untuk nilai yang merupakan kelipatan 10
            if (value % 10 != 0) return const SizedBox.shrink();

            return Text(
              value.toInt().toString(),
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            );
          },
        ),
      ),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  LineTouchData _buildLineTouchData() {
    return LineTouchData(
      touchTooltipData: _buildTooltipConfig(),
      touchCallback: (event, response) {
        setState(() {
          if (!event.isInterestedForInteractions ||
              response == null ||
              response.lineBarSpots == null) {
            _touchedIndex = null;
            return;
          }

          final spotIndex = response.lineBarSpots!.first.spotIndex;
          _touchedIndex = spotIndex;

          /// Callback untuk parent widget
          widget.onPointTapped?.call(spotIndex);
        });
      },
      handleBuiltInTouches: true,
    );
  }

  LineChartBarData _buildLineChartBarData() {
    return LineChartBarData(
      spots: List.generate(
        _processedScores.length,
        (index) => FlSpot(index.toDouble(), _processedScores[index]),
      ),
      isCurved: true,
      color: widget.config.primaryColor,
      barWidth: widget.config.lineWidth,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          final isHighest = index == _highestScoreIndex;
          final isTouched = index == _touchedIndex;

          return FlDotCirclePainter(
            radius: isHighest || isTouched
                ? widget.config.dotRadius + 2
                : widget.config.dotRadius,
            color: isHighest
                ? widget.config.primaryColor.withOpacity(0.8)
                : widget.config.primaryColor,
            strokeWidth: 2,
            strokeColor: Colors.white,
          );
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [
            widget.config.primaryColor.withOpacity(0.3),
            widget.config.backgroundColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      isStrokeCapRound: true,
      curveSmoothness: 0.2,
    );
  }
}
