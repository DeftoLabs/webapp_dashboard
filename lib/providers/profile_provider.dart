
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/http/profile_responde.dart';
import 'package:web_dashboard/models/profile.dart';
import 'package:web_dashboard/services/notification_services.dart';

class ProfileProvider extends ChangeNotifier {

  Profile? profile;
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List <Profile> profiles = [];
  bool isLoading = true;

    Profile copyWith({
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
    return Profile(
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

  ProfileProvider (){
    getProfile();
  }

 bool _validForm() {
  if (formKey.currentState == null) {
    return false;
  }

  return formKey.currentState!.validate();
}

 getProfile() async {
  final resp = await CafeApi.httpGet('/perfiles');
  final profileResp = ProfileResponse.fromMap(resp);
  profiles = [... profileResp.profile];
  isLoading = false;
  notifyListeners();
}

 Future<Profile> getProfilById(String id) async {

  try {
  final resp = await CafeApi.httpGet('/perfiles/$id');
  final profile = Profile.fromMap(resp);
  return profile;
  } catch (e) {
    rethrow;
  }


}

Future updateProfile() async {
    if (!_validForm()) return false;

  if (profile == null) {
    throw 'Profile is null';
  }

  final data = {
    'estado': profile!.estado,
    'id': profile!.id,
    'codigo': profile!.codigo,
    'idfiscal': profile!.idfiscal,
    'nombre': profile!.nombre,
    'razons': profile!.razons,
    'direccion': profile!.direccion,
    'telefono': profile!.telefono,
    'web': profile!.web,
    'correos': profile!.correos,
  };

  try {
    final resp =  await CafeApi.put('/perfiles/${profile!.id}', data);
    return true;
  } catch (e) {
    throw 'Error to Update the Profile: $e';
  }
}

Future uploadImage(String path, Uint8List bytes) async {
  try {
    final response = await CafeApi.uploadImage(path, bytes);
    final imageUrl = response['img']; 
    if (profile != null) {
    profile = profile!.copyWith(img: imageUrl); 
      notifyListeners();
    }
    NotificationService.showSnackBa('Image Uploaded Successfully');
    notifyListeners();
  } catch (e) {
    NotificationService.showSnackBarError('Failed to Upload Image, Try Again !!');
  }
}

}
