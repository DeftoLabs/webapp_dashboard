

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/payment.dart';
import 'package:web_dashboard/services/notification_services.dart';

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
      return newPayment.id;
    } catch (e) {
        throw 'Error creating Payment on Provider: $e'; 
    }
  }

  Future uploadImage(String path, Uint8List bytes) async {
  try {
    final response = await CafeApi.uploadImage(path, bytes);
    final imageUrl = response['img']; 
    if (payment != null) {
      payment = payment!.copyWith(img: imageUrl); 
      notifyListeners();
    }
    NotificationService.showSnackBa('Image Uploaded Successfully');
    notifyListeners();
  } catch (e) {
    NotificationService.showSnackBarError('Failed to Upload Image, Try Again !!');
  }
}
}