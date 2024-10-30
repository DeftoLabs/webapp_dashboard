import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/http/products_response.dart';
import 'package:web_dashboard/models/products.dart';
import 'package:web_dashboard/services/notification_services.dart';

class ProductsProvider extends ChangeNotifier {
  
  Producto? producto;
  List<Producto> productos = [];
  final List<String> _units = ['BOX', 'KGS', 'LBS', 'UNIT', 'PKG'];
  List<String> get units => _units;

  bool isloading = true;
  bool ascending = true;
  int? sortColumnIndex;

  ProductsProvider(){
    getProducts();
  }


  Future<void> getProducts() async {
    final resp = await CafeApi.httpGet('/productos');
    final productsResp = ProductsResponse.fromMap(resp);
    productos = [...productsResp.productos];
    isloading = false;
    notifyListeners();
  }

    Future<Producto?> getProductById (String id) async {
      try {
        final resp = await CafeApi.httpGet('/productos/$id');
        final producto = Producto.fromMap(resp);
        return producto;
      } catch (e) {
        return null;
      }

  
  }

  Future<void> getUnits() async {
    final resp = await CafeApi.httpGet('/productos');
    final productsResp = ProductsResponse.fromMap(resp);
    productos = [...productsResp.productos];
    notifyListeners();
  }

  Future newProduct ({
    required String nombre,
    required double precio,
    String? descripcion,
    required double stock,
    required String unid,
    required String categoria,
    }) async {
    final data = {
      'nombre': nombre,
      'precio': precio,
      'descripcion': descripcion,
      'stock': stock,
      'unid': unid,
      'categoria': categoria,
    };
    try{
      final json = await CafeApi.post('/productos', data);
      final newProduct = Producto.fromMap(json);
      productos.add(newProduct);
      notifyListeners();
    } catch (e){
      throw ' Error to create New Product ';
    }
  }

  Future updateProduct ({
    required String id,
    required String nombre,
    required double precio1,
    required double precio2,
    required double precio3,
    required double precio4,
    required double precio5,
    String? descripcion,
    required double stock,
    required String unid,
    required String categoria,
  })  async {
    final data = {
      'nombre': nombre,
      'precio1': precio1,
      'precio2': precio2,
      'precio3': precio3,
      'precio4': precio4,
      'precio5': precio5,
      'descripcion': descripcion,
      'stock': stock,
      'unid': unid,
      'categoria': categoria,
    };
    try{
      await CafeApi.put('/productos/$id', data);
      productos = productos.map((product) {
          if(product.id != id) return product;
          product.nombre = nombre;
          product.precio1 = precio1;
          product.precio2 = precio2;
          product.precio3 = precio3;
          product.precio4 = precio4;
          product.precio5 = precio5;
          product.descripcion = descripcion;
          product.stock = stock;
          product.categoria.id = categoria;
          return product;
      }).toList();
      notifyListeners();
    } catch (e){
      throw ' Error to Update the Product ';
    }
  }

    Future<String?> newCreateProduct({
    required String nombre,
    required double precio1,
    required double precio2,
    required double precio3,
    required double precio4,
    required double precio5,
    String? descripcion,
    required double stock,
    required String unid,
    required String categoria,
    String? finance,
  }) async {
    final data = {
      'nombre': nombre,
      'precio1': precio1,
      'precio2': precio2,
      'precio3': precio3,
      'precio4': precio4,
      'precio5': precio5,
      'descripcion': descripcion,
      'stock': stock,
      'unid': unid,
      'categoria': categoria,
      'finance': finance
    };
    
    try {
      
      final json = await CafeApi.post('/productos', data);     
      final newProduct = Producto.fromMap(json);
      productos.add(newProduct);
      notifyListeners();
    } catch (e) {
        throw 'Error creating new product: $e'; 
    }
    return null;
  }

  Future deleteProduct (String id) async {
    try{
      await CafeApi.delete('/productos/$id',{});
      productos.removeWhere((productos) => productos.id == id);
      notifyListeners();
    } catch (e){
      throw ' Error to Delete the Product ';
    }
  }

  void sort<T> (Comparable<T> Function (Producto producto) getField) {

    productos.sort( ( a,b ) {

      final aValue = getField (a);
      final bValue = getField (b);

      return ascending 
      ? Comparable.compare(aValue, bValue)
      : Comparable.compare(bValue, aValue);

    });

    ascending = !ascending;

    notifyListeners();

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
    await getProducts();
    notifyListeners();
  } catch (e) {
    NotificationService.showSnackBarError('Failed to Upload Image, Try Again !!');
  }
}
}
