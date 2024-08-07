import 'dart:convert';

class Producto {
  String id;
  String nombre;
  bool estado;
  User usuario;
  double precio;
  Categoria categoria;
  String? descripcion;
  bool disponible;
  double stock;
  String unid;
  String? img;
  
  Producto({
    required this.id,
    required this.nombre,
    required this.estado,
    required this.usuario,
    required this.precio,
    required this.categoria,
    this.descripcion,
    required this.disponible,
    required this.stock,
    required this.unid,
    this.img,
  });

 


  factory Producto.fromMap(Map<String, dynamic> json) => Producto(
    id: json["_id"],
    nombre: json["nombre"],
    estado: json["estado"] ?? false,
    usuario: User.fromMap(json["usuario"]),
    precio: json["precio"]?.toDouble() ?? 0.0,
    categoria: Categoria.fromMap(json["categoria"]),
    descripcion: json["descripcion"],
    disponible: json["disponible"] ?? true,
    stock: json["stock"]?.toDouble() ?? 0.0,
    unid: json["unid"] ?? '',
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
    "stock": stock,
    "unid": unid,
    "img": img,
  };

  Producto copyWith({
    String? id,
    String? nombre,
    bool? estado,
    User? usuario,
    double? precio,
    Categoria? categoria,
    String? descripcion,
    bool? disponible,
    double? stock,
    String? unid,
    String? img,
  }) { return Producto(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      estado: estado ?? this.estado,
      usuario: usuario ?? this.usuario,
      precio: precio ?? this.precio,
      categoria: categoria ?? this.categoria,
      descripcion: descripcion ?? this.descripcion,
      disponible: disponible ?? this.disponible,
      stock: stock ?? this.stock,
      unid: unid ?? this.unid,
      img: img ?? this.img,
    );
    }

}

class Categoria {
  String id;
  String nombre;

  Categoria({
    required this.id,
    required this.nombre,
  });

  factory Categoria.fromJson(String str) => Categoria.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Categoria.fromMap(Map<String, dynamic> json) => Categoria(
    id: json["_id"],
    nombre: json["nombre"],
    
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "nombre": nombre,
  };
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
