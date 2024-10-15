import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/finance.dart';
import 'package:web_dashboard/services/notification_services.dart';

class FinanceFormProvider extends ChangeNotifier {

  Finance? finance;
  List<Finance> finances = [];
  bool isLoading = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validForm(){
  return formKey.currentState!.validate();
}

   copyFinanceWith({
    String? id,
    String? mainCurrencyname,
    String? mainCurrencysymbol,
    String? secondCurrencyname,
    String? secondCurrencysymbol,
    String? tax1name,
    double? tax1number,
    String? tax2name,
    double? tax2number,
    String? tax3name,
    double? tax3number,
    String? tax4name,
    double? tax4number,
  }) {
    finance =  Finance(
      id: id ?? finance!.id,
      mainCurrencyname: mainCurrencyname ?? finance!.mainCurrencyname,
      mainCurrencysymbol: mainCurrencysymbol ?? finance!.mainCurrencysymbol,
      secondCurrencyname: secondCurrencyname ?? finance!.secondCurrencyname,
      secondCurrencysymbol: secondCurrencysymbol ?? finance!.secondCurrencysymbol,
      tax1name  : tax1name   ?? finance!.tax1name,
      tax1number: tax1number ?? finance!.tax1number,
      tax2name  : tax2name   ?? finance!.tax2name,
      tax2number: tax2number ?? finance!.tax2number,
      tax3name  : tax3name   ?? finance!.tax3name,
      tax3number: tax3number ?? finance!.tax3number,
      tax4name  : tax4name   ?? finance!.tax4name,
      tax4number: tax4number ?? finance!.tax4number,
      
    );
    notifyListeners();
  }


Future updateTax() async {

  if(!validForm()) return; 
  
  final data = {
    'tax1name': finance!.tax1name,
    'tax1number' : finance!.tax1number,
    'tax2name': finance!.tax2name,
    'tax2number' : finance!.tax2number,
    'tax3name': finance!.tax3name,
    'tax3number' : finance!.tax3number,
  }; 
  try {
    await CafeApi.put('/finance/${finance!.id}', data);
    return true;
    
  } catch (e) {
    NotificationService.showSnackBarError('Error: $e'); 
    return false;
  }
}

  void setMainCurrency({required String name, required String symbol}) {
    copyFinanceWith(
      mainCurrencyname: name,
      mainCurrencysymbol: symbol,
    );
  }
    void setSecondaryCurrency({required String name, required String symbol}) {
    copyFinanceWith(
      secondCurrencyname: name,
      secondCurrencysymbol: symbol,
    );
  }

Future updateCurrency() async {

  if(!validForm()) return; 
  
  final data = {
    'mainCurrencyname': finance!.mainCurrencyname,
    'mainCurrencysymbol' : finance!.mainCurrencysymbol,
    'secondCurrencyname': finance!.secondCurrencyname,
    'secondCurrencysymbol' : finance!.secondCurrencysymbol,
  }; 
  try {
    await CafeApi.put('/finance/${finance!.id}', data);
    return true;
    
  } catch (e) {
    NotificationService.showSnackBarError('Error: $e'); 
    return false;
  }
}

 Future newFinance (
          String mainCurrencyname, 
          String mainCurrencysymbol, 
          String secondCurrencyname,
          String secondCurrencysymbol,
          String tax1name,
          double tax1number,
          String tax2name,
          double tax2number,
          String tax3name,
          double tax3number) async {

    final data = {
      'mainCurrencyname':     mainCurrencyname,
      'mainCurrencysymbol':   mainCurrencysymbol,
      'secondCurrencyname':   secondCurrencyname,
      'secondCurrencysymbol': secondCurrencysymbol,
      'tax1name'  : tax1name,
      'tax1number': tax1number,
      'tax2name'  : tax2name,
      'tax2number': tax2number,
      'tax3name'  : tax3name,
      'tax3number': tax3number,
    };
    try{
      final json = await CafeApi.post('/finance', data);
      final newFinance = Finance.fromMap(json);
      finances.add(newFinance);
      notifyListeners();
    } catch (e){
      throw ' Error to create the Zone ';
    }
  }

}