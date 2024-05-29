import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/usuario.dart';



class UserFormProvider extends ChangeNotifier {

  Usuario? user;
  late GlobalKey<FormState> formKey;


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
    'phone': user!.phone,
    'zone': user!.zone,
    'estado': user!.estado,
    'rol': user!.rol,
    
  };
  try {
    final resp = await CafeApi.put('/usuarios/${user!.uid}', data);
    return true;
  } catch (e) {
    return 'Update Error';
  }
}

Future<Usuario> uploadImage (String path, Uint8List bytes) async {

try {
  final resp = await CafeApi.uploadFile(path, bytes);
  user = Usuario.fromMap(resp);
  notifyListeners();

  return user!;
  
} catch (e) {
  throw 'Error User Img Profile Provider';
}
}

}