import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/zona.dart';
import 'package:web_dashboard/router/router.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';

class NewCustomerProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String codigo = '';
  String idfiscal = '';
  String nombre = '';
  String razons ='';
  String sucursal = '';
  String direccion = '';
  String correo = '';
  String telefono = '';
  String web ='';
  String contacto = '';
  int credito = 0;
  String note = '';
  String name = '';
  Zona? zone;

  void updateZone(Zona newZone) {
    zone = newZone;
    notifyListeners();
  }

bool validateForm() {
  if (formKey.currentState == null) return false;
  return formKey.currentState!.validate();
}

   void newCustomerRegister( 
    String codigo, 
    String idfiscal, 
    String nombre, 
    String razons, 
    String sucursal, 
    String direccion, 
    String correo, 
    String telefono, 
    String web, 
    String contacto,
    int credito, 
    String note, 
    String name, 
    Zona? zone
   )  {
   
    final data = {
      'codigo': codigo,
      'idfiscal': idfiscal,
      'nombre': nombre,
      'razons': razons,
      'sucursal': sucursal,
      'direccion': direccion,
      'correo': correo,
      'telefono': telefono,
      'web': web,
      'contacto': contacto,
      'credito': credito,
      'note': note,
      'zona': zone?.id ?? '', 
    };


  CafeApi.post('/clientes', data).then((json) {

    NotificationService.showSnackBa('Customer Created Successfully');
    NavigationService.replaceTo(Flurorouter.customersRoute);
    CafeApi.configureDio();
    notifyListeners();
      }).catchError((e) {
    NotificationService.showSnackBarError('This code is already register');

  });
}
}
