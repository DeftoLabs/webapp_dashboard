import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/providers.dart'; 

class OrderStatusDonutChart extends StatelessWidget {
  const OrderStatusDonutChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener los datos del estado de las órdenes del día
    final orderStatusCount = Provider.of<OrdenesProvider>(context).getOrderStatusCountForToday();

    // Calcular el total de las órdenes del día
    final totalOrders = orderStatusCount.values.fold(0, (sum, value) => sum + value);
     String todayDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

    // Convertir los datos en una lista de puntos para el gráfico de donuts
    final donutData = orderStatusCount.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value.toDouble(),
        title: '${entry.key}\n${entry.value}', // Mostrar nombre y cantidad
        color: _getColorForStatus(entry.key),
        radius: 80,
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
      );
    }).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: PieChart(
            PieChartData(
              sections: donutData,
              borderData: FlBorderData(show: false),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Mostrar total de órdenes del día
        Text(
          '$todayDate & ORDERS - $totalOrders', // Mostrar total de las órdenes del día
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 20),
        // Leyenda fuera del gráfico
      ],
    );
  }

  // Función para asignar colores según el estado de la orden
  Color _getColorForStatus(String status) {
    switch (status) {
      case 'ORDER':
        return const Color.fromARGB(255, 121, 195, 255);
      case 'APPROVED':
        return const Color.fromARGB(255, 162, 255, 166);
      case 'CANCEL':
        return Colors.red;
      case 'INVOICE':
        return const Color.fromARGB(255, 255, 204, 127);
      case 'NOTE':
        return const Color.fromARGB(255, 235, 122, 255);
      default:
        return const Color.fromARGB(255, 203, 199, 199);
    }
  }

}
