import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/bank.dart';
import 'package:web_dashboard/models/http/bank_response.dart';

class BankProvider extends ChangeNotifier {

  List<Bank> banks= [];
  bool isLoading = true;

  BankProvider() {
    getPaginatedBank();
  }

  getPaginatedBank () async {
    final resp = await CafeApi.httpGet('/bankaccount');
    final bankResp = BankResponse.fromMap(resp);
    banks = [... bankResp.banks];
    isLoading = false;
    notifyListeners();

  }


}