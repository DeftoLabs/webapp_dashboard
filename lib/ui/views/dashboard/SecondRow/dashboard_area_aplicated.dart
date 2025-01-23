import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:web_dashboard/providers/ordenes_provider.dart';

class StackedAreaChartWidget extends StatelessWidget {
  const StackedAreaChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final groupedOrdersByUser = Provider.of<OrdenesProvider>(context).getOrdersGroupedByDayAndUserName();
    final chartData = _processChartData(groupedOrdersByUser);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Text(
              'ORDERS BY SALES REPRESENTATIVE LAST 7 DAYS',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: LineChart(
                  _buildLineChartData(chartData),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Procesa los datos del gráfico y evita duplicados
  List<_ChartData> _processChartData(Map<String, Map<String, int>> groupedOrdersByUser) {
    List<_ChartData> chartData = [];
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));

    groupedOrdersByUser.forEach((date, userData) {
      final orderDateTime = DateTime.parse(date);
      if (orderDateTime.isAfter(sevenDaysAgo)) {
        userData.forEach((userName, count) {
          chartData.add(_ChartData(date, userName, count)); // userName en vez de zone
        });
      }
    });

    return chartData;
  }

  /// Configura los datos y la apariencia del gráfico
  LineChartData _buildLineChartData(List<_ChartData> data) {

      if (data.isEmpty) {
    return LineChartData(
      lineBarsData: [],
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
    );
  }

    final userNames = data.map((e) => e.userName).toSet(); // Cambiado de zones a userNames
    final dates = data.map((e) => e.date).toSet().toList()..sort();

    // Mapa de colores aleatorios por usuario
    final userColors = _generateRandomColors(userNames);

    List<LineChartBarData> areaSeries = userNames.map((userName) {
      List<FlSpot> spots = dates.map((date) {
        final entry = data.firstWhere(
          (d) => d.userName == userName && d.date == date,
          orElse: () => _ChartData(date, userName, 0),
        );
        return FlSpot(dates.indexOf(date).toDouble(), entry.count.toDouble());
      }).toList();

      return LineChartBarData(
        spots: spots,
        isCurved: true,
        color: userColors[userName], // Asigna un color único
        belowBarData: BarAreaData(
          show: true,
          color: userColors[userName]!.withOpacity(0.3),
        ),
        dotData: const FlDotData(show: false),
      );
    }).toList();

    return LineChartData(
      lineBarsData: areaSeries,
      titlesData: FlTitlesData(
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 35,
            interval: 1,
            getTitlesWidget: (value, _) {
              final index = value.toInt();
              if (index >= 0 && index < dates.length) {
                final rawDate = dates[index];
                final parts = rawDate.split('-');
                final formattedDate = '${parts[2]}/${parts[1]}';
                return Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 10),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipRoundedRadius: 8,
          tooltipMargin: 10,
          tooltipPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          maxContentWidth: 150,
          getTooltipItems: (spots) {
            return spots.map((spot) {
              final userName = userNames.elementAt(spots.indexOf(spot)).length > 16
                  ? '${userNames.elementAt(spots.indexOf(spot)).substring(0, 16)}...'
                  : userNames.elementAt(spots.indexOf(spot));
              final count = spot.y.toInt();

              return LineTooltipItem(
                '$userName - $count',
                GoogleFonts.plusJakartaSans(fontSize: 10, color: Colors.white),
              );
            }).toList();
          },
        ),
        touchSpotThreshold: 10,
        handleBuiltInTouches: true,
      ),
    );
  }

  /// Genera un mapa de colores aleatorios para cada usuario
Map<String, Color> _generateRandomColors(Set<String> userNames) {
  final palette = [
    const Color(0xFF6AC259), // Verde
    const Color(0xFF4A90E2), // Azul
    const Color(0xFFFFA726), // Naranja
    const Color(0xFFFF5252), // Rojo suave
    const Color(0xFFAB47BC), // Púrpura
    const Color(0xFF29B6F6), // Cian
    const Color(0xFF66BB6A), // Verde más oscuro
  ];
  final random = Random();
  final userColors = <String, Color>{};

  for (var userName in userNames) {
    userColors[userName] = palette[userColors.length % palette.length]
        .withOpacity(0.8 + (random.nextDouble() * 0.2)); // Variaciones leves
  }
  return userColors;
}

}

/// Clase para estructurar los datos del gráfico
class _ChartData {
  final String date;
  final String userName;
  final int count;

  _ChartData(this.date, this.userName, this.count);
}
