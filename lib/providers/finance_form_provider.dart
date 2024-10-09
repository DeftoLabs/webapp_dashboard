import 'package:flutter/material.dart';
import 'package:web_dashboard/models/finance.dart';

class FinanceFormProvider extends ChangeNotifier {

  Finance? finance;

  

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validForm() {
    return formKey.currentState!.validate();
  }

}