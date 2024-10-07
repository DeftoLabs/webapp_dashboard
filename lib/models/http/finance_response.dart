import 'dart:convert';

import '../finance.dart';

class FinanceResponse {
    int total;
    List<Finance> finances;

    FinanceResponse({
        required this.total,
        required this.finances,
    });

    factory FinanceResponse.fromJson(String str) => FinanceResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FinanceResponse.fromMap(Map<String, dynamic> json) => FinanceResponse(
        total: json["total"],
        finances: List<Finance>.from(json["finances"].map((x) => Finance.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "finances": List<dynamic>.from(finances.map((x) => x.toMap())),
    };
}

