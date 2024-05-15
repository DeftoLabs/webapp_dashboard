

import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {

  String? _token;

  login (String email, String password) {

    // TODO: Petition HTTP

    this._token = 'dasdasdasdasdasdasdasdas';

    print('Almacener JWT: $_token');

    // TODO: Navegar el Dashboard

    notifyListeners();
  }
}