

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/http/ordenes_response.dart';
import 'package:web_dashboard/models/ordenes.dart';

class OrdenesProvider extends ChangeNotifier {

  List <Ordenes>ordenes = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  OrdenesProvider() {
    getPaginatedOrdenes();
  //  Timer.periodic(const Duration(seconds: 30), (timer) {
  //  getPaginatedOrdenes();
  //});
  }

  getPaginatedOrdenes () async {
    final resp = await CafeApi.httpGet('/ordens');
    final ordenesResp = OrdenesResponse.fromMap(resp);
    ordenes = [ ... ordenesResp.ordenes];
    isLoading = false;
    notifyListeners();
  }

    // Método para obtener las órdenes del día y contar los estados
  Map<String, int> getOrderStatusCountForToday() {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    // Filtrar las órdenes del día
    final todaysOrders = ordenes.where((orden) {
      return orden.fechacreado.isAfter(todayStart) && orden.fechacreado.isBefore(todayEnd);
    }).toList();

    // Contar los diferentes estados de las órdenes
    Map<String, int> statusCount = {
      'ORDER': 0,
      'APPROVED': 0,
      'CANCEL': 0,
      'INVOICE': 0,
      'NOTE': 0,
      'OTHER': 0,
    };

    for (var orden in todaysOrders) {
      statusCount[orden.status] = (statusCount[orden.status] ?? 0) + 1;
    }
    return statusCount;
  }

  // Método para obtener las órdenes agrupadas por los últimos 7 días
Map<int, int> getWeeklyOrderCount() {
  final today = DateTime.now();
  final startOfWeek = DateTime(today.year, today.month, today.day).subtract(const Duration(days: 6)); // Inicio del día hace 6 días
  final endOfDayToday = DateTime(today.year, today.month, today.day).add(const Duration(days: 1)); // Fin del día de hoy

  // Filtrar órdenes de los últimos 7 días
  final ordersInLast7Days = ordenes.where((orden) {
    return orden.fechacreado.isAfter(startOfWeek) && orden.fechacreado.isBefore(endOfDayToday);
  }).toList();

  // Inicializar el mapa con días de la semana y valores en 0
  Map<int, int> weeklyOrders = {for (int i = 0; i < 7; i++) i: 0};

  for (var orden in ordersInLast7Days) {
    // Redondear la fecha de creación al inicio del día
    final ordenDate = DateTime(orden.fechacreado.year, orden.fechacreado.month, orden.fechacreado.day);
    final daysAgo = today.difference(ordenDate).inDays;
    final dayIndex = 6 - daysAgo; // Ajustar el índice (0 para hace 6 días, 6 para hoy)

    if (dayIndex >= 0 && dayIndex <= 6) {
      weeklyOrders[dayIndex] = (weeklyOrders[dayIndex] ?? 0) + 1;
    }
  }
  return weeklyOrders;
}

Map<int, double> getWeeklySales() {
  final today = DateTime.now();
  final startOfWeek = DateTime(today.year, today.month, today.day).subtract(const Duration(days: 6));
  final endOfDayToday = DateTime(today.year, today.month, today.day).add(const Duration(days: 1));

  // Filtrar órdenes de los últimos 7 días
  final ordersInLast7Days = ordenes.where((orden) {
    return orden.fechacreado.isAfter(startOfWeek) && orden.fechacreado.isBefore(endOfDayToday);
  }).toList();

  Map<int, double> dailySales = {for (int i = 0; i < 7; i++) i: 0.0};

  for (var orden in ordersInLast7Days) {
    // Asegurarse de comparar las fechas sin la parte de la hora
    final normalizedOrderDate = DateTime(orden.fechacreado.year, orden.fechacreado.month, orden.fechacreado.day);
    final normalizedToday = DateTime(today.year, today.month, today.day);

    // Calculamos la diferencia en días entre las fechas normalizadas
    final dayDifference = normalizedToday.difference(normalizedOrderDate).inDays;

    if (dayDifference >= 0 && dayDifference <= 6) {
      final dayIndex = 6 - dayDifference;
      final subtotal = orden.subtotal;

      // Acumulamos las ventas por día
      dailySales[dayIndex] = (dailySales[dayIndex] ?? 0.0) + subtotal;
    }
  }

  return dailySales;
}


/// Método para agrupar las órdenes por día y usuarioZona
Map<String, Map<String, int>> getOrdersGroupedByDayAndUserName() {
  // Mapa para almacenar los resultados: { "yyyy-MM-dd": { "usuarioZona": cantidad } }
  Map<String, Map<String, int>> groupedOrders = {};

  // Obtener la fecha de hace 7 días
  final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));

  for (var orden in ordenes) {
    // Obtener la fecha en formato yyyy-MM-dd
    final orderDate = "${orden.fechacreado.year}-${orden.fechacreado.month.toString().padLeft(2, '0')}-${orden.fechacreado.day.toString().padLeft(2, '0')}";
    final orderDateTime = DateTime.parse(orderDate); // Convierte la fecha a DateTime

    // Solo incluir órdenes de los últimos 7 días
    if (orderDateTime.isAfter(sevenDaysAgo)) {
      // Verificar si la orden tiene una ruta asociada y un usuarioZona
      if (orden.ruta.isNotEmpty && orden.ruta.first.usuarioZona.nombre.isNotEmpty) {
        final userName = orden.ruta.first.usuarioZona.nombre;

        // Inicializar la estructura para el día si no existe
        if (!groupedOrders.containsKey(orderDate)) {
          groupedOrders[orderDate] = {};
        }

        // Inicializar el contador para la zona de usuario si no existe
        groupedOrders[orderDate]![userName] = (groupedOrders[orderDate]![userName] ?? 0) + 1;
      }
    }
  }

  return groupedOrders;
}


   Future<Ordenes?> getOrdenById (String id) async {

      try {
        final resp = await CafeApi.httpGet('/ordens/$id');
        final orden = Ordenes.fromMap(resp);
        return orden;
      } catch (e) {
        return null;
      }
  }

void sort<T>(Comparable<T> Function(Ordenes ordenes) getField) {
  ordenes.sort((a, b) {
    final aValue = getField(a);
    final bValue = getField(b);

    return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue) ;
  });
  notifyListeners();
}
void refreshOrden(Ordenes newOrden) {

  ordenes = ordenes.map(
    (orden) {
      if( orden.id == newOrden.id) {
        orden = newOrden;
      }
      return orden;
    }
  ).toList();
  notifyListeners();
}

    Future deleteOrden (String id) async {
   try{
     await CafeApi.delete('/ordens/$id',{});
     ordenes.removeWhere((ordenes) => ordenes.id == id);
     notifyListeners();
   } catch (e){
     throw ' Error to Delete the Order ';
   }
 }
 
}