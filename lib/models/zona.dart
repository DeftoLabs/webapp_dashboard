

import 'dart:convert';

class Zona {
  String id;
  String codigo;
  String nombrezona;
  String descripcion;

  Zona ({
  required this.id,
  required this.codigo,
  required this.nombrezona,
  required this.descripcion,
});

    factory Zona.fromJson(String str) => Zona.fromMap(json.decode(str));
      String toJson() => json.encode(toMap());
    
    factory Zona.fromMap(Map<String, dynamic> json) => Zona(

        id: json["_id"] ?? '',
        codigo: json["codigo"] ?? '',
        nombrezona: json ["nombrezona"] ?? '',
        descripcion: json["descripcion"] ?? '',
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "codigo": codigo,
        "nombrezona": nombrezona,
        "descripcion": descripcion,
    };
}

