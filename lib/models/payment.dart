import 'dart:convert';

import 'package:web_dashboard/models/bank.dart';
import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/models/ordenes.dart';
import 'package:web_dashboard/models/usuario.dart';
import 'package:web_dashboard/models/zona.dart';

class Payment {
  String id;
  bool? estado;
  List<Ordenes> ordenes;
  DateTime fechapago;
  String bancoemisor;
  Bank bancoreceptor;
  String numeroref;
  double monto;
  String currencySymbol;
  Usuario usuario;
  Customer cliente; 
  String numerocontrol;
  String type;
  String comentarios;
  String? img;
  DateTime fechacreacion;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Payment({
    required this.id,
    this.estado,
    required this.ordenes,
    required this.fechapago,
    required this.bancoemisor,
    required this.bancoreceptor,
    required this.numeroref,
    required this.monto,
    required this.currencySymbol,
    required this.usuario,
    required this.cliente,
    required this.numerocontrol,
    required this.type,
    required this.comentarios,
     this.img,
    required this.fechacreacion,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Payment.fromJson(String str) => Payment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Payment.fromMap(Map<String, dynamic> json) {
    return Payment(
    id: json["_id"] ?? '',
    estado: json["estado"] ?? false,
    ordenes: json["ordenes"] != null
          ? List<Ordenes>.from(json["ordenes"].map((x) => Ordenes.fromMap(x)))
          : [],
    fechapago: DateTime.tryParse(json["fechapago"] ?? '') ?? DateTime.now(),
    bancoemisor: json["bancoemisor"] ?? '',
    bancoreceptor: json["bancoreceptor"] is Map<String, dynamic>
    ? Bank.fromMap(json["bancoreceptor"])
    : Bank(
        id: json["bancoreceptor"] ?? '',
        nombre: '',
        numero: '',
        tipo: '',
        currencyName: '',
        currencySymbol: '',
        titular: '',
        idtitular: '',
        comentarios: '',
      ),
      numeroref: json["numeroref"] ?? '',
      monto: (json["monto"] ?? 0.0).toDouble(),
      currencySymbol: json["currencySymbol"] ?? '',
      usuario: json["usuario"] is Map<String, dynamic>
    ? Usuario.fromMap(json["usuario"])
    : Usuario(
        uid: json["usuario"] ?? '', 
        rol: '', 
        estado: true, 
        google: true, 
        nombre: '', 
        correo: '', 
        phone: '', 
        zone: '',
      ),
      cliente: json["cliente"] is Map<String, dynamic>
    ? Customer.fromMap(json["cliente"])
    : Customer(
      id: '', 
      estado: true, 
      codigo: '', 
      idfiscal: '', 
      nombre: '', 
      razons: '', 
      sucursal: '',
      direccion: '', 
      correo: '', 
      telefono: '', 
      web: '', 
      contacto: '', 
      credito: 0, 
      note: '',
      usuario: User(
        id: '', 
        nombre: ''), 
      zona: Zona(
        id: '', 
        codigo: '', 
        nombrezona: '', 
        descripcion: '')
      ),
      numerocontrol: json["numerocontrol"] ?? '',
      type: json.containsKey("payment") && json["payment"] != null
      ? json["payment"]["type"] ?? ''
      : json["type"] ?? '',
      comentarios: json["comentarios"] ?? '',
      img: json["img"] ?? '',
      fechacreacion: DateTime.tryParse(json["fechacreacion"] ?? '') ?? DateTime.now(),
      createdAt: DateTime.tryParse(json["createdAt"] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? '') ?? DateTime.now(),
      v: json["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
        "_id": id,
        "estado": estado,
        "ordenes": List<dynamic>.from(ordenes.map((x) => x.toMap())),
        "fechapago": fechapago.toIso8601String(),
        "bancoemisor": bancoemisor,
        "bancoreceptor": bancoreceptor.toMap(),
        "numeroref": numeroref,
        "monto": monto,
        "currencySymbol": currencySymbol,
        "usuario": usuario.toMap(),
        "cliente": cliente.toMap(),
        "numerocontrol": numerocontrol,
        "type": type,
        "comentarios": comentarios,
        "img": img,
        "fechacreacion": fechacreacion.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

