import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../providers/providers.dart';

class WeeklyOrdersBarChart extends StatelessWidget {
  const WeeklyOrdersBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final weeklyOrderCount = Provider.of<OrdenesProvider>(context).getWeeklyOrderCount();

    // Crear grupos de barras
    final barGroups = weeklyOrderCount.entries.map((entry) {
      return BarChartGroupData(
        x: entry.key, // Índice del día (0: hace 6 días, 6: hoy)
        barRods: [
          BarChartRodData(
            toY: entry.value.toDouble(), // Cantidad de órdenes
            color: const Color.fromRGBO(177, 255, 46, 1),
            width: 20, // Ancho de la barra
            borderRadius: BorderRadius.circular(4), // Bordes redondeados
          ),
        ],
      );
    }).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ORDER FROM THE LAST 7 DAYS',
          style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Flexible(
          child: BarChart(
            BarChartData(
              barGroups: barGroups,
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: true),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) => Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final today = DateTime.now();
                      final dayIndex = value.toInt();
                      if (dayIndex < 0 || dayIndex > 6) return const SizedBox.shrink();

                      final targetDate = today.subtract(Duration(days: 6 - dayIndex));
                      final formattedDate =
                          "${targetDate.day.toString().padLeft(2, '0')}/${targetDate.month.toString().padLeft(2, '0')}";

                      return Text(
                        formattedDate,
                        style: const TextStyle(fontSize: 12),
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false), // Deshabilita los títulos en la parte superior
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
