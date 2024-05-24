import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/usuario.dart';



class UserFormProvider extends ChangeNotifier {

  Usuario? user;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


copyUserWith ({
    String? rol,
    bool? estado,
    bool? google,
    String? nombre,
    String? correo,
    String? uid,
    String? img,
    String? phone,
    String? zone,

}){
  user = Usuario (
    rol: rol ?? user!.rol,
    estado: estado ?? user!.estado,
    google: google ?? user!.google,
    nombre: nombre ?? user!.nombre,
    correo: correo ?? user!.correo,
    uid: uid ?? user!.uid,
    img: img ?? user!.img,
    phone: phone ?? user!.phone,
    zone: zone ?? user!.zone,
  );
  notifyListeners();
}

bool _validForm() {
  return formKey.currentState!.validate();
}

Future updateUser () async {
  if ( !_validForm()) return false;

  final data = {
    'nombre': user!.nombre,
    'correo': user!.correo,
  };
  try {
    final resp = await CafeApi.put('/usuarios/${user!.uid}', data);
    return true;
  } catch (e) {
    return 'Update Error';
  }


}

}