import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Importa intl
import 'package:provider/provider.dart';

import '../../../../providers/providers.dart';

class SalesLineChartUserRole extends StatelessWidget {
  const SalesLineChartUserRole({super.key});

  @override
  Widget build(BuildContext context) {
    final salesData = context.watch<OrdenesProvider>().getWeeklySalesByUser(context);

    // Formateador de números para valores monetarios en formato de EE.UU.
    final currencyFormatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$', // Símbolo de dólar
      decimalDigits: 2, // 2 decimales
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Center(
                child: Text(
                  'TOTAL SOLD LAST 7 DAYS',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            ),
            // Gráfico ajustado dinámicamente
            Flexible(
              child: SizedBox(
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false, 
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            // Formatea los valores del eje Y
                            final formattedValue = currencyFormatter.format(value);
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                formattedValue,
                                style: const TextStyle(fontSize: 12, color: Colors.white),
                              ),
                            );
                          },
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false, // Oculta los títulos del eje Y a la derecha
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          interval: 1, // Asegura que las etiquetas solo se muestren para valores enteros
                          getTitlesWidget: (value, meta) {
                            if (value % 1 != 0 || value < 0 || value > 6) {
                              return const SizedBox.shrink();
                            }

                            final dayIndex = value.toInt();
                            final daysAgo = 6 - dayIndex;
                            final date =
                                DateTime.now().subtract(Duration(days: daysAgo));

                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                '${date.day}/${date.month}',
                                style: const TextStyle(fontSize: 12, color: Colors.white),
                              ),
                            );
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false, // Oculta los títulos de la parte superior
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false, // Elimina el borde del cuadro
                    ),
                    minX: 0,
                    maxX: 6,
                    minY: 0,
                    maxY: salesData.values.reduce((a, b) => a > b ? a : b) + 50,
                    lineBarsData: [
                      LineChartBarData(
                        spots: salesData.entries.map((entry) {
                          return FlSpot(entry.key.toDouble(), entry.value);
                        }).toList(),
                        isCurved: true,
                         color: const Color.fromRGBO(177, 255, 46, 1),
                        barWidth: 3,
                        belowBarData: BarAreaData(
                          show: true,
                           color: const Color.fromRGBO(177, 255, 46, 1).withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
