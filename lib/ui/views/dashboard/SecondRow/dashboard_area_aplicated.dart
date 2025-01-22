import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:web_dashboard/providers/ordenes_provider.dart';

class StackedAreaChartWidget extends StatelessWidget {
  const StackedAreaChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final groupedOrders = Provider.of<OrdenesProvider>(context).getOrdersGroupedByDayAndUserZone();
    final chartData = _processChartData(groupedOrders); // Se pasa el Map<String, Map<String, int>>

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'TOTAL SOLD LAST 7 DAYS',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: LineChart(
                _buildLineChartData(chartData),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Convierte el mapa de datos en una lista adecuada para el gráfico
  List<_ChartData> _processChartData(Map<String, Map<String, int>> groupedOrders) {
    List<_ChartData> chartData = [];

    // Filtrar solo las fechas de los últimos 7 días
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    groupedOrders.forEach((date, zonesData) {
      final orderDateTime = DateTime.parse(date); // Convertir la fecha en String a DateTime

      // Incluir solo las fechas dentro de los últimos 7 días
      if (orderDateTime.isAfter(sevenDaysAgo)) {
        zonesData.forEach((zone, count) {
          chartData.add(_ChartData(date, zone, count));
        });
      }
    });

    return chartData;
  }

  /// Configura los datos y la apariencia del gráfico
  LineChartData _buildLineChartData(List<_ChartData> data) {
    final zones = data.map((e) => e.zone).toSet();
    final dates = data.map((e) => e.date).toSet().toList()..sort();

    List<LineChartBarData> areaSeries = zones.map((zone) {
      List<FlSpot> spots = dates.map((date) {
        final entry = data.firstWhere(
          (d) => d.zone == zone && d.date == date,
          orElse: () => _ChartData(date, zone, 0),
        );
        return FlSpot(dates.indexOf(date).toDouble(), entry.count.toDouble());
      }).toList();

      return LineChartBarData(
        spots: spots,
        isCurved: true,
        color:const Color.fromRGBO(177, 255, 46, 1),
        belowBarData: BarAreaData(
          show: true,
          color: const Color.fromRGBO(177, 255, 46, 1).withOpacity(0.3),
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
          sideTitles: SideTitles(showTitles: false), // Sin títulos a la derecha
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
                final parts = rawDate.split('-'); // Formato yyyy-MM-dd
                final formattedDate = '${parts[2]}/${parts[1]}'; // Formato dd/MM
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
          sideTitles: SideTitles(showTitles: false), // Sin títulos en la parte superior
        ),
      ),
      gridData: const FlGridData(show: true),
      borderData: FlBorderData(show: false),
    );
  }
}

/// Clase para estructurar los datos del gráfico
class _ChartData {
  final String date; // Fecha en formato yyyy-MM-dd
  final String zone; // Zona de usuario
  final int count; // Cantidad de órdenes

  _ChartData(this.date, this.zone, this.count);
}
