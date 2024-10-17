import 'package:flutter/material.dart';
import 'package:web_dashboard/models/bank.dart';

class BankFormProvider extends ChangeNotifier {

  Bank? bank;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  copyBankwith ({
    String? nombre,
    String? numero,
    String? tipo,
    String? currencyName,
    String? currencySymbol,
    String? titular,
    String? idtitular,
    String? comentarios,    
  }) {
    bank = Bank (
    nombre: nombre ?? bank!.nombre,
    numero: numero ?? bank!.numero,
    tipo: tipo ?? bank!.tipo,
    currencyName: currencyName ?? bank!.currencyName, 
    currencySymbol: currencySymbol ?? bank!.currencySymbol,
    titular: titular ?? bank!.titular,
    idtitular: idtitular ?? bank!.idtitular,
    comentarios: comentarios ?? bank!.comentarios,
    );
    notifyListeners();
  }

  bool validForm() {
    return formKey.currentState!.validate();
  }

  updateBank (){
    if (!validForm()) return;


  }


}