
import 'dart:convert';

class TaxOperation {
    final String? id;
    double taxnumber;
    String taxname;

    TaxOperation({
        this.id,
        required this.taxnumber,
        required this.taxname,
    });

    factory TaxOperation.fromJson(String str) => TaxOperation.fromMap(json.decode(str));

     Map<String, dynamic> toJson() => toMap(); // 

    factory TaxOperation.fromMap(Map<String, dynamic> json) => TaxOperation(
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