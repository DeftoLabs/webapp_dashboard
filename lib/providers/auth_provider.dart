import 'package:flutter/material.dart';
import 'package:web_dashboard/router/router.dart';

import 'package:web_dashboard/services/local_storage.dart';
import 'package:web_dashboard/services/navigation_service.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticaded,
}

class AuthProvider extends ChangeNotifier {

  String? _token;
  AuthStatus authStatus = AuthStatus.checking;

  AuthProvider () {
    isAuthenticated();
  }

  login (String email, String password) {

    // TODO: Petition HTTP

    _token = 'dasdasdasdasdasdasdasdas';
    LocalStorage.prefs.setString('token', _token! );

    authStatus = AuthStatus.authenticated;
    notifyListeners();

    NavigationService.replaceTo(Flurorouter.dashboardRoute);
  }

    Future<bool> isAuthenticated () async {

      final token = LocalStorage.prefs.getString('token');

      if( token == null) {
        authStatus = AuthStatus.notAuthenticaded;
        return false;
      }

            //TODO: ir al backend si el JWT es valido


      await Future.delayed(const Duration(milliseconds: 1000));
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    }

}