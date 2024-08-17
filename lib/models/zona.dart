

class Zona {
  String id;
  String codigo;
  String nombrezona;
  String descripcion;

  Zona ({
  required this.id,
  required this.codigo,
  required this.nombrezona,
  required this.descripcion,
});

    factory Zona.fromMap(Map<String, dynamic> json) => Zona(
        id: json["id"] ?? '',
        codigo: json["codigo"] ?? '',
        nombrezona: json ["nombrezona"] ?? '',
        descripcion: json["descripcion"] ?? '',
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "codigo": codigo,
        "nombrezona": nombrezona,
        "descripcion": descripcion,
    };
}

