
import 'dart:convert';

import '../taxoperation.dart';

class TaxOperationResponse {
    TaxOperationResponse({
        required this.total,
        required this.taxoperation,
    });

      int total;
      List<TaxOperation> taxoperation;

    factory TaxOperationResponse.fromJson(String str) => TaxOperationResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toJson());

    factory TaxOperationResponse.fromMap(Map<String, dynamic> json) => TaxOperationResponse(
        total: json["total"],
        taxoperation: List<TaxOperation>.from(json["taxesOperation"].map((x) => TaxOperation.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "taxesOperation": List<dynamic>.from(taxoperation.map((x) => x.toJson())),
    };
}
