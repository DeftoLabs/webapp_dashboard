

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/ordenes.dart';

class OrdenNewFormProvider extends ChangeNotifier {

  Ordenes? orden;
  List<Ordenes> ordenes = [];
  final List<String> _tipo = ['INVOICE', 'NOTE', 'OTHER'];
  List<String> get tipo => _tipo; 

  late GlobalKey<FormState> formKey;

  bool validForm() {
    return formKey.currentState!.validate();
  }

    Future<String?> createOrden({
    required String cliente,
    required String ruta,
    required List<Map<String, dynamic>> productos,
    required DateTime fechaentrega,
    required String tipo,
    String? comentario,

  }) async {
     final fechaFormateada = '${fechaentrega.toUtc().toIso8601String().split('.').first}Z';
       final data = {
      'clientes': [cliente],
      'ruta': [ruta], 
      'productos': productos,
      'fechaentrega': fechaFormateada,
      'tipo': tipo,
    };
    if (comentario != null) {
      data['comentario'] = comentario;
    }
    print('Datos enviados: $data');
    try {
      final json = await CafeApi.postJson('/ordens', data);   
      final newOrden = Ordenes.fromMap(json);
      ordenes.add(newOrden);
      notifyListeners();
    } catch (e) {
      print(e);
        throw 'Error creating new Orden: $e'; 
        
    }
    return null;
  }
}