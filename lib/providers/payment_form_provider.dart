

import 'package:flutter/material.dart';
import 'package:web_dashboard/models/payment.dart';

class PaymentFormProvider extends ChangeNotifier {

  Payment? payment;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validForm() {
    return formKey.currentState!.validate();
  }
}