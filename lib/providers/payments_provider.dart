

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
    _initializePayments();
  }

  void _initializePayments() async {
    await getPaginetedPayments();
  }

  void clearPayments() {
    payments.clear();
    notifyListeners();
  }

  Future<void> getPaginetedPayments() async {
    _setLoading(true); 
    try {
      final resp = await CafeApi.httpGet('/payment');
      final paymentResp = PaymentResponse.fromMap(resp);
      payments = List.from(paymentResp.payments);
    } catch (e) {
      debugPrint('Error fetching paginated payments: $e');
    } finally {
      _setLoading(false);  // Asegura que el loading se establece como falso una vez se complete la carga.
    }
  }

  Future<void> getPaymentByRepresentative(String usuarioZona) async {
    if (_requestCompleter != null && !_requestCompleter!.isCompleted) {
      return _requestCompleter!.future;
    }

    _requestCompleter = Completer<void>();
    _setLoading(true);

    try {
      final resp = await CafeApi.httpGet('/payment/usuarioZona/$usuarioZona');
      if (resp is Map<String, dynamic> && resp.containsKey('payments')) {
        payments = (resp['payments'] as List)
            .map((orden) => Payment.fromMap(orden))
            .toList();
      } else {
        payments.clear();
      }
      _requestCompleter!.complete();
    } catch (e) {
      debugPrint('Error fetching payments: $e');
      _requestCompleter!.completeError(e);
    } finally {
      _setLoading(false);
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

   void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }


}