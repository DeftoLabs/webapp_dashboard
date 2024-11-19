import 'package:flutter/material.dart';
import 'package:web_dashboard/api/cafeapi.dart';
import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/models/ordenes.dart';
import 'package:web_dashboard/models/products.dart';
import 'package:web_dashboard/models/ruta.dart';
import 'package:web_dashboard/models/taxsales.dart';
import 'package:web_dashboard/models/usuario.dart';

class OrdenFormProvider extends ChangeNotifier {
  Ordenes? orden;

  late GlobalKey<FormState> formKey;

  copyOrdenesWith({
    String? id,
    Location? location,
    bool? estado,
    List<Customer>? clientes,
    List<Ruta>? ruta,
    List<TaxSales>? taxsales,
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
    double? totalitem,
    String? comentario,
    String? comentarioRevision,
    DateTime? fechacreado,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? productId, // ID del producto que se debe de actualizar
    double? cantidad,
    double? precio,
    String? descripcion,
  }) {
    orden = Ordenes(
      id: id ?? orden!.id,
      location: location ?? orden!.location,
      estado: estado ?? orden!.estado,
      clientes: clientes ?? orden!.clientes,
      ruta: ruta ?? orden!.ruta,
      perfil: perfil ?? orden!.perfil,
      status: status ?? status ?? orden!.status,
      control: control ?? orden!.control,
      productos: productos ?? orden!.productos.map((producto) {
      // Verifica si este es el producto que se debe actualizar
      if (producto.id == productId) {
        return Producto(
          id: producto.id,
          estado: producto.estado,
          usuario: producto.usuario,
          categoria: producto.categoria,
          taxsales: producto.taxsales,
          tax:producto.tax,
          disponible: producto.disponible,
          stock: producto.stock,
          nombre: producto.nombre,
          descripcion: descripcion ?? producto.descripcion, // Usa la descripción proporcionada o la existente
          cantidad: cantidad ?? producto.cantidad, // Usa la cantidad proporcionada o la existente
          precio: precio ?? producto.precio, // Usa el precio proporcionado o el existente
          unid: producto.unid,
          precio1: producto.precio1,
          precio2: producto.precio2,
          precio3: producto.precio3,
          precio4: producto.precio4,
          precio5: producto.precio5,
        );
      } else {
        // Si no es el producto que se desea actualizar, regresa el producto sin cambios
        return producto;
      }
    }).toList(),
      subtotal: subtotal ?? orden!.subtotal,
      tax: tax ?? orden!.tax,
      total: total ?? orden!.total,
      fechaentrega: fechaentrega ?? orden!.fechaentrega,
      usuario: usuario ?? orden!.usuario,
      tipo: tipo ?? orden!.tipo, 
      totalitem: totalitem ?? orden!.totalitem,
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

  Future updateOrder(DateTime? newDateDelivery) async {
    if (!validForm()) return false;

     // Lógica para actualizar el status y el tipo en base a las reglas de negocio
    String? newStatus = orden!.status;
    String? newTipo = orden!.tipo;

    if (orden!.status == 'ORDER') {
      newStatus = 'APPROVED';
    } else if (orden!.status == 'APPROVED') {
      newStatus = orden!.tipo; 
    }
  

    final data = {
      "productos": orden!.productos.map((producto) {
        return {
          "producto": producto.id,
          "cantidad": producto.cantidad,
          "precio": producto.precio,
        };
      }).toList(),
      "status": newStatus,
      "tipo": newTipo,
      "comentarioRevision": orden!.comentarioRevision,
      "fechaentrega": newDateDelivery?.toIso8601String(),
    };
    try {
      await CafeApi.putJson('/ordens/${orden!.id}', data);
      return true;
    } catch (e) {
      return false;
    }
  }

Future<bool> deleteProductByOrder(String orderId, String productId) async {
  try {
    final response = await CafeApi.put('/ordens/$orderId/productos/$productId',
      {},
    );
    if (response != null) {
      return true;
    } else {
      return false; 
    }
  } catch (e) {
    return false;
  }
}

Future<bool> addProductByOrder(String orderId, Map<String, dynamic> productData) async {
  try {
    final response = await CafeApi.put(
      '/ordens/$orderId/productos',
      productData, // Enviamos el cuerpo como JSON.
    );
    if (response != null) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}





}
