import 'package:flutter/material.dart';
import 'package:web_dashboard/models/ruta.dart';



class RutaFormProvider extends ChangeNotifier {

Ruta? ruta;
GlobalKey<FormState> formKey = GlobalKey<FormState>();

bool validForm(){
  return formKey.currentState!.validate();
}

}
