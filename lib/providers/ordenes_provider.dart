

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/http/ordenes_response.dart';
import 'package:web_dashboard/models/ordenes.dart';

class OrdenesProvider extends ChangeNotifier {

  List <Ordenes>ordenes = [];
  bool isLoading = true;

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
}