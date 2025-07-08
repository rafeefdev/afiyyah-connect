import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

enum ChartPeriod {
  weekly(days: 7, label: 'Mingguan'),
  monthly(days: 30, label: 'Bulanan');

  const ChartPeriod({required this.days, required this.label});
  final int days;
  final String label;
}

/// Widget untuk menampilkan chart kesehatan dengan periode weekly/monthly
class Timeserieschart extends StatefulWidget {
  final List<double> healthScores;
  final String? title;
  final ValueChanged<int>? onPointTapped;
  final ChartPeriod period;
  final Color? primaryColor;
  final Color? backgroundColor;
  final double lineWidth;
  final double dotRadius;
  final bool showHighestPointIndicator;
  final Duration animationDuration;
  final Curve animationCurve;

  const Timeserieschart({
    super.key,
    required this.healthScores,
    this.title,
    this.onPointTapped,
    this.period = ChartPeriod.weekly,
    this.primaryColor,
    this.backgroundColor,
    this.lineWidth = 2,
    this.dotRadius = 4,
    this.showHighestPointIndicator = true,
    this.animationDuration = const Duration(milliseconds: 350),
    this.animationCurve = Curves.easeInOut,
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
        oldWidget.period != widget.period) {
      _processData();
    }
  }

  /// Memproses data untuk memastikan sesuai dengan periode yang dipilih
  void _processData() {
    _processedScores = _padScoresToPeriod(
      widget.healthScores,
      widget.period,
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
    return Column(
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: LineChart(
              _buildLineChartData(),
              duration: widget.animationDuration,
              curve: widget.animationCurve,
            ),
          ),
        ),
      ],
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
    final primaryColor = widget.primaryColor ?? Theme.of(context).colorScheme.primary;
    return LineTouchTooltipData(
      getTooltipColor: (color) => primaryColor,
      tooltipPadding: const EdgeInsets.all(8),
      getTooltipItems: (touchedSpots) {
        return touchedSpots.map((spot) {
          final period = widget.period == ChartPeriod.weekly
              ? 'Hari'
              : 'Tanggal';
          final label = _getXAxisLabel(spot.x.toInt(), widget.period);

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
    if (!widget.showHighestPointIndicator) return [];
    final primaryColor = widget.primaryColor ?? Theme.of(context).colorScheme.primary;

    return [
      VerticalLine(
        x: _highestScoreIndex.toDouble(),
        color: Theme.of(context).colorScheme.secondary,
        strokeWidth: 1.5,
        dashArray: [4, 2],
        label: VerticalLineLabel(
          show: true,
          alignment: Alignment.topCenter,
          style: TextStyle(
            color: primaryColor,
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
            widget.period.label,
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
                _getXAxisLabel(value.toInt(), widget.period),
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
    final backgroundColor = widget.backgroundColor ?? Theme.of(context).colorScheme.surface;
    return LineChartBarData(
      spots: List.generate(
        _processedScores.length,
        (index) => FlSpot(index.toDouble(), _processedScores[index]),
      ),
      isCurved: true,
      color: Colors.grey,
      barWidth: widget.lineWidth,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          final isHighest = index == _highestScoreIndex;
          final isTouched = index == _touchedIndex;

          return FlDotCirclePainter(
            radius: isHighest || isTouched
                ? widget.dotRadius + 2
                : widget.dotRadius,
            color:Colors.black87,
            strokeWidth: 2,
            strokeColor: Colors.white,
          );
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [
            Colors.blue,
            // primaryColor.withOpacity(0.3),
            backgroundColor,
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
