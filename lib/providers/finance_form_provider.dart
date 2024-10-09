import 'package:flutter/material.dart';
import 'package:web_dashboard/models/finance.dart';

class FinanceFormProvider extends ChangeNotifier {

  Finance? finance;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _validForm() {
    return formKey.currentState!.validate();
  }

  updateTax(){
    if(!_validForm()) return;

    print('Info a postear');
    print (finance!.tax1.first.percentage);
    print (finance!.tax1.first.name);
  }

}