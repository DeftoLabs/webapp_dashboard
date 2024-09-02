

import 'dart:typed_data';

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
    String? email1,
    String? email2,
    String? email3,
    String? email4,
    String? email5,
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
      email1: email1 ?? profile!.email1,
      email2: email2 ?? profile!.email2,
      email3: email3 ?? profile!.email3,
      email4: email4 ?? profile!.email4,
      email5: email5 ?? profile!.email5,
      correos: correos ?? profile!.correos,
      img: img ?? profile!.img,
    );
    notifyListeners();
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
      'email1': profile!.email1,
      'email2': profile!.email2,
      'email3': profile!.email3,
      'email4': profile!.email4,
      'email5': profile!.email5,
      'correos': profile!.correos.map((c) => c.toMap()).toList(),
    };

    try {
      await CafeApi.put('/perfiles/${profile!.id}', data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future <Profile> uploadProfileImage ( String path, Uint8List bytes) async {
    
    try {
      final resp = await CafeApi.uploadFile(path, bytes);
      profile = Profile.fromMap(resp);
      notifyListeners();

      return profile!;

    } catch (e) {
      throw 'Error to Upload the Image';
    }
  }

void updateEmail(int index, {String? departamento, String? email}) {
  final correos = List<Correo>.from(profile!.correos);
  final updatedCorreo = correos[index].copyWith(
    departamento: departamento ?? correos[index].departamento,
    email: email ?? correos[index].email,
  );
  correos[index] = updatedCorreo;
  copyProfileWith(correos: correos);
  updateProfile();
}


  
  }