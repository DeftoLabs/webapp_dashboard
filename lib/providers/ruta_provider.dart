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

Future<void> deleteCustomerRuta(String rutaId, String customerId) async {
  try {
    // Llama al método delete con un mapa vacío como segundo argumento
    await CafeApi.delete('/rutas/$rutaId/clientes/$customerId', {});
    // Actualizar la lista de rutas después de eliminar el cliente
    rutas = rutas.map((ruta) {
      if (ruta.id == rutaId) {
        // Filtrar el cliente eliminado
        ruta.clientes.removeWhere((cliente) => cliente.id == customerId);
      }
      return ruta;
    }).toList();
    notifyListeners();
  } catch (e) {
    throw('Error to Delete a Customer / Route');
  }
}
    Future newRoute (String codigoRuta, String nombreRuta) async {
    final data = {
      'codigoRuta': codigoRuta,
      'nombreRuta': nombreRuta,
    };
    try{
      final json = await CafeApi.post('/rutas', data);
      final newRuta = Ruta.fromMap(json);
      rutas.add(newRuta);
      notifyListeners();
    } catch (e){
      throw ' Error to create the Route ';
    }
  }
}