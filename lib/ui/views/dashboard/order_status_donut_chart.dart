import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import '../../../providers/providers.dart';

class OrderStatusDonutChart extends StatelessWidget {
  const OrderStatusDonutChart({super.key});

  @override
  Widget build(BuildContext context) {
    final orderStatusCount = Provider.of<OrdenesProvider>(context).getOrderStatusCountForToday();


    final donutData = orderStatusCount.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value.toDouble(),
        title: '${entry.key}\n${entry.value}',
        color: _getColorForStatus(entry.key),
        radius: 70, // Radio interior
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
        borderSide: BorderSide(
          color: _getBorderColorForStatus(entry.key), // Borde externo
          width: 4, // Ancho del borde
        ),
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
              sectionsSpace: 2, // Espacio entre secciones
              centerSpaceRadius: 40, // Radio del espacio central
            ),
          ),
        ),
      ],
    );
  }

  Color _getColorForStatus(String status) {
    switch (status) {
      case 'ORDER':
        return const Color.fromRGBO(0, 200, 83, 1); // Verde
      case 'APPROVED':
        return const Color.fromARGB(255, 52, 149, 251); 
      case 'CANCEL':
        return const Color.fromRGBO(255, 152, 0, 1);
      case 'INVOICE':
        return Colors.grey[400]!; 
      case 'NOTE':
        return Colors.grey[600]!; 
      default:
        return Colors.grey;
    }
  }

  Color _getBorderColorForStatus(String status) {
    switch (status) {
      case 'ORDER':
        return const Color.fromRGBO(177, 255, 46, 1);
      case 'APPROVED':
        return const Color.fromARGB(255, 88, 164, 246); 
      case 'CANCEL':
        return const Color.fromARGB(255, 255, 194, 102); 
      case 'INVOICE':
        return Colors.grey[500]!;
      case 'NOTE':
        return Colors.grey[700]!; 
      default:
        return Colors.black;
    }
  }
}
