import 'package:flutter/material.dart';
import 'package:web_dashboard/models/ordenes.dart';

class OrdenFormProvider extends ChangeNotifier {

  Ordenes? orden;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validForm() {
    return formKey.currentState!.validate();
  }

}