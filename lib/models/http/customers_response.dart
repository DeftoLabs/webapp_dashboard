import 'dart:convert';

import 'package:web_dashboard/models/customers.dart';

class CustomerResponse {
    int total;
    List<Customer> customers;

    CustomerResponse({
        required this.total,
        required this.customers,
    });

    factory CustomerResponse.fromJson(String str) => CustomerResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CustomerResponse.fromMap(Map<String, dynamic> json) => CustomerResponse(
        total: json["total"],
        customers: List<Customer>.from(json["clientes"].map((x) => Customer.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "clientes": List<dynamic>.from(customers.map((x) => x.toMap())),
    };
}

