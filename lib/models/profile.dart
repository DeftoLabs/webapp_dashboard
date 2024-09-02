import 'dart:convert';

class Profile {
  bool estado;
  String id;
  String codigo;
  String idfiscal;
  String nombre;
  String razons;
  String direccion;
  String telefono;
  String web;
  String email1;
  String email2;
  String email3;
  String email4;
  String email5;
  List<Correo> correos;
  String? img;

  Profile({
    required this.estado,
    required this.id,
    required this.codigo,
    required this.idfiscal,
    required this.nombre,
    required this.razons,
    required this.direccion,
    required this.telefono,
    required this.web,
    required this.email1,
    required this.email2,
    required this.email3,
    required this.email4,
    required this.email5,
    required this.correos,
    this.img,
  });

  factory Profile.fromJson(String str) => Profile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
    estado: json["estado"] ?? false,
    id: json["_id"] ?? '',
    codigo: json["codigo"] ?? '',
    idfiscal: json["idfiscal"] ?? '',
    nombre: json["nombre"] ?? '',
    razons: json["razons"] ?? '',
    direccion: json["direccion"] ?? '',
    telefono: json["telefono"] ?? '',
    web: json["web"] ?? '',
    email1: json["email1"] ?? '',
    email2: json["email2"] ?? '',
    email3: json["email3"] ?? '',
    email4: json["email4"] ?? '',
    email5: json["email5"] ?? '',
    correos: json["correos"] != null
        ? List<Correo>.from(json["correos"].map((x) => Correo.fromMap(x)))
        : [],
    img: json["img"],
  );

  Map<String, dynamic> toMap() => {
    "estado": estado,
    "_id": id,
    "codigo": codigo,
    "idfiscal": idfiscal,
    "nombre": nombre,
    "razons": razons,
    "direccion": direccion,
    "telefono": telefono,
    "web": web,
    "email1": email1,
    "email2": email2,
    "email3": email3,
    "email4": email4,
    "email5": email5,
    "correos": List<dynamic>.from(correos.map((x) => x.toJson())),
    "img": img,
  };

  Profile copyWith({
    bool? estado,
    String? id,
    String? codigo,
    String? idfiscal,
    String? nombre,
    String? razons,
    String? direccion,
    String? telefono,
    String? web,
    String? email1,
    String? email2,
    String? email3,
    String? email4,
    String? email5,
    List<Correo>? correos,
    String? img,
  }) {
    return Profile(
      estado: estado ?? this.estado,
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      idfiscal: idfiscal ?? this.idfiscal,
      nombre: nombre ?? this.nombre,
      razons: razons ?? this.razons,
      direccion: direccion ?? this.direccion,
      telefono: telefono ?? this.telefono,
      web: web ?? this.web,
      email1: email1 ?? this.email1,
      email2: email2 ?? this.email2,
      email3: email3 ?? this.email3,
      email4: email4 ?? this.email4,
      email5: email5 ?? this.email5,
      correos: correos ?? this.correos,
      img: img ?? this.img,
    );
  }
}

class Correo {
  String id;
  String email;
  String departamento;

  Correo({
    required this.id,
    required this.email,
    required this.departamento,
  });

  factory Correo.fromJson(String str) => Correo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Correo.fromMap(Map<String, dynamic> map) => Correo(
    id: map["_id"] ?? '',
    email: map["email"] ?? '',
    departamento: map["departamento"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "email": email,
    "departamento": departamento,
  };

  Correo copyWith({
    String? id,
    String? email,
    String? departamento,
  }) {
    return Correo(
      id: id ?? this.id,
      email: email ?? this.email,
      departamento: departamento ?? this.departamento,
    );
  }
}
