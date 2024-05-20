

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/categories.dart';
import 'package:web_dashboard/models/http/categories_response.dart';

class CategoriesProvier extends ChangeNotifier {

  List <Categoria> categorias = [];


  getCategories() async {
    final resp = await CafeApi.httpGet('/categorias');
    final categoriesResp = CategoriesResponse.fromMap(resp);
    categorias = [...categoriesResp.categorias];
    notifyListeners();
  }

  Future newCategory (String name) async {
    final data = {
      'nombre': name
    };
    try{
      final json = await CafeApi.post('/categorias', data);
      final newCategory = Categoria.fromMap(json);
      categorias.add(newCategory);
      notifyListeners();
    } catch (e){
      throw ' Error to create the Category ';
    }
  }

    Future updateCategory (String id, String name) async {
    final data = {
      'nombre': name
    };
    try{
      await CafeApi.put('/categorias/$id', data);
      categorias = categorias.map(
        (category) {
          if(category.id != id) return category;
          category.nombre = name;
          return category;
      },).toList();
      notifyListeners();
    } catch (e){
      throw ' Error to Update the Category ';
    }
  }

      Future deleteCategory (String id) async {
    try{
      await CafeApi.delete('/categorias/$id',{});
      categorias.removeWhere((categorias) => categorias.id == id);
      notifyListeners();
    } catch (e){
      throw ' Error to Delete the Category ';
    }

  }
}