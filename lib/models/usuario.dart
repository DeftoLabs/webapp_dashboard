

class Usuario {
    String rol;
    bool estado;
    bool google;
    String nombre;
    String correo;
    String uid;
    String? img;
    String phone;
    String zone;
    Location? location;

    Usuario({
        required this.rol,
        required this.estado,
        required this.google,
        required this.nombre,
        required this.correo,
        required this.uid,
        this.img,
        required this.phone,
        required this.zone,
        this.location
    });

    factory Usuario.fromMap(Map<String, dynamic> json) {
      
      return Usuario(
        rol: json["rol"] ?? '',
        estado: json["estado"] ?? false,
        google: json["google"] ?? false,
        nombre: json["nombre"] ?? '',
        correo: json["correo"] ?? '',
        uid: json["uid"] ?? '',
        img: json["img"] ?? '',
        phone: json ["phone"] ?? '',
        zone: json ["zone"] ?? '',
        location: json ["location"] != null ? Location.fromMap(json["location"]) : null,
    );

    } 

    Map<String, dynamic> toMap() => {
        "rol": rol,
        "estado": estado,
        "google": google,
        "nombre": nombre,
        "correo": correo,
        "uid": uid,
        "img": img,
        "phone": phone,
        "zone": zone,
        "location": location?.toMap(),

    };
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromMap(Map<String, dynamic> json) => Location(
    lat: json["lat"]?.toDouble() ?? 0.0,
    lng: json["lng"]?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toMap() => {
    "lat": lat,
    "lng": lng,
  };
}
