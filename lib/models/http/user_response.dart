
import 'dart:convert';

import 'package:web_dashboard/models/usuaro.dart';

class UsersResponse {
    int total;
    List<Usuario> usuarios;

    UsersResponse({
        required this.total,
        required this.usuarios,
    });

    factory UsersResponse.fromJson(String str) => UsersResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UsersResponse.fromMap(Map<String, dynamic> json) => UsersResponse(
        total: json["total"],
        usuarios: List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromJson(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
    };
}