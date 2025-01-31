

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/http/payment_response.dart';
import 'package:web_dashboard/models/payment.dart';

class PaymentsProvider extends ChangeNotifier {

  List<Payment> payments = [];
  bool isLoading = true;

  PaymentsProvider() {
    getPaginetedPayments();
  }

  getPaginetedPayments() async {

    final resp = await CafeApi.httpGet('/payment');
    final paymentResp = PaymentResponse.fromMap(resp);
    payments = [...paymentResp.payments];
    
    isLoading = false;
    notifyListeners();
  }

      Future<void> getPaymentByRepresentative(String usuarioZona) async {
    try {  
      final resp = await CafeApi.httpGet('/payment/usuarioZona/$usuarioZona');
      
      if (resp is Map<String, dynamic> && resp.containsKey('payments') && (resp['payments'] as List).isEmpty) {
      throw Exception('Sales Representative With No Orders');
    }
     payments = (resp['payments'] as List).map((orden) => Payment.fromMap(orden)).toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }

    Future<Payment> getPaymentsByID( String id ) async {

      try {
        final resp = await CafeApi.httpGet('/payment/$id');
        final payment = Payment.fromMap(resp);
        return payment;
      } catch (e) {
        rethrow;
      }
    
  }


}