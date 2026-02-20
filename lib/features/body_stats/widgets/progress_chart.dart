
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../core/constants/app_colors.dart';

class ProgressChart extends StatefulWidget {
  const ProgressChart({super.key});

  @override
  State<ProgressChart> createState() => _ProgressChartState();
}

class _ProgressChartState extends State<ProgressChart> {
  int selectedIndex = 0; // 0: Kilo, 1: Yağ %

  @override
  Widget build(BuildContext context) {

    final List<Color> gradientColors = [
      AppColors.primary,
      AppColors.primary.withAlpha(77), // 0.3
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Gelişim Analizi",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(13), // 0.05
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _toggleButton("Kilo", 0),
                  _toggleButton("Yağ %", 1),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 240,
              padding: const EdgeInsets.only(
                right: 18,
                left: 12,
                top: 24,
                bottom: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(13), // 0.05
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withAlpha(26)), // 0.1
              ),
              child: LineChart(
                mainData(gradientColors),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _toggleButton(String text, int index) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha(77), // 0.3
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white.withAlpha(128), // 0.5
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white54,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Oca', style: style);
        break;
      case 1:
        text = const Text('Şub', style: style);
        break;
      case 2:
        text = const Text('Mar', style: style);
        break;
      case 3:
        text = const Text('Nis', style: style);
        break;
      case 4:
        text = const Text('May', style: style);
        break;
      case 5:
        text = const Text('Haz', style: style);
        break;
      case 6:
        text = const Text('Tem', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      meta: meta,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white54,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    
    String label = '';
    if (selectedIndex == 0) { // Weight
       if (value % 5 != 0) return Container();
       label = '${value.toInt()}kg';
    } else { // Body Fat
       if (value % 2 != 0) return Container();
       label = '%${value.toInt()}';
    }

    return SideTitleWidget(
      meta: meta,
      child: Text(label, style: style, textAlign: TextAlign.left),
    );
  }

  LineChartData mainData(List<Color> gradientColors) {
    bool isWeight = selectedIndex == 0;
    
    List<FlSpot> spots = isWeight 
      ? const [
          FlSpot(0, 74.5),
          FlSpot(1, 73.8),
          FlSpot(2, 73.0),
          FlSpot(3, 72.2),
          FlSpot(4, 71.5),
          FlSpot(5, 71.0),
          FlSpot(6, 70.5),
        ]
      : const [
          FlSpot(0, 20.5),
          FlSpot(1, 20.0),
          FlSpot(2, 19.5),
          FlSpot(3, 19.0),
          FlSpot(4, 18.8),
          FlSpot(5, 18.5),
          FlSpot(6, 18.2),
        ];

    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (spot) => Colors.blueGrey.withAlpha(204), // 0.8
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                isWeight ? "${spot.y} kg" : "%${spot.y}",
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: isWeight ? 5 : 2,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white.withAlpha(13), // 0.05
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: isWeight ? 5 : 2,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 6,
      minY: isWeight ? 65 : 15,
      maxY: isWeight ? 85 : 25,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              radius: 4,
              color: AppColors.primary,
              strokeWidth: 2,
              strokeColor: Colors.black,
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color.withAlpha(51)).toList(), // 0.2
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}
