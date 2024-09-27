import 'dart:convert';

import 'package:web_dashboard/models/ordenes.dart';

class OrdenesResponse {
    int total;
    List<Ordenes> ordenes;

    OrdenesResponse({
        required this.total,
        required this.ordenes,
    });

    factory OrdenesResponse.fromJson(String str) => OrdenesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OrdenesResponse.fromMap(Map<String, dynamic> json) => OrdenesResponse(
    total: json["total"],
    ordenes: List<Ordenes>.from(json["ordenes"].map((x) => Ordenes.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "ordenes": List<dynamic>.from(ordenes.map((x) => x.toMap())),
    };
}
