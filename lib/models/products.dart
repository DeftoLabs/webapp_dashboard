import 'dart:convert';

class Producto {
  String id;
  String nombre;
  bool estado;
  User usuario;
  double precio1;
  double precio2;
  double precio3;
  double precio4;
  double precio5;
  Categoria categoria;
  String? descripcion;
  bool disponible;
  double stock;
  String unid;
  String? img;
  double? precio;
  double? cantidad;
  double? totalitem;
  
  Producto({
    required this.id,
    required this.nombre,
    required this.estado,
    required this.usuario,
    required this.precio1,
    required this.precio2,
    required this.precio3,
    required this.precio4,
    required this.precio5,
    required this.categoria,
    this.descripcion,
    required this.disponible,
    required this.stock,
    required this.unid,
    this.img,
    this.precio,
    this.cantidad,
    this.totalitem,
  });

 


 factory Producto.fromMap(Map<String, dynamic> json) => Producto(
  id: json["_id"] ?? '',
  nombre: json.containsKey("producto") ? json["producto"]["nombre"] ?? 'CODE ERROR' : json["nombre"] ?? 'CODE ERROR',
  estado: json["estado"] ?? false,
  usuario: json["usuario"] != null ? User.fromMap(json["usuario"]) : User(id: '', nombre: ''),
  precio1: json.containsKey("producto") ? json["producto"]["precio1"]?.toDouble() ?? 0.0 : json["precio1"]?.toDouble() ?? 0.0,
  precio2: json.containsKey("producto") ? json["producto"]["precio2"]?.toDouble() ?? 0.0 : json["precio2"]?.toDouble() ?? 0.0,
  precio3: json.containsKey("producto") ? json["producto"]["precio3"]?.toDouble() ?? 0.0 : json["precio3"]?.toDouble() ?? 0.0,
  precio4: json.containsKey("producto") ? json["producto"]["precio4"]?.toDouble() ?? 0.0 : json["precio4"]?.toDouble() ?? 0.0,
  precio5: json.containsKey("producto") ? json["producto"]["precio5"]?.toDouble() ?? 0.0 : json["precio5"]?.toDouble() ?? 0.0,
  categoria: json["categoria"] != null ? Categoria.fromMap(json["categoria"]) : Categoria(id: '', nombre: ''),
  descripcion: json.containsKey("producto") ? json["producto"]["descripcion"] ?? 'ERROR' : json["descripcion"] ?? 'ERROR',
  disponible: json["disponible"] ?? true,
  stock: json["stock"]?.toDouble() ?? 0.0,
  unid: json["unid"] ?? '',
  img: json["img"],
  precio: json["precio"]?.toDouble() ?? 0.0,
  cantidad: json["cantidad"]?.toDouble() ?? 0.0,
  totalitem: json["totalitem"]?.toDouble() ?? 0.0,
);


  Map<String, dynamic> toMap() => {
    "_id": id,
    "nombre": nombre,
    "estado": estado,
    "usuario": usuario.toMap(),
    "precio1": precio1,
    "precio2": precio2,
    "precio3": precio3,
    "precio4": precio4,
    "precio5": precio5,
    "categoria": categoria.toMap(),
    "descripcion": descripcion,
    "disponible": disponible,
    "stock": stock,
    "unid": unid,
    "img": img,
    "precio": precio,
    "cantidad": cantidad,
    "totalitem": totalitem
  };

  Producto copyWith({
    String? id,
    String? nombre,
    bool? estado,
    User? usuario,
    double? precio1,
    double? precio2,
    double? precio3,
    double? precio4,
    double? precio5,
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
      precio1: precio1 ?? this.precio1,
      precio2: precio2 ?? this.precio2,
      precio3: precio3 ?? this.precio3,
      precio4: precio4 ?? this.precio4,
      precio5: precio5 ?? this.precio5,
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
