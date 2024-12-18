import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/ordenes.dart';

class OrdenDateProvider extends ChangeNotifier {

  List <Ordenes> ordenes = [];
  bool isLoading = true;


  OrdenDateProvider(){
    getOrdenByDay();
  }

 Future<void> getOrdenByDay() async {
 try {
      String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final resp = await CafeApi.httpGet('/ordens/fecha/$todayDate');


      ordenes = (resp as List).map((orden) => Ordenes.fromMap(orden)).toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      rethrow;
    }
   
  }

   Future<void> getOrdenByDaySearch(DateTime date) async {
 try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      final resp = await CafeApi.httpGet('/ordens/fechaentrega/$formattedDate');
      ordenes = (resp as List).map((orden) => Ordenes.fromMap(orden)).toList();
      if (ordenes.isEmpty) 
      {
      return;
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }

   Future<void> getOrdenByDayCreate(DateTime date) async {
 try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      final resp = await CafeApi.httpGet('/ordens/fecha/$formattedDate');
      ordenes = (resp as List).map((orden) => Ordenes.fromMap(orden)).toList();
      if (ordenes.isEmpty) 
      {
      return;
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      rethrow;
    }
   
  }

Future<void> getOrdenByCustomer(String customerID) async {
  try {
    final resp = await CafeApi.httpGet('/ordens/cliente/$customerID');

    if (resp is Map<String, dynamic> && resp.containsKey('ordenes') && (resp['ordenes'] as List).isEmpty) {
      throw Exception('Customer With No Orders');
    }

    ordenes = (resp['ordenes'] as List).map((orden) => Ordenes.fromMap(orden)).toList();
    isLoading = false;
    notifyListeners();
  } catch (e) {
    isLoading = false;
    rethrow;
  }
}

    Future<void> getOrdenByRepresentative(String usuarioZona) async {
    try {  
      final resp = await CafeApi.httpGet('/ordens/usuarioZona/$usuarioZona');
      
      if (resp is Map<String, dynamic> && resp.containsKey('ordenes') && (resp['ordenes'] as List).isEmpty) {
      throw Exception('Sales Representative With No Orders');
    }
     ordenes = (resp['ordenes'] as List).map((orden) => Ordenes.fromMap(orden)).toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }

    Future<void> getOrdenByProducto(String productoID) async {
    try {  
      final resp = await CafeApi.httpGet('/ordens/producto/$productoID');
      
      if (resp is Map<String, dynamic> && resp.containsKey('ordenes') && (resp['ordenes'] as List).isEmpty) {
      throw Exception('Products With No Orders');
    }
     ordenes = (resp['ordenes'] as List).map((orden) => Ordenes.fromMap(orden)).toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }

      Future<void> getOrdenByRoute(String ruta) async {
    try {  
      final resp = await CafeApi.httpGet('/ordens/ruta/$ruta');
      
      if (resp is Map<String, dynamic> && resp.containsKey('ordenes') && (resp['ordenes'] as List).isEmpty) {
      throw Exception('Ruta With No Orders');
    }
     ordenes = (resp['ordenes'] as List).map((orden) => Ordenes.fromMap(orden)).toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }
}