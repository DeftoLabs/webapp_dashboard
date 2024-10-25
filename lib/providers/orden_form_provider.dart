import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/models/ordenes.dart';
import 'package:web_dashboard/models/products.dart';
import 'package:web_dashboard/models/ruta.dart';
import 'package:web_dashboard/models/usuario.dart';

class OrdenFormProvider extends ChangeNotifier {

  Ordenes? orden;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

copyOrdenesWith({
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
  double? cantidad,   // Añadir cantidad
  double? precio,     // Añadir precio
  String? descripcion // Añadir descripción
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
    productos: productos ?? orden!.productos.map((producto) {
      return Producto(
        id: producto.id,
        estado: producto.estado,
        usuario: producto.usuario,
        categoria: producto.categoria,
        disponible: producto.disponible,
        stock: producto.stock,
        nombre: producto.nombre,
        descripcion: descripcion ?? producto.descripcion, // Usar la descripción proporcionada o la existente
        cantidad: cantidad ?? producto.cantidad,          // Usar la cantidad proporcionada o la existente
        precio: precio ?? producto.precio,                // Usar el precio proporcionado o el existente
        unid: producto.unid,
        precio1: producto.precio1,
        precio2: producto.precio2,
        precio3: producto.precio3,
        precio4: producto.precio4,
        precio5: producto.precio5,
      );
    }).toList(),
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

  Future updateOrder() async {

    if (!validForm()) return false;

    final data = {
      'comentarioRevision': orden!.comentarioRevision,
    };

    try {
      await CafeApi.put('/ordens/${orden!.id}', data);
      return true;
      
    } catch (e) {
      return false;
      
    }

  } 
}