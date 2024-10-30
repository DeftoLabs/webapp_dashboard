
import 'dart:convert';

class TaxSales {
    final String? id;
    double taxnumber;
    String taxname;

    TaxSales({
        this.id,
        required this.taxnumber,
        required this.taxname,
    });

    factory TaxSales.fromJson(String str) => TaxSales.fromMap(json.decode(str));

     Map<String, dynamic> toJson() => toMap(); // 

    factory TaxSales.fromMap(Map<String, dynamic> json) => TaxSales(
        id: json["_id"] ?? '',
        taxnumber: json["taxnumber"] ?? '',
        taxname: json["taxname"] ?? '',
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "taxnumber": taxnumber,
        "taxname": taxname,
    };
}