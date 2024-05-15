import 'package:flutter/material.dart';
import 'package:web_dashboard/providers/auth_provider.dart';

class LoginFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();  

  final AuthProvider authProvider;

  String email = '';
  String password = '';

  LoginFormProvider (this.authProvider);

  validateForm () {



    if (formKey.currentState!.validate()) {
      print ('Form valid ... Login');
      print ("$email === $password");

      authProvider.login(email, password);
    }else {
      print ('Form not Valid');
    };

  }

}