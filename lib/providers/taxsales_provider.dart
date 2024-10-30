import 'package:flutter/material.dart';

import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/http/taxsales_response.dart';
import 'package:web_dashboard/models/taxsales.dart';

class TaxSalesProvider extends ChangeNotifier {

  List <TaxSales> taxsales = [];
  bool isLoading = true;

  TaxSalesProvider() {
    getPaginatedTax();
  }

  getPaginatedTax() async {
    final resp =  await CafeApi.httpGet('/taxsales');
    final taxsalesResp = TaxSalesResponse.fromMap(resp);

    taxsales = [... taxsalesResp.taxsales];
    
    isLoading = false;
    notifyListeners();
  }


}