import 'dart:convert';

import 'package:web_dashboard/models/zona.dart';

class Customer {
  String id;
  bool estado;
  String codigo;
  String idfiscal;
  String nombre;
  String razons;
  String sucursal;
  String direccion;
  String correo;
  String telefono;
  String web;
  String contacto;
  int credito;
  String note;
  User usuario;
  Zona zona;

  Customer({
    required this.id,
    required this.estado,
    required this.codigo,
    required this.idfiscal,
    required this.nombre,
    required this.razons,
    required this.sucursal,
    required this.direccion,
    required this.correo,
    required this.telefono,
    required this.web,
    required this.contacto,
    required this.credito,
    required this.note,
    required this.usuario,
    required this.zona,
  });

  factory Customer.fromMap(Map<String, dynamic> json) {
  
  return Customer(
    id: json["_id"] ?? '',
    estado: json["estado"] ?? false,
    codigo: json["codigo"] ?? '',
    idfiscal: json["idfiscal"] ?? '',
    nombre: json["nombre"] ?? 'N/A',
    razons: json["razons"] ?? '',
    sucursal: json["sucursal"] ?? 'N/A',
    direccion: json["direccion"] ?? '',
    correo: json["correo"] ?? '',
    telefono: json["telefono"] ?? '',
    web: json["web"] ?? 'N/A',
    contacto: json["contacto"] ?? '',
    credito: json["credito"] ?? 0,
    note: json["note"] ?? ' ',
    usuario: json["usuario"] != null ? User.fromMap(json["usuario"]) : User(id: '', nombre: 'Not Usuario'),
    zona: json["zona"] != null ? Zona.fromMap(json["zona"]) : Zona(id: '', codigo: '', nombrezona: '', descripcion: ''),
  );

  } 

  Map<String, dynamic> toMap() => {
    "_id": id,
    "estado": estado,
    "codigo": codigo,
    "idfiscal": idfiscal,
    "nombre": nombre,
    "razons": razons,
    "sucursal": sucursal,
    "direccion": direccion,
    "correo": correo,
    "telefono": telefono,
    "web": web,
    "contacto": contacto,
    "credito": credito,
    "note": note,
    "usuario": usuario.toMap(),
    "zone": zona.toMap(),
  };
}


class User {
  User({
    required this.id,
    required this.nombre,
  });

  String id;
  String nombre;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["_id"] ?? 'No id', 
    nombre: json["nombre"] ?? 'No Name',
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "nombre": nombre,
  };
}
