

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/products.dart';
import 'package:web_dashboard/services/notification_services.dart';

class ProductFormProvider extends ChangeNotifier {

  Producto? producto;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  copyProductWith({
  String? id,
  String? nombre,
  bool? estado,
  User? usuario,
  double? precio,
  Categoria? categoria,
  String? descripcion,
  bool? disponible,
  double? stock,
  String? unid,
  String? img,
  }) {
    producto = Producto(
      id: id ?? producto!.id, 
      nombre: nombre ?? producto!.nombre, 
      estado: estado ?? producto!.estado, 
      usuario: usuario ?? producto!.usuario, 
      precio: precio ?? producto!.precio, 
      categoria: categoria ?? producto!.categoria, 
      disponible: disponible ?? producto!.disponible, 
      stock: stock ?? producto!.stock, 
      unid: unid ?? producto!.unid,
      );
      notifyListeners();
  }

  bool _validForm(){
    return formKey.currentState!.validate();
  }

Future updateProduct() async {
  if (!_validForm()) return false;

  final data = {
    'nombre': producto!.nombre,
    'precio': producto!.precio,
    'descripcion': producto!.descripcion,
    'stock': producto!.stock,
    'unid': producto!.unid,
    'categoria': producto!.categoria.id,
  };

  try {
    await CafeApi.put('/productos/${producto!.id}', data);
    return true;
  } catch (e) {
    throw 'Error to create New Product: $e';
  }
}


Future uploadImage(String path, Uint8List bytes) async {
  try {
    final response = await CafeApi.uploadImage(path, bytes);
    final imageUrl = response['img']; 
    if (producto != null) {
      producto = producto!.copyWith(img: imageUrl); 
      notifyListeners();
    }
    NotificationService.showSnackBa('Image Uploaded Successfully');
    notifyListeners();
  } catch (e) {
    NotificationService.showSnackBarError('Failed to Upload Image, Try Again !!');
  }
}
}