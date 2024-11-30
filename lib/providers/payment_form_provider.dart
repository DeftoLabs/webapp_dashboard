

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/payment.dart';

class PaymentFormProvider extends ChangeNotifier {

  Payment? payment;
  List<Payment> payments = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validForm() {
    return formKey.currentState!.validate();
  }

    Future<String?> newCreatePayment({
    required String   bancoemisor,
    required String   bancoreceptor,
    required String   numeroref,
    required double   monto,
    required String   currencySymbol,
    required String   cliente,
    required String   type,
    required DateTime fechapago,
    required String   comentarios,
  }) async {
    final data = {
      'bancoemisor': bancoemisor,
      'bancoreceptor': bancoreceptor,
      'numeroref': numeroref,
      'monto': monto,
      'currencySymbol': currencySymbol,
      'cliente': cliente,
      'type': type,
      'fechapago': fechapago.toIso8601String(),
      'comentarios': comentarios,
    };
    
    try {
      final json = await CafeApi.post('/payment', data);     
      final newPayment = Payment.fromMap(json);
      payments.add(newPayment);
      notifyListeners();
      return null;
    } catch (e) {
        throw 'Error creating Payment on Provider: $e'; 
    }
  }
}