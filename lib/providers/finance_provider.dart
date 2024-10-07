

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/finance.dart';
import 'package:web_dashboard/models/http/finance_response.dart';


class FinanceProvider extends ChangeNotifier {

  Finance? finance;

  List <Finance> finances = [];
  bool isLoading = true;


  FinanceProvider (){
    getFinance();
  }

 getFinance() async {
  final resp = await CafeApi.httpGet('/finance');
  final financeResp = FinanceResponse.fromMap(resp);
  finances = [... financeResp.finances];
  isLoading = false;
  notifyListeners();
}

 Future<Finance?> getFinanceById(String id) async {

  try {
  final resp = await CafeApi.httpGet('/finance/$id');
  final finance = Finance.fromMap(resp);
  return finance;

  } catch (e) {
    return null;
  }
}

void refreshFinance ( Finance newFinance) {

  finances = finances.map(
    (finance){
      if (finance.id == newFinance.id) {
        finance = newFinance;
      }
      return finance;
    }
  ).toList();

  notifyListeners();
  
}


}
