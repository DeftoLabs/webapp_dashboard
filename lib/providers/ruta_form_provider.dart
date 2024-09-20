import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/ruta.dart';
import 'package:web_dashboard/models/usuario.dart';
import 'package:web_dashboard/services/notification_services.dart';

import '../models/customers.dart';



class RutaFormProvider extends ChangeNotifier {

Ruta? ruta;
GlobalKey<FormState> formKey = GlobalKey<FormState>();

bool validForm(){
  return formKey.currentState!.validate();
}


copyRutaWith ({
   String? id,
    bool? estado,
    String? codigoRuta,
    String? nombreRuta,
    String? zona,
    String? diasemana,
    List <Customer>? clientes,
    Usuario? usuarioZona,
    String? img,
}) {
  ruta = Ruta (
    id: id ?? ruta!.id,
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
    'usuarioZona': ruta!.usuarioZona.uid, 
  };
  try {
    await CafeApi.put('/rutas/${ruta!.id}', data);
    notifyListeners(); 
    return true;
  } catch (e) {
     NotificationService.showSnackBarError('Error to Update the Route');
      return false;
  }
}

Future updateRutaWithCustomer( String clienteId, String diasemana) async { // ID de la ruta

  Map<String, dynamic> data = {
    "clientes": [
      {
        "cliente": clienteId,  // ID del cliente
        "diasemana": diasemana  // Día de la semana
      }
    ]
  };

  try {
     await CafeApi.putJson('/rutas/${ruta!.id}', data);
     notifyListeners(); 
     return  true;
  } catch (e) {
    return false;
  }
}
Future<bool> updateDayOfWeekForCustomer(String rutaId, String clienteId, String nuevoDiaSemana) async {
  Map<String, dynamic> data = {
    "clientes": [
      {
        "cliente": clienteId,
        "diasemana": nuevoDiaSemana
      }
    ]
  };

  try {
    await CafeApi.putJson('/rutas/$rutaId', data); // Actualiza la ruta en la base de datos
    notifyListeners();  // Notifica a los listeners de la actualización
    return true;
  } catch (e) {
    print("Error actualizando el día de la semana: $e");
    return false;
  }
}


}


