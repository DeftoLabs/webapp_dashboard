

class Usuario {
    String rol;
    bool estado;
    bool google;
    String nombre;
    String correo;
    String uid;
    String? img;
    String? phone;
    String? zone;

    Usuario({
        required this.rol,
        required this.estado,
        required this.google,
        required this.nombre,
        required this.correo,
        required this.uid,
        this.img,
        this.phone = '',
        this.zone = '',
    });

    factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        rol: json["rol"],
        estado: json["estado"],
        google: json["google"],
        nombre: json["nombre"],
        correo: json["correo"],
        uid: json["uid"],
        img: json["img"],
    );

    Map<String, dynamic> toMap() => {
        "rol": rol,
        "estado": estado,
        "google": google,
        "nombre": nombre,
        "correo": correo,
        "uid": uid,
        "img": img,
    };
}
