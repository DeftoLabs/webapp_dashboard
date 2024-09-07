import 'dart:convert';

import 'package:web_dashboard/models/ruta.dart';


class RutaResponse {
    int total;
    List<Ruta> rutas;

    RutaResponse({
        required this.total,
        required this.rutas,
    });

    factory RutaResponse.fromJson(String str) => RutaResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RutaResponse.fromMap(Map<String, dynamic> json) => RutaResponse(
        total: json["total"],
        rutas: List<Ruta>.from(json["rutas"].map((x) => Ruta.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "rutas": List<dynamic>.from(rutas.map((x) => x.toMap())),
    };
}
