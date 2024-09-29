import 'dart:convert';

import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/models/products.dart';
import 'package:web_dashboard/models/ruta.dart';
import 'package:web_dashboard/models/usuario.dart';

class Ordenes {
    Location? location;
    bool estado;
    List<Customer> clientes;
    List<Ruta> ruta;
    List<String> perfil;
    String status;
    String id;
    String control;
    List<Producto> productos;
    double subtotal;
    double tax;
    double total;
    DateTime fechaentrega;
    Usuario usuario;
    String tipo;
    DateTime fechacreado;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Ordenes({
        required this.location,
        required this.estado,
        required this.clientes,
        required this.ruta,
        required this.perfil,
        required this.status,
        required this.id,
        required this.control,
        required this.productos,
        required this.subtotal,
        required this.tax,
        required this.total,
        required this.fechaentrega,
        required this.usuario,
        required this.tipo,
        required this.fechacreado,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Ordenes.fromJson(String str) => Ordenes.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());

factory Ordenes.fromMap(Map<String, dynamic> json) {// Verifica qué estás recibiendo
  return Ordenes(
    location: json["location"] != null ? Location.fromMap(json["location"]) : null,
    estado: json["estado"] ?? false,
    clientes: json["clientes"] != null 
      ? List<Customer>.from(json["clientes"].map((x) => Customer.fromMap(x)))
      : [],
     ruta: json["ruta"] != null 
        ? List<Ruta>.from(json["ruta"].map((x) => Ruta.fromMap(x))) // Convierte en una lista
        : [],
    perfil: json["perfil"] != null 
      ? List<String>.from(json["perfil"].map((x) => x.toString()))
      : [],
    status: json["status"] ?? '', 
    id: json["_id"] ?? '', 
    control: json["control"] ?? '', 
    productos: json["productos"] != null 
      ? List<Producto>.from(json["productos"].map((x) => Producto.fromMap(x)))
      : [],
    subtotal: json["subtotal"] is String ? double.tryParse(json["subtotal"]) ?? 0.0 : (json["subtotal"] ?? 0.0),
    tax: json["tax"] is String ? double.tryParse(json["tax"]) ?? 0.0 : (json["tax"] ?? 0.0),
    total: json["total"] is String ? double.tryParse(json["total"]) ?? 0.0 : (json["total"] ?? 0.0),    
    fechaentrega: json["fechaentrega"] != null ? DateTime.parse(json["fechaentrega"]) : DateTime.now(),
    usuario: json["usuario"] != null ? Usuario.fromMap(json["usuario"]) : Usuario(uid: '', nombre: '', rol: '', estado:true, google:true, correo:'', phone:'', zone:''),
    tipo: json["tipo"] ?? '', 
    fechacreado: json["fechacreado"] != null ? DateTime.parse(json["fechacreado"]) : DateTime.now(), 
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(), 
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(), 
    v: json["__v"] ?? 0, 
  );
}


    Map<String, dynamic> toMap() => {
        "location": location?.toMap(),
        "estado": estado,
        "clientes": List<dynamic>.from(clientes.map((x) => x.toMap())),
        "ruta": List<dynamic>.from(ruta.map((x) => x.toJson())),
        "perfil": List<dynamic>.from(perfil.map((x) => x)),
        "status": status,
        "_id": id,
        "control": control,
        "productos": List<dynamic>.from(productos.map((x) => x.toMap())),
        "subtotal": subtotal,
        "tax": tax,
        "total":total,
        "fechaentrega": fechaentrega.toIso8601String(),
        "usuario": usuario.toMap(),
        "tipo": tipo,
        "fechacreado": fechacreado.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}