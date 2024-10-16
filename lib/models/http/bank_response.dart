import 'dart:convert';

import '../bank.dart';

class BankResponse {
    BankResponse({
        required this.total,
        required this.banks,
    });

    int total;
    List<Bank> banks;

    factory BankResponse.fromJson(String str) => BankResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

factory BankResponse.fromMap(Map<String, dynamic> json) => BankResponse(
    total: json["total"],
    banks: List<Bank>.from(json["bankAccounts"].map((x) => Bank.fromMap(x))),
);

    Map<String, dynamic> toMap() => {
        "total": total,
        "banks": List<dynamic>.from(banks.map((x) => x.toMap())),
    };
}
