import 'package:flutter/material.dart';
import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/models/ordenes.dart';
import 'package:web_dashboard/models/products.dart';
import 'package:web_dashboard/models/ruta.dart';
import 'package:web_dashboard/models/usuario.dart';

class OrdenFormProvider extends ChangeNotifier {

  Ordenes? orden;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  copyOrdeneswith({
    String? id,
    Location? location,
    bool? estado,
    List<Customer>? clientes,
    List<Ruta>? ruta,
    List<String>? perfil,
    String? status,
    String? control,
    List<Producto>? productos,
    double? subtotal,
    double? tax,
    double? total,
    DateTime? fechaentrega,
    Usuario? usuario,
    String? tipo,
    String? comentario,
    String? comentarioRevision,
    DateTime? fechacreado,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    orden = Ordenes (
    id: id ?? orden!.id,
    location: location ?? orden!.location,
    estado: estado ?? orden!.estado,
    clientes: clientes ?? orden!.clientes,
    ruta: ruta ?? orden!.ruta,
    perfil: perfil ?? orden!.perfil,
    status: status ?? orden!.status,
    control: control ?? orden!.control,
    productos: productos ?? orden!.productos,
    subtotal: subtotal ?? orden!.subtotal,
    tax: tax ?? orden!.tax,
    total: total ?? orden!.total,
    fechaentrega: fechaentrega ?? orden!.fechaentrega,
    usuario: usuario ?? orden!.usuario,
    tipo: tipo ?? orden!.tipo,
    comentario: comentario ?? orden!.comentario,
    comentarioRevision: comentarioRevision ?? orden!.comentarioRevision,
    fechacreado: fechacreado ?? orden!.fechacreado,
    createdAt: createdAt ?? orden!.createdAt,
    updatedAt: updatedAt ?? orden!.updatedAt,
    );
    notifyListeners();
  }

  bool validForm() {
    return formKey.currentState!.validate();
  }

  updateOrder () {
    if (!validForm()) return;


  } 
}