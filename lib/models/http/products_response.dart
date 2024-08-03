import 'dart:convert';

import '../products.dart';

class ProductsResponse {
  int total;
  List<Producto> productos;

  ProductsResponse({
    required this.total,
    required this.productos,
  });

  factory ProductsResponse.fromJson(String str) => ProductsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductsResponse.fromMap(Map<String, dynamic> json) => ProductsResponse(
    total: json["total"],
    productos: List<Producto>.from(json["productos"].map((x) => Producto.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "total": total,
    "productos": List<dynamic>.from(productos.map((x) => x.toMap())),
  };
}
