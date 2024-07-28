import 'dart:convert';

class Producto {
  Producto({
    required this.id,
    required this.nombre,
    required this.estado,
    required this.usuario,
    required this.precio,
    required this.categoria,
    this.descripcion,
    required this.disponible,
    this.img,
  });

    String id;
    String nombre;
    bool estado;
    User usuario;
    double precio;
    Categoria categoria;
    String? descripcion;
    bool disponible;
    String? img;

  factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Producto.fromMap(Map<String, dynamic> json) => Producto(
    id: json["_id"],
    nombre: json["nombre"],
    estado: json["estado"],
    usuario: User.fromMap(json["usuario"]),
    precio: json["precio"]?.toDouble() ?? 0.0,
    categoria: Categoria.fromMap(json["categoria"]),
    descripcion: json["descripcion"],
    disponible: json["disponible"] ?? true,
    img: json["img"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "nombre": nombre,
    "estado": estado,
    "usuario": usuario.toMap(),
    "precio": precio,
    "categoria": categoria.toMap(),
    "descripcion": descripcion,
    "disponible": disponible,
    "img": img,
  };

  @override
  String toString() {
    return 'Producto: $nombre, Precio: $precio, Disponible: $disponible';
  }
}


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
