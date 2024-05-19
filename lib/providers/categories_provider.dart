

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
}