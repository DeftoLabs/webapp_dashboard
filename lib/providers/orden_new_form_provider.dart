

import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/ordenes.dart';
import 'package:web_dashboard/models/usuario.dart';

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
    Location? location,
    required String cliente,
    required String ruta,
    required List<Map<String, dynamic>> productos,
    required DateTime fechaentrega,
    required String tipo,
    String? comentario,

  }) async {
    final data = {
      'location': location,
      'cliente': cliente,
      'ruta': ruta,
      'productos': productos,
      'fechaentrega': fechaentrega.toIso8601String(),
      'tipo': tipo,
      'comentario': comentario,
    };
    
    try {
      final json = await CafeApi.post('/ordens', data);     
      final newOrden = Ordenes.fromMap(json);
      ordenes.add(newOrden);
      notifyListeners();
    } catch (e) {
        throw 'Error creating new Orden: $e'; 
    }
    return null;
  }
}