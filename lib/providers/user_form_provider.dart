import 'package:flutter/material.dart';
import 'package:web_dashboard/models/usuaro.dart';

class UserFormProvider extends ChangeNotifier {

Usuario? user;
GlobalKey<FormState> formKey = GlobalKey<FormState>();

bool validForm() {
  return formKey.currentState!.validate();
}

}