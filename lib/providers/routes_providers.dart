import 'package:flutter/material.dart';

import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/http/routes_response.dart';
import 'package:web_dashboard/models/zona.dart';

class RoutesProviders extends ChangeNotifier {

  List<Zona> zonas = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  RoutesProviders() {
    getZonas();
  }

  getZonas () async {
    final resp = await CafeApi.httpGet('/zonas/');
    final routesResp = RoutesResponse.fromMap(resp);

    zonas = [... routesResp.zonas];

    isLoading = false;

    notifyListeners();

  }

    Future<Zona?> getZonasById ( String id ) async {
      try {
      final resp = await CafeApi.httpGet('/zonas/$id');
      final zona = Zona.fromMap(resp);
      return zona;
      } catch (e) {
        return null;
      }


  }

  void sort<T>(Comparable<T> Function (Zona zona) getField) {

    zonas.sort((a,b) {

      final aValue = getField (a);
      final bValue = getField (b);

      return ascending 
      ? Comparable.compare(aValue, bValue) 
      : Comparable.compare(bValue, aValue);

    });

    ascending = !ascending;
    notifyListeners();
  } 

  void refreshRoute( Zona newZona) {
    zonas = zonas.map(
      (zona) {
        if(zona.id == newZona.id) {
          zona = newZona;
        }
        return zona;
      }
      ).toList();


    notifyListeners();
  }

}