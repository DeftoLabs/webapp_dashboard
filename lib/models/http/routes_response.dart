import 'dart:convert';

import '../zona.dart';

class RoutesResponse {
    int total;
    List<Zona> zonas;

    RoutesResponse({
        required this.total,
        required this.zonas,
    });

    factory RoutesResponse.fromJson(String str) => RoutesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RoutesResponse.fromMap(Map<String, dynamic> json) => RoutesResponse(
        total: json["total"],
        zonas: List<Zona>.from(json["zonas"].map((x) => Zona.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "zonas": List<dynamic>.from(zonas.map((x) => x.toJson())),
    };
}
