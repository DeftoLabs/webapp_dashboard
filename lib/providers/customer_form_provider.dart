

import 'package:flutter/material.dart';
import 'package:web_dashboard/models/customers.dart';

class CustomerFormProvider extends ChangeNotifier {

  Customer? customer;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


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
    );
      notifyListeners();
  }

  bool _validForm(){
    return formKey.currentState!.validate();
  }

  updateCustomer() {

    if( !_validForm() ) return;

  }
}