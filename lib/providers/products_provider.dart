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
  final List<String> _units = ['Box', 'Kgs', 'Lbs', 'Units', 'Pkg'];
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

    Future<Producto> getProductById (String id) async {
      try {
        final resp = await CafeApi.httpGet('/productos/$id');
        final producto = Producto.fromMap(resp);
        return producto;
      } catch (e) {
        throw 'Error to Get the Product';
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
    required double precio,
    String? descripcion,
    required double stock,
    required String unid,
    required String categoria,
  })  async {
    final data = {
      'nombre': nombre,
      'precio': precio,
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
          product.precio = precio;
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
    required double precio,
    String? descripcion,
    required double stock,
    required String unid,
    required String categoria,
    Uint8List? imageBytes,
  }) async {
    final data = {
      'nombre': nombre,
      'precio': precio,
      'descripcion': descripcion,
      'stock': stock,
      'unid': unid,
      'categoria': categoria,
    };
    
    try {
      String? imageUrl;
      if (imageBytes != null) {
        final response = await CafeApi.uploadImage('/uploads/productos/${''}', imageBytes);
        imageUrl = response['img'];
      }

      
      if (imageUrl != null) {
        data['img'] = imageUrl;
      }
      
      final json = await CafeApi.post('/productos', data);
      final newProduct = Producto.fromMap(json);
      productos.add(newProduct);
      notifyListeners();

      return newProduct.id;
    } catch (e) {
      throw 'Error to create New Product';
    }
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
