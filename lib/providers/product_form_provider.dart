import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/finance.dart';
import 'package:web_dashboard/models/products.dart';
import 'package:web_dashboard/services/notification_services.dart';

class ProductFormProvider extends ChangeNotifier {

Producto? producto;
 late GlobalKey<FormState> formKey;


  copyProductWith({
  String? id,
  String? nombre,
  bool? estado,
  User? usuario,
  double? precio1,
  double? precio2,
  double? precio3,
  double? precio4,
  double? precio5,
  Categoria? categoria,
  Finance? finance,
  double? tax,
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
      precio1: precio1 ?? producto!.precio1, 
      precio2: precio2 ?? producto!.precio2, 
      precio3: precio3 ?? producto!.precio3, 
      precio4: precio4 ?? producto!.precio4, 
      precio5: precio5 ?? producto!.precio5, 
      categoria: categoria ?? producto!.categoria, 
      tax: tax ?? producto!.tax,
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
    'precio1': producto!.precio1,
    'precio2': producto!.precio2,
    'precio3': producto!.precio3,
    'precio4': producto!.precio4,
    'precio5': producto!.precio5,
    'descripcion': producto!.descripcion,
    'stock': producto!.stock,
    'unid': producto!.unid,
    'categoria': producto!.categoria.id,
    'tax': producto!.tax,
  };

  try {
    await CafeApi.put('/productos/${producto!.id}', data);
    return true;
  } catch (e) {
    throw 'Error to Update the Product: $e';
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