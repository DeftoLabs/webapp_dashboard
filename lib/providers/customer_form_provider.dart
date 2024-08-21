import 'package:flutter/material.dart';

import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/models/zona.dart';
import 'package:web_dashboard/services/notification_services.dart';

class CustomerFormProvider extends ChangeNotifier {

  Customer? customer;
  late GlobalKey<FormState> formKey;


  copyCustomerWith({
    String? id,
    bool? estado,
    String? codigo,
    String? idfiscal,
    String? nombre,
    String? razons,
    String? sucursal,
    String? direccion,
    String? correo,
    String? telefono,
    String? web,
    String? contacto,
    int? credito,
    String? note,
    User? usuario,
    Zona? zona,
  }) 
  { customer = Customer(
    id: id ?? customer!.id,
    estado: estado ?? customer!.estado, 
    codigo: codigo ?? customer!.codigo, 
    idfiscal: idfiscal ?? customer!.idfiscal, 
    nombre: nombre ?? customer!.nombre, 
    razons: razons ?? customer!.razons, 
    sucursal: sucursal ?? customer!.sucursal, 
    direccion: direccion ?? customer!.direccion, 
    correo: correo ?? customer!.correo, 
    telefono: telefono ?? customer!.telefono,
    web: web ?? customer!.web, 
    contacto: contacto ?? customer!.contacto, 
    credito: credito ?? customer!.credito, 
    note: note ?? customer!.note, 
    usuario: usuario ?? customer!.usuario,
    zona: zona ?? customer!.zona,
    );
      notifyListeners();
  }

  bool _validForm(){
    return formKey.currentState!.validate();
  }

  updateCustomer() async {

    if( !_validForm() ) return false;

    final data = {
      'idfiscal': customer!.idfiscal,
      'nombre': customer!.nombre,
      'razons': customer!.razons,
      'sucursal': customer!.sucursal,
      'direccion': customer!.direccion,
      'correo': customer!.correo,
      'telefono': customer!.telefono,
      'web': customer!.web,
      'contacto': customer!.contacto,
      'credito': customer!.credito,
      'note': customer!.note,
      'zona': customer!.zona.id,
    };

    try {
      
      await CafeApi.put('/clientes/${ customer!.id}', data);
      return true;

    } catch (e) {
      NotificationService.showSnackBarError('Error with the Customer');
      return false;
      
    }

  }
}