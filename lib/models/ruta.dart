import 'dart:convert';

import 'package:web_dashboard/models/customers.dart';
import 'package:web_dashboard/models/usuario.dart';

class Ruta {
    String? id;
    bool estado;
    String codigoRuta;
    String nombreRuta;
    String zona;
    String diasemana;
    List <Customer> clientes;
    Usuario usuarioZona;
    String? img;


    Ruta({
        this.id,
        required this.estado,
        required this.codigoRuta,
        required this.nombreRuta,
        required this.zona,
        required this.diasemana,
        required this.clientes,
        required this.usuarioZona,
        this.img,

    });

     factory Ruta.empty() {
      return Ruta(
        estado: false,
        codigoRuta: '',
        nombreRuta: '',
        zona: '',
        diasemana: '',
        clientes: [],
        usuarioZona: Usuario(
          rol: '',
          estado: false,
          google: false,
          nombre: '',
          correo: '',
          uid: '',
          phone: '',
          zone: ''
        ),
        img: null,
      );
    }

    factory Ruta.fromJson(String str) => Ruta.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());

    factory Ruta.fromMap(Map<String, dynamic> json) {

      return Ruta(
        estado: json["estado"] ?? false,
        id: json["_id"] ?? '',
        codigoRuta: json["codigoRuta"] ?? '',
        nombreRuta: json["nombreRuta"] ?? '',
        zona: json["zona"] ?? '',
        diasemana: json["diasemana"] ?? '',
        clientes: json["clientes"] != null 
            ? List<Customer>.from(json["clientes"].map((x) => Customer.fromMap(x)))
            : [],
        usuarioZona: json["usuarioZona"] != null 
        ? Usuario.fromMap(json["usuarioZona"]) 
        : Usuario(rol: '', estado: false, google: false, nombre: '', correo: '', uid: '', phone: '', zone: ''),
   
        img: json["img"] as String?,

    );
    } 

    Map<String, dynamic> toMap() => {
        "estado": estado,
        "_id": id,
        "codigoRuta": codigoRuta,
        "nombreRuta": nombreRuta,
        "zona": zona,
        "diasemana": diasemana,
        "clientes": List<dynamic>.from(clientes.map((x) => x.toMap())),
        "usuarioZona": usuarioZona.toMap(),
        "img": img,

    };
}
