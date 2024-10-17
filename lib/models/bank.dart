import 'dart:convert';

class Bank {
    bool? estado;
    String id;
    String nombre;
    String numero;
    String tipo;
    String currencyName;
    String currencySymbol;
    String titular;
    String idtitular;
    String comentarios;



    Bank({
        this.estado,
        required this.id,
        required this.nombre,
        required this.numero,
        required this.tipo,
        required this.currencyName,
        required this.currencySymbol,
        required this.titular,
        required this.idtitular,
        required this.comentarios,

    });

    factory Bank.fromJson(String str) => Bank.fromMap(json.decode(str));

    String toJson() => json.encode(toJson());

    factory Bank.fromMap(Map<String, dynamic> json) => Bank(
        estado: json["estado"] ?? '',
        id: json["_id"] ?? '',
        nombre: json["nombre"] ?? '',
        numero: json["numero"] ?? '',
        tipo: json["tipo"] ?? '',
        currencyName: json ["currencyName"] ?? '',
        currencySymbol: json ["currencySymbol"] ?? '',
        titular: json["titular"] ?? '',
        idtitular: json["idtitular"] ?? '',
        comentarios: json["comentarios"] ?? '',

    );

    Map<String, dynamic> toMap() => {
        "estado": estado,
        "_id": id,
        "nombre": nombre,
        "numero": numero,
        "tipo": tipo,
        "currencyName": currencyName,
        "currencySymbol": currencySymbol,
        "titular": titular,
        "idtitular": idtitular,
        "comentarios": comentarios,

    };
}
