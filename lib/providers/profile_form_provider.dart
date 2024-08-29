

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/profile.dart';

class ProfileFormProvider extends ChangeNotifier {

  Profile? profile;
  late GlobalKey<FormState> formKey;

  copyProfileWith({
    bool? estado,
    String? id,
    String? codigo,
    String? idfiscal,
    String? nombre,
    String? razons,
    String? direccion,
    String? telefono,
    String? web,
    List<Correo>? correos,
    String? img,
  }) {
    profile = Profile(
      estado: estado ?? profile!.estado,
      id: id ?? profile!.id,
      codigo: codigo ?? profile!.codigo,
      idfiscal: idfiscal ?? profile!.idfiscal,
      nombre: nombre ?? profile!.nombre,
      razons: razons ?? profile!.razons,
      direccion: direccion ?? profile!.direccion,
      telefono: telefono ?? profile!.telefono,
      web: web ?? profile!.web,
      correos: correos ?? profile!.correos,
      img: img ?? profile!.img,
    );
  }

  bool validForm() {
    return formKey.currentState!.validate();
  }

  Future updateProfile () async {
    if( !validForm()) return false;

    final data = {
      'idfiscal': profile!.idfiscal,
      'nombre': profile!.nombre,
      'razons': profile!.razons,
      'direccion': profile!.direccion,
      'telefono': profile!.telefono,
      'web': profile!.web,
      'correo': profile!.correos,
    };

    try {
      await CafeApi.put('/perfiles/${profile!.id}', data);
      return true;
    } catch (e) {
      return false;
    }

   


  }
  
  }