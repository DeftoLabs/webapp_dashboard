

class Usuario {
    final String rol;
    final bool estado;
    final bool google;
    final String nombre;
    final String correo;
    final String uid;
    final String? img;
    final String? phone;
    final String? zone;

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
    );

    Map<String, dynamic> toMap() => {
        "rol": rol,
        "estado": estado,
        "google": google,
        "nombre": nombre,
        "correo": correo,
        "uid": uid,
    };
}
