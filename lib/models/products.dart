import 'dart:convert';

class Categoria {
    Categoria({
        required this.id,
        required this.nombre,
        required this.usuario,
    });

    String id;
    String nombre;
    User usuario;

    factory Categoria.fromJson(String str) => Categoria.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Categoria.fromMap(Map<String, dynamic> json) => Categoria(
        id: json["_id"],
        nombre: json["nombre"],
        usuario: User.fromMap(json["usuario"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
        "usuario": usuario.toMap(),
    };

  @override
  String toString() {
    return 'Categoria: $nombre';
  }
}

class User {
    User({
        required this.id,
        required this.nombre,
    });

    String id;
    String nombre;

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
    };
}
