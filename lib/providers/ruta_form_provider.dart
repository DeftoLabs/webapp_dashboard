import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/ruta.dart';
import 'package:web_dashboard/models/usuario.dart';

import '../models/customers.dart';



class RutaFormProvider extends ChangeNotifier {

Ruta? ruta;
GlobalKey<FormState> formKey = GlobalKey<FormState>();

bool validForm(){
  return formKey.currentState!.validate();
}


copyRutaWith ({
    bool? estado,
    String? codigoRuta,
    String? nombreRuta,
    String? zona,
    String? diasemana,
    final List <Customer>? clientes,
    Usuario? usuarioZona,
    String? img,
}) {
  ruta = Ruta (
    estado: estado ?? ruta!.estado,
    codigoRuta:  codigoRuta ?? ruta!.codigoRuta,
    nombreRuta:  nombreRuta ?? ruta!.nombreRuta,
    zona: zona ?? ruta!.zona,
    diasemana: diasemana ?? ruta!.diasemana,
    clientes: clientes ?? ruta!.clientes,
    usuarioZona: usuarioZona ?? ruta!.usuarioZona,
    img: img ?? ruta!.img,
  );
  notifyListeners();
}

Future updateRuta ()async {

  if(!validForm()) return false;

  final data = {
    'nombreRuta': ruta!.nombreRuta,
  };

  try {
    final resp = await CafeApi.put('/rutas/${ ruta!.id}', data);
    return true;
  } catch (e) {
    
  }

}

}
