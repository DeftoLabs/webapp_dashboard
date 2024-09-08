import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/http/ruta_response.dart';
import 'package:web_dashboard/models/ruta.dart';

class RutaProvider extends ChangeNotifier {

  List <Ruta>rutas = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  RutaProvider() {
    getPaginatedRoutes();
  }

getPaginatedRoutes() async {
  final resp = await CafeApi.httpGet('/rutas');
  final rutaResp = RutaResponse.fromMap(resp);

  rutas = [ ... rutaResp.rutas];
  isLoading = false;
  notifyListeners();

}

Future <Ruta> getRouteById(String id) async {

  try {
  final resp = await CafeApi.httpGet('/rutas/$id');
  print('Respuesta del Backend: $resp');
  final ruta = Ruta.fromMap(resp);
  return ruta;
  } catch (e) {
    rethrow;
  }
}


void sort<T>(Comparable<T> Function( Ruta ruta) getField) {
  rutas.sort( (a , b) {
    final aValue = getField ( a );
    final bValue = getField ( b );
    return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue);
  });
  ascending = !ascending;
  notifyListeners();
} 
}