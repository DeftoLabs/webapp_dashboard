import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String name = '';
  String phone ='';
  String zone = '';

  validateForm(){
    
    if( formKey.currentState!.validate() ){
          return true;
    } else {
      return false;
    }

  }

}