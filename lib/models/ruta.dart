

import 'dart:convert';

import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/models/usuario.dart';

class Ruta {
    String id;
    bool estado;
    String codigoRuta;
    String nombreRuta;
    String zona;
    String diasemana;
    List<Customer> clientes;
    Usuario usuarioZona;
    String? img;



    Ruta({
        required this.id,
        required this.estado,
        required this.codigoRuta,
        required this.nombreRuta,
        required this.zona,
        required this.diasemana,
        required this.clientes,
        required this.usuarioZona,
        this.img,

    });

    factory Ruta.fromJson(String str) => Ruta.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());

    factory Ruta.fromMap(Map<String, dynamic> json) {

      return Ruta(
        estado: json["estado"] ?? false,
        id: json["_id"] ?? '',
        codigoRuta: json["codigo_ruta"] ?? '',
        nombreRuta: json["nombre_ruta"] ?? '',
        zona: json["zona"] ?? '',
        diasemana: json["diasemana"] ?? '',
        clientes: json["clientes"] != null 
            ? List<Customer>.from(json["clientes"].map((x) => Customer.fromMap(x)))
            : [],
        usuarioZona: json["usuario_zona"] != null 
        ? Usuario.fromMap(json["usuario_zona"]) 
        : Usuario(rol: '', estado: false, google: false, nombre: '', correo: '', uid: '', phone: '', zone: ''),
   
        img: json["img"],

    );
    } 

    Map<String, dynamic> toMap() => {
        "estado": estado,
        "_id": id,
        "codigo_ruta": codigoRuta,
        "nombre_ruta": nombreRuta,
        "zona": zona,
        "diasemana": diasemana,
        "clientes": List<dynamic>.from(clientes.map((x) => x.toMap())),
        "usuario_zona": usuarioZona,
        "img": img,

    };
}
