

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/models/http/ordenes_response.dart';
import 'package:web_dashboard/models/ordenes.dart';
import 'package:web_dashboard/models/products.dart';
import 'package:web_dashboard/providers/auth_provider.dart';

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

  Map<String, int> getOrderStatusByUserCountForToday(BuildContext context) {
  // Obtener el usuario activo
  final activeUser = Provider.of<AuthProvider>(context, listen: false).user!;
  final userUid = activeUser.uid;

  final today = DateTime.now();
  final todayStart = DateTime(today.year, today.month, today.day);
  final todayEnd = todayStart.add(const Duration(days: 1));

  // Filtrar las órdenes del día y del usuario activo
  final todaysOrders = ordenes.where((orden) {
    final isToday = orden.fechacreado.isAfter(todayStart) && orden.fechacreado.isBefore(todayEnd);
    final isUserOrder = orden.ruta.any((ruta) => ruta.usuarioZona.uid == userUid);
    return isToday && isUserOrder;
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

// Método para obtener las órdenes agrupadas por los últimos 7 días, solo del usuario en sesión
Map<int, int> getWeeklyOrderCountByUser(BuildContext context) {
  final today = DateTime.now();
  final startOfWeek = DateTime(today.year, today.month, today.day).subtract(const Duration(days: 6)); // Inicio de hace 6 días
  final endOfDayToday = DateTime(today.year, today.month, today.day).add(const Duration(days: 1)); // Fin del día de hoy

  // Obtener el usuario activo
  final activeUser = Provider.of<AuthProvider>(context, listen: false).user!;
  final activeUserId = activeUser.uid;

  // Filtrar órdenes de los últimos 7 días y que pertenezcan al usuario activo
  final ordersInLast7Days = ordenes.where((orden) {
    final isWithinDateRange = orden.fechacreado.isAfter(startOfWeek) && orden.fechacreado.isBefore(endOfDayToday);
    final belongsToActiveUser = orden.ruta.any((ruta) => ruta.usuarioZona.uid == activeUserId);
    return isWithinDateRange && belongsToActiveUser;
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
Map<int, double> getWeeklySalesByUser(BuildContext context) {
  final activeUser = Provider.of<AuthProvider>(context).user!;  // Usuario activo de la sesión
  final today = DateTime.now();
  final startOfWeek = DateTime(today.year, today.month, today.day).subtract(const Duration(days: 6));
  final endOfDayToday = DateTime(today.year, today.month, today.day).add(const Duration(days: 1));

  // Filtrar órdenes de los últimos 7 días y que pertenezcan al usuario activo
  final ordersInLast7Days = ordenes.where((orden) {
    // Verificar si el uid del usuario en la orden coincide con el del usuario activo
    return orden.fechacreado.isAfter(startOfWeek) &&
           orden.fechacreado.isBefore(endOfDayToday) &&
           orden.ruta.any((ruta) => ruta.usuarioZona.uid == activeUser.uid);
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
  // Mapa para almacenar los resultados
  Map<String, Map<String, int>> groupedOrders = {};

  // Obtener la fecha límite (hace 7 días)
  final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));

  for (var orden in ordenes) {
    // Obtener la fecha de la orden como DateTime
    final orderDate = DateTime(
      orden.fechacreado.year,
      orden.fechacreado.month,
      orden.fechacreado.day,
    );

    // Solo incluir órdenes de los últimos 7 días
    if (orderDate.isAfter(sevenDaysAgo)) {
      // Verificar si la orden tiene un usuarioZona válido
      if (orden.ruta.isNotEmpty && orden.ruta.first.usuarioZona.nombre.isNotEmpty) {
        final userName = orden.ruta.first.usuarioZona.nombre.trim();

        // Formatear la fecha como cadena para agrupar
        final formattedDate = "${orderDate.year}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}";

        // Inicializar la estructura para el día si no existe
        if (!groupedOrders.containsKey(formattedDate)) {
          groupedOrders[formattedDate] = {};
        }

        // Incrementar el contador para el usuarioZona
        groupedOrders[formattedDate]![userName] =
            (groupedOrders[formattedDate]![userName] ?? 0) + 1;
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

  /// Método para obtener los 5 productos más vendidos del día
List<Producto> getTop5ProductsOfToday() {
  final today = DateTime.now();
  final todayStart = DateTime(today.year, today.month, today.day);
  final todayEnd = todayStart.add(const Duration(days: 1));

  // Filtrar las órdenes del día
  final todaysOrders = ordenes.where((orden) {
    return orden.fechacreado.isAfter(todayStart) && orden.fechacreado.isBefore(todayEnd);
  }).toList();

  // Crear un mapa para acumular la cantidad vendida por producto
  final productSales = <String, Producto>{};

  for (var orden in todaysOrders) {
    for (var producto in orden.productos) {
      if (productSales.containsKey(producto.id)) {
        productSales[producto.id]!.cantidad = (productSales[producto.id]!.cantidad ?? 0) + (producto.cantidad ?? 0);
      } else {
        productSales[producto.id] = producto..cantidad = producto.cantidad ?? 0;
      }
    }
  }

  // Ordenar los productos por cantidad vendida en orden descendente
  final sortedProducts = productSales.values.toList()
    ..sort((a, b) => (b.cantidad ?? 0).compareTo(a.cantidad ?? 0));

  // Devolver los 5 más vendidos
  return sortedProducts.take(5).toList();
}

List<Producto> getTop5ProductsOfLast30Days() {
  final today = DateTime.now();
  final startDate = today.subtract(const Duration(days: 30)); // Fecha de inicio hace 30 días

  // Filtrar las órdenes de los últimos 30 días
  final recentOrders = ordenes.where((orden) {
    return orden.fechacreado.isAfter(startDate) && orden.fechacreado.isBefore(today);
  }).toList();

  // Crear un mapa para acumular la cantidad vendida por producto
  final productSales = <String, Producto>{};

  for (var orden in recentOrders) {
    for (var producto in orden.productos) {
      if (productSales.containsKey(producto.id)) {
        productSales[producto.id]!.cantidad = (productSales[producto.id]!.cantidad ?? 0) + (producto.cantidad ?? 0);
      } else {
        productSales[producto.id] = producto..cantidad = producto.cantidad ?? 0;
      }
    }
  }

  // Ordenar los productos por cantidad vendida en orden descendente
  final sortedProducts = productSales.entries.toList()
    ..sort((a, b) => b.value.cantidad!.compareTo(a.value.cantidad!));

  // Obtener los 5 productos más vendidos
  final top5Products = sortedProducts.take(5).map((entry) => entry.value).toList();

  return top5Products;
}

List<Producto> getTop5ProductsOfTodayByUser(BuildContext context) {
  final activeUser = Provider.of<AuthProvider>(context).user!;
  final userUid = activeUser.uid;

  final today = DateTime.now();
  final todayStart = DateTime(today.year, today.month, today.day);
  final todayEnd = todayStart.add(const Duration(days: 1));

  // Filtrar las órdenes del día para el usuario en sesión
  final todaysOrders = ordenes.where((orden) {
    // Comprobar si el usuario de la ruta coincide con el usuario activo
    final userMatch = orden.ruta.any((ruta) => ruta.usuarioZona.uid == userUid);

    return userMatch && orden.fechacreado.isAfter(todayStart) && orden.fechacreado.isBefore(todayEnd);
  }).toList();

  // Crear un mapa para acumular la cantidad vendida por producto
  final productSales = <String, Producto>{};

  for (var orden in todaysOrders) {
    for (var producto in orden.productos) {
      if (productSales.containsKey(producto.id)) {
        productSales[producto.id]!.cantidad = (productSales[producto.id]!.cantidad ?? 0) + (producto.cantidad ?? 0);
      } else {
        productSales[producto.id] = producto..cantidad = producto.cantidad ?? 0;
      }
    }
  }

  // Ordenar los productos por cantidad vendida en orden descendente
  final sortedProducts = productSales.values.toList()
    ..sort((a, b) => (b.cantidad ?? 0).compareTo(a.cantidad ?? 0));

  // Devolver los 5 más vendidos
  return sortedProducts.take(5).toList();
}



List<Customer> getTop5CustomersOfToday() {
  final today = DateTime.now();
  final todayStart = DateTime(today.year, today.month, today.day);
  final todayEnd = todayStart.add(const Duration(days: 1));

  // Filtrar las órdenes creadas hoy
  final todaysOrders = ordenes.where((orden) {
    return orden.fechacreado.isAfter(todayStart) && orden.fechacreado.isBefore(todayEnd);
  }).toList();

  // Crear un mapa para acumular el subtotal por cliente
  final customerSubtotals = <String, double>{};
  final customerMap = <String, Customer>{};

  for (var orden in todaysOrders) {
    for (var cliente in orden.clientes) {
      if (customerSubtotals.containsKey(cliente.id)) {
        customerSubtotals[cliente.id] =
            (customerSubtotals[cliente.id] ?? 0) + orden.subtotal;
      } else {
        customerSubtotals[cliente.id] = orden.subtotal;
        customerMap[cliente.id] = cliente;
      }
    }
  }

  // Ordenar los clientes por subtotal en orden descendente
  final sortedCustomers = customerSubtotals.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  // Obtener los 5 clientes con más subtotal
  final topCustomers = sortedCustomers.take(5).map((entry) => customerMap[entry.key]!).toList();

  return topCustomers;
}

List<Customer> getTop5CustomersOfTodayByUser(BuildContext context) {
  final activeUser = Provider.of<AuthProvider>(context).user!; // Obtén el usuario activo
  final today = DateTime.now();
  final todayStart = DateTime(today.year, today.month, today.day);
  final todayEnd = todayStart.add(const Duration(days: 1));

  // Filtrar las órdenes creadas hoy
  final todaysOrders = ordenes.where((orden) {
    return orden.fechacreado.isAfter(todayStart) && orden.fechacreado.isBefore(todayEnd);
  }).toList();

  // Crear un mapa para acumular el subtotal por cliente
  final customerSubtotals = <String, double>{};
  final customerMap = <String, Customer>{};

  for (var orden in todaysOrders) {
    // Filtrar por el usuario activo en la zona de la ruta
    for (var ruta in orden.ruta) {
      if (ruta.usuarioZona.uid == activeUser.uid) { // Verificamos que el usuario coincida
        for (var cliente in orden.clientes) {
          if (customerSubtotals.containsKey(cliente.id)) {
            customerSubtotals[cliente.id] = (customerSubtotals[cliente.id] ?? 0) + orden.subtotal;
          } else {
            customerSubtotals[cliente.id] = orden.subtotal;
            customerMap[cliente.id] = cliente;
          }
        }
      }
    }
  }

  // Ordenar los clientes por subtotal en orden descendente
  final sortedCustomers = customerSubtotals.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  // Obtener los 5 clientes con más subtotal
  final topCustomers = sortedCustomers.take(5).map((entry) => customerMap[entry.key]!).toList();

  return topCustomers;
}


double getCustomerSubtotalOfToday(String customerId) {
  final today = DateTime.now();
  final todayStart = DateTime(today.year, today.month, today.day);
  final todayEnd = todayStart.add(const Duration(days: 1));

  // Filtrar órdenes de hoy para un cliente específico
  return ordenes
      .where((orden) =>
          orden.fechacreado.isAfter(todayStart) &&
          orden.fechacreado.isBefore(todayEnd) &&
          orden.clientes.any((cliente) => cliente.id == customerId))
      .fold(0.0, (sum, orden) => sum + orden.subtotal);
}

int getCustomerOrderCountOfToday(String customerId) {
  final today = DateTime.now();
  final todayStart = DateTime(today.year, today.month, today.day);
  final todayEnd = todayStart.add(const Duration(days: 1));

  // Filtrar órdenes de hoy para un cliente específico
  return ordenes
      .where((orden) =>
          orden.fechacreado.isAfter(todayStart) &&
          orden.fechacreado.isBefore(todayEnd) &&
          orden.clientes.any((cliente) => cliente.id == customerId))
      .length;
}

List<Ordenes> getOrdersForCustomer(String customerId) {
  return ordenes.where((orden) =>
      orden.clientes.any((cliente) => cliente.id == customerId)).toList();
}

List<Customer> getTop5CustomersOfLast30Days() {
  final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));

  // Filtrar las órdenes de los últimos 30 días
  final recentOrders = ordenes.where((orden) {
    return orden.fechacreado.isAfter(thirtyDaysAgo);
  }).toList();

  final customerSubtotals = <String, double>{};
  final customerMap = <String, Customer>{};

  for (var orden in recentOrders) {
    for (var cliente in orden.clientes) {
      if (customerSubtotals.containsKey(cliente.id)) {
        customerSubtotals[cliente.id] =
            (customerSubtotals[cliente.id] ?? 0) + orden.subtotal;
      } else {
        customerSubtotals[cliente.id] = orden.subtotal;
        customerMap[cliente.id] = cliente;
      }
    }
  }

  // Ordenar por subtotal
  final sortedCustomers = customerSubtotals.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  // Obtener los 5 primeros
  final topCustomers = sortedCustomers.take(5).map((entry) => customerMap[entry.key]!).toList();

  return topCustomers;
}

double getCustomerSubtotalOfLast30Days(String customerId) {
  final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));

  return ordenes
      .where((orden) =>
          orden.fechacreado.isAfter(thirtyDaysAgo) &&
          orden.clientes.any((cliente) => cliente.id == customerId))
      .fold(0.0, (sum, orden) => sum + orden.subtotal);
}

int getCustomerOrderCountOfLast30Days(String customerId) {
  final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));

  return ordenes
      .where((orden) =>
          orden.fechacreado.isAfter(thirtyDaysAgo) &&
          orden.clientes.any((cliente) => cliente.id == customerId))
      .length;
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