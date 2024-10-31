import 'package:flutter/material.dart';

import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/http/taxoperation_response.dart';
import 'package:web_dashboard/models/taxoperation.dart';

class TaxOperationProvider extends ChangeNotifier {

  List <TaxOperation> taxoperation = [];
  bool isLoading = true;

  TaxOperationProvider() {
    getPaginatedTaxOperation();
  }

  getPaginatedTaxOperation() async {
    final resp =  await CafeApi.httpGet('/taxoperation');
    final taxoperationResp = TaxOperationResponse.fromMap(resp);

    taxoperation = [... taxoperationResp.taxoperation];
    
    isLoading = false;
    notifyListeners();
  }

  getTaxOperationById(String id) async {

    try {
      final resp = await CafeApi.httpGet('/taxoperation/$id');
      final taxoperation = TaxOperation.fromMap(resp);
      return taxoperation;
    } catch (e) {
       return null;
    }
  
  }

   Future deleteTaxOperation (String id) async {
   try{
     await CafeApi.delete('/taxoperation/$id',{});
     taxoperation.removeWhere((taxoperation) => taxoperation.id == id);
     notifyListeners();
   } catch (e){
     throw ' Error to Delete the Product ';
   }
 }
 void refreshTaxOperation( TaxOperation newTaxOperation){
   
 
 taxoperation = taxoperation.map(
   (tax){
     if (tax.id == newTaxOperation.id) {
       tax = newTaxOperation;
     }
     return tax;
   }
 ).toList();
   notifyListeners();
 }

}