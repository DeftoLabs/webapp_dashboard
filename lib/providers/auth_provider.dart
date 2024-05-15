

import 'package:flutter/material.dart';
import 'package:web_dashboard/services/local_storage.dart';

class AuthProvider extends ChangeNotifier {

  String? _token;

  login (String email, String password) {

    // TODO: Petition HTTP

    _token = 'dasdasdasdasdasdasdasdas';
    LocalStorage.prefs.setString('token', _token! );

    print('Almacener JWT: $_token');

    // TODO: Navegar el Dashboard

    notifyListeners();
  }
}