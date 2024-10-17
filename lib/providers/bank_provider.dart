import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/bank.dart';
import 'package:web_dashboard/models/http/bank_response.dart';

class BankProvider extends ChangeNotifier {

  List<Bank> banks= [];

  final List<String> _tipo = ['SAVING', 'CHECKING', 'CRIPTO'];
  List<String> get tipo => _tipo;
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

  Future <Bank?> getBankById (String id) async {

    try {
    final resp = await CafeApi.httpGet('/bankaccount/$id');
    final bank = Bank.fromMap(resp);
    return bank;
    } catch (e) {
      return null;
    }

  }


}