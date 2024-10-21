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
}