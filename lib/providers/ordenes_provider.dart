

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