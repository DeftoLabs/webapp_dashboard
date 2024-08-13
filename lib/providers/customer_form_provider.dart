

import 'package:flutter/material.dart';
import 'package:web_dashboard/models/customers.dart';

class CustomerFormProvider extends ChangeNotifier {

  Customer? customer;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validForm(){
    return formKey.currentState!.validate();
  }
}