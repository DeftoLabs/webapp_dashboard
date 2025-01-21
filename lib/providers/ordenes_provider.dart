

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
  final startOfWeek = today.subtract(const Duration(days: 6)); // Hace 7 días
  final ordersInLast7Days = ordenes.where((orden) {
    // Ajustamos la comparación para asegurarnos de que la fecha del 15/01 se incluya correctamente
    return orden.fechacreado.isAfter(startOfWeek.subtract(const Duration(hours: 24))) && 
           orden.fechacreado.isBefore(today.add(const Duration(days: 1)));
  }).toList();

  // Inicializar el mapa con 0 órdenes para cada día de la semana
  Map<int, int> weeklyOrders = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0};

  for (var orden in ordersInLast7Days) {
    // Calcular la diferencia en días desde el inicio de la semana
    final daysAgo = today.difference(orden.fechacreado).inDays;
    final dayIndex = 6 - daysAgo; // Ajustar índice (0 para hace 6 días, 6 para hoy)
    if (weeklyOrders.containsKey(dayIndex)) {
      weeklyOrders[dayIndex] = (weeklyOrders[dayIndex] ?? 0) + 1;
    }
  }

  return weeklyOrders;
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