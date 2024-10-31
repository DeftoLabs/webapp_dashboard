import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/taxoperation.dart';
import 'package:web_dashboard/services/notification_services.dart';

class TaxOperationFormProvider extends ChangeNotifier {

  TaxOperation? taxoperation;
  List<TaxOperation> taxoperations = [];
  bool isLoading = true;
  late GlobalKey<FormState> formKey;

  bool validForm () {
    return formKey.currentState!.validate();
  }

  copyTaxOperationWith({
    String? id,
    double? taxnumber,
    String? taxname,
  }){
    taxoperation = TaxOperation(
       id: id ?? taxoperation!.id,
      taxnumber: taxnumber ?? taxoperation!.taxnumber, 
      taxname: taxname ?? taxoperation!.taxname
      );
      notifyListeners();
  }

  Future updateTaxOperation() async {
     if(!validForm()) return false;

     final data = {
      'taxname': taxoperation!.taxname,
      'taxnumber': taxoperation!.taxnumber,
     };

      try {
        await CafeApi.put('/taxoperation/${taxoperation!.id}', data);
        return true;
      } catch (e) {
        NotificationService.showSnackBarError('Error: $e'); 
        return false;
      }
  }
   Future newTaxOperation (
          String taxname, 
          double taxnumber, 
          ) async {//

    final data = {
      'taxname':     taxname,
      'taxnumber':   taxnumber,
    };
    try{
      final json = await CafeApi.post('/taxoperation', data);
      final newTaxOperation = TaxOperation.fromMap(json);
      taxoperations.add(newTaxOperation);
      notifyListeners();
    } catch (e){
      throw ' Error to create the Tax Sales ';
    }
  }
}