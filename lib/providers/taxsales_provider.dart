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

  getTaxSaleById(String id) async {

    try {
      final resp = await CafeApi.httpGet('/taxsales/$id');
      final taxsale = TaxSales.fromMap(resp);
      return taxsale;
    } catch (e) {
       return null;
    }
  
  }

    Future deleteTaxSales (String id) async {
    try{
      await CafeApi.delete('/taxsales/$id',{});
      taxsales.removeWhere((taxsales) => taxsales.id == id);
      notifyListeners();
    } catch (e){
      throw ' Error to Delete the Product ';
    }
  }

  void refreshTaxSales( TaxSales newTaxSales){
    
  
  taxsales = taxsales.map(
    (tax){
      if (tax.id == newTaxSales.id) {
        tax = newTaxSales;
      }
      return tax;
    }
  ).toList();

    notifyListeners();
  }


}