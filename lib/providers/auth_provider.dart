import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/http/auth_response.dart';
import 'package:web_dashboard/models/usuario.dart';
import 'package:web_dashboard/providers/orden_date_provider.dart';
import 'package:web_dashboard/providers/payments_provider.dart';
import 'package:web_dashboard/router/router.dart';

import 'package:web_dashboard/services/local_storage.dart';
import 'package:web_dashboard/services/navigation_service.dart';
import 'package:web_dashboard/services/notification_services.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticaded,
}

class AuthProvider extends ChangeNotifier {

  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  AuthProvider () {
    isAuthenticated();
  }

  login (String email, String password) {

   
 final data = {
        'correo': email,
        'password': password,
      };

      CafeApi.post('/auth/login', data).then((json) {


        final authResponse = AuthResponse.fromJson(json);
        user = authResponse.usuario;

        authStatus = AuthStatus.authenticated;
        LocalStorage.prefs.setString('token', authResponse.token );
        NavigationService.replaceTo(Flurorouter.dashboardRoute);
        CafeApi.configureDio();
        notifyListeners();

      }).catchError((e){
        NotificationService.showSnackBarError(' User / Password not valid !');
      });
   
  }
    register (String email, String password, String name) {

      final data = {
        'nombre': name,
        'correo': email,
        'password': password,
      };

      CafeApi.post('/usuarios', data).then((json) {


        final authResponse = AuthResponse.fromJson(json);
        user = authResponse.usuario;

        authStatus = AuthStatus.authenticated;
        LocalStorage.prefs.setString('token', authResponse.token );
        NavigationService.replaceTo(Flurorouter.dashboardRoute );
        CafeApi.configureDio();
        notifyListeners();

      }).catchError((e){
        NotificationService.showSnackBarError(' User / Password not valid !');
      });


  }

  void newUserRegister (String email, String password, String name, String phone, String zone,){

    final data ={
      'nombre': name,
      'correo': email,
      'password': password, 
      'phone': phone,
      'zone': zone,
    };

      CafeApi.post('/usuarios', data).then((json) {

        NotificationService.showSnackBa('User Created Successfully');
        CafeApi.configureDio();
        notifyListeners();
      }).catchError((e) {
        NotificationService.showSnackBarError('This Email or Code is already registered, Try Again');
      }) ;
  }

    Future<bool> isAuthenticated () async {

      final token = LocalStorage.prefs.getString('token');

      if( token == null) {
        authStatus = AuthStatus.notAuthenticaded;
        return false;
      }

      try {

        final resp = await CafeApi.httpGet('/auth');
        final authResponse = AuthResponse.fromJson(resp);
        LocalStorage.prefs.setString('token', authResponse.token);
        user = authResponse.usuario;
        authStatus = AuthStatus.authenticated;
        notifyListeners();
        return true;

      } catch (e) {
        authStatus = AuthStatus.notAuthenticaded;
        notifyListeners();
        return false;
      }
    }

    logout (BuildContext context) {
      LocalStorage.prefs.remove('token');
      authStatus = AuthStatus.notAuthenticaded;
      Provider.of<OrdenDateProvider>(context, listen: false).clearOrders();
      Provider.of<PaymentsProvider>(context, listen: false).clearPayments();
      notifyListeners();
    }

}