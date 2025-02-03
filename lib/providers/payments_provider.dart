

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/http/payment_response.dart';
import 'package:web_dashboard/models/payment.dart';

class PaymentsProvider extends ChangeNotifier {
  bool isLoading = true;
  bool isRequesting = false;
  List<Payment> payments = [];
  Completer<void>? _requestCompleter;



  PaymentsProvider() {
    getPaginetedPayments();
  }

  void clearPayments(){
    payments = [];
    notifyListeners();
  }

  getPaginetedPayments() async {

    final resp = await CafeApi.httpGet('/payment');
    final paymentResp = PaymentResponse.fromMap(resp);
    payments = [...paymentResp.payments];
    
    isLoading = false;
    notifyListeners();
  }

  Future<void> getPaymentByRepresentative(String usuarioZona) async {
    if (_requestCompleter != null && !_requestCompleter!.isCompleted) {
      // Si ya hay una petición en curso, esperamos a que termine
      return _requestCompleter!.future;
    }

    _requestCompleter = Completer<void>();

    try {
      isLoading = true;
      notifyListeners();

      final resp = await CafeApi.httpGet('/payment/usuarioZona/$usuarioZona');

      if (resp is Map<String, dynamic> && resp.containsKey('payments')) {
        List<Payment> newPayments = (resp['payments'] as List)
            .map((orden) => Payment.fromMap(orden))
            .toList();

        if (newPayments.isNotEmpty) {
          payments = List.from(newPayments);
        } else {
          payments.clear();
        }
      }

      _requestCompleter!.complete();
    } catch (e) {
      debugPrint('Error fetching payments: $e');
      _requestCompleter!.completeError(e);
    } finally {
      isLoading = false;
      notifyListeners();
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