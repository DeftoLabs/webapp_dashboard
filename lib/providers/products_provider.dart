import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/http/products_response.dart';
import 'package:web_dashboard/models/products.dart';

class ProductsProvider extends ChangeNotifier {

  List<Producto> productos = [];


  Future<void> getProducts() async {
    final resp = await CafeApi.httpGet('/productos');
    final productsResp = ProductsResponse.fromMap(resp);
    productos = [...productsResp.productos];
    notifyListeners();
  }

  Future newProduct ({
    required String nombre,
    required double precio,
    String? descripcion,
    required bool disponible,
    required String categoria,
    }) async {
    final data = {
      'nombre': nombre,
      'precio': precio,
      'descripcion': descripcion,
      'disponible': disponible,
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
    required bool disponible,
    required String categoria,
  })  async {
    final data = {
      'nombre': nombre,
      'precio': precio,
      'descripcion': descripcion,
      'disponible': disponible,
      'categoria': categoria,
    };
    try{
      await CafeApi.put('/productos/$id', data);
      productos = productos.map((product) {
          if(product.id != id) return product;
          product.nombre = nombre;
          product.precio = precio;
          product.descripcion = descripcion;
          product.disponible = disponible;
          product.categoria.id = categoria;
          return product;
      }).toList();
      notifyListeners();
    } catch (e){
      throw ' Error to Update the Product ';
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
}