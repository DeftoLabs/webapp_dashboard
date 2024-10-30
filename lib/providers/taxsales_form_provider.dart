import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/taxsales.dart';
import 'package:web_dashboard/services/notification_services.dart';

class TaxSalesFormProvider extends ChangeNotifier {

  TaxSales? taxsale;
  List<TaxSales> taxsales = [];
  bool isLoading = true;
  late GlobalKey<FormState> formKey;

  bool validForm () {
    return formKey.currentState!.validate();
  }

  copyTaxSalesWith({
    String? id,
    double? taxnumber,
    String? taxname,
  }){
    taxsale = TaxSales(
       id: id ?? taxsale!.id,
      taxnumber: taxnumber ?? taxsale!.taxnumber, 
      taxname: taxname ?? taxsale!.taxname
      );
      notifyListeners();
  }

  Future updateTaxSales() async {
     if(!validForm()) return false;

     final data = {
      'taxname': taxsale!.taxname,
      'taxnumber': taxsale!.taxnumber,
     };

      try {
        await CafeApi.put('/taxsales/${taxsale!.id}', data);
        return true;
      } catch (e) {
        NotificationService.showSnackBarError('Error: $e'); 
        return false;
      }
  }
   Future newTaxSales (
          String taxname, 
          double taxnumber, 
          ) async {

    final data = {
      'taxname':     taxname,
      'taxnumber':   taxnumber,
    };
    try{
      final json = await CafeApi.post('/taxsales', data);
      final newTaxSales = TaxSales.fromMap(json);
      taxsales.add(newTaxSales);
      notifyListeners();
    } catch (e){
      throw ' Error to create the Tax Sales ';
    }
  }
}