

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/zona.dart';

class RouteFormProvider extends ChangeNotifier {

  Zona? zona;
  late GlobalKey<FormState> formKey;

   RouteFormProvider() {
    formKey = GlobalKey<FormState>();
  }

  copyRouteWith({
  String? id,
  String? codigo,
  String? nombrezona,
  String? descripcion,
  }) {
    zona = Zona(
      id: id ?? zona!.id, 
      codigo: codigo ?? zona!.codigo, 
      nombrezona: nombrezona ?? zona!.nombrezona,
      descripcion: descripcion ?? zona!.descripcion
      );
      notifyListeners();
  }

 bool _validForm() {
  return formKey.currentState!.validate();
 }

 updateRoute() async {
  if( !_validForm()) return false;

  final data = {
  'id': zona!.id,  
  'codigo': zona!.codigo,
  'nombrezona': zona!.nombrezona,
  'descripcion': zona!.descripcion,
  };
  try {
    await CafeApi.put('/zonas/${zona!.id}', data);
    return true;
  } catch (e) {
    return false;
  }

 }

}