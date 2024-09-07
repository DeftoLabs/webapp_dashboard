import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/http/ruta_response.dart';
import 'package:web_dashboard/models/ruta.dart';

class RutaProvider extends ChangeNotifier {

  List <Ruta>rutas = [];
  bool isLoading = true;

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
}