import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/bank.dart';

class BankFormProvider extends ChangeNotifier {

  Bank? bank;
  List<Bank> banks = [];

  late GlobalKey<FormState> formKey;

  copyBankwith ({
    String? id,
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
    id: id ?? bank!.id,
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


  Future updateBank () async {
    if (!validForm()) return false;

    final data= {
      'nombre': bank!.nombre,
      'numero': bank!.numero,
      'tipo': bank!.tipo,
      'currencySymbol': bank!.currencySymbol,
      'titular': bank!.titular,
      'idtitular': bank!.idtitular,
      'comentarios': bank!.comentarios,
    };
    try {
      await CafeApi.put('/bankaccount/${bank!.id}', data);
      return true;
    } catch (e) {
      return false;
    }
  }

   Future newBank (
        String nombre,
        String numero,
        String tipo,
        String currencySymbol,
        String titular,
        String idtitular,
        String comentarios,   
          ) async {

    final data = {
        'nombre'          : nombre,
        'numero'          : numero,
        'tipo'            : tipo,
        'currencySymbol'  : currencySymbol,
        'titular'         : titular,
        'idtitular'       : idtitular,
        'comentarios'     : comentarios,
    };
    try{
      final json = await CafeApi.post('/bankaccount', data);
      final newBank = Bank.fromMap(json);
      banks.add(newBank);
      notifyListeners();
    } catch (e){
      throw ' Error to create the Bank Account ';
    }
  }


}