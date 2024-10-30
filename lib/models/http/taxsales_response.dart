
import 'dart:convert';

import '../taxsales.dart';

class TaxSalesResponse {
    TaxSalesResponse({
        required this.total,
        required this.taxsales,
    });

      int total;
      List<TaxSales> taxsales;

    factory TaxSalesResponse.fromJson(String str) => TaxSalesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toJson());

    factory TaxSalesResponse.fromMap(Map<String, dynamic> json) => TaxSalesResponse(
        total: json["total"],
        taxsales: List<TaxSales>.from(json["taxesSales"].map((x) => TaxSales.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "taxesSales": List<dynamic>.from(taxsales.map((x) => x.toJson())),
    };
}
