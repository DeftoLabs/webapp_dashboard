import 'dart:convert';
import 'package:web_dashboard/models/payment.dart';

class PaymentResponse {
  int total;
  List<Payment> payments;

  PaymentResponse({
    required this.total,
    required this.payments,
  });

  factory PaymentResponse.fromJson(String str) => PaymentResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentResponse.fromMap(Map<String, dynamic> json) => PaymentResponse(
        total: json["total"] ?? 0,
        payments: List<Payment>.from(json["payments"].map((x) => Payment.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "total": total,
        "payments": List<dynamic>.from(payments.map((x) => x.toMap())),
      };
}
