import 'dart:convert';

import '../zona.dart';

class ZonesResponse {
    int total;
    List<Zona> zonas;

    ZonesResponse({
        required this.total,
        required this.zonas,
    });

    factory ZonesResponse.fromJson(String str) => ZonesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

factory ZonesResponse.fromMap(Map<String, dynamic> json) {
  return ZonesResponse(
    total: json["total"],
    zonas: List<Zona>.from(json["zonas"].map((x) => Zona.fromMap(x))),
  );
}

    Map<String, dynamic> toMap() => {
        "total": total,
        "zonas": List<dynamic>.from(zonas.map((x) => x.toJson())),
    };
}
