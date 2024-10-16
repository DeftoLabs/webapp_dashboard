import 'dart:convert';

class Finance {
    final String? id;
    String mainCurrencyname;
    String mainCurrencysymbol;
    String secondCurrencyname;
    String secondCurrencysymbol;
    String tax1name;
    double tax1number;
    String tax2name;
    double tax2number;
    String tax3name;
    double tax3number;
    String tax4name;
    double tax4number;

    Finance({
        this.id,
        required this.mainCurrencyname,
        required this.mainCurrencysymbol,
        required this.secondCurrencyname,
        required this.secondCurrencysymbol,
        required this.tax1name,
        required this.tax1number,
        required this.tax2name,
        required this.tax2number,
        required this.tax3name,
        required this.tax3number,
        required this.tax4name,
        required this.tax4number,
    });

    factory Finance.fromJson(String str) => Finance.fromMap(json.decode(str));

    String toJson() => json.encode(toJson());

factory Finance.fromMap(Map<String, dynamic> json) => Finance(
    id: json["_id"] ?? '',
    mainCurrencyname: json["mainCurrencyname"] ?? '',
    mainCurrencysymbol : json["mainCurrencysymbol"] ?? '',
    secondCurrencyname: json ["secondCurrencyname"] ?? '',
    secondCurrencysymbol: json ['secondCurrencysymbol'] ?? '',
    tax1name: json ["tax1name"] ?? '',
    tax1number: json ["tax1number"] ?? '',
    tax2name: json ["tax2name"] ?? '',
    tax2number: json ["tax2number"] ?? '',
    tax3name: json ["tax3name"] ?? '',
    tax3number: json ["tax3number"] ?? '',
    tax4name: json ["tax4name"] ?? '',
    tax4number: json ["tax4number"] ?? '',

);


    Map<String, dynamic> toMap() => {
    "_id": id,
    "mainCurrencyname": mainCurrencyname,
    "mainCurrencysymbol" :mainCurrencysymbol,
    "secondCurrencyname": secondCurrencyname,
    "secondCurrencysymbol": secondCurrencysymbol,
    "tax1name": tax1name,
    "tax1number": tax1number,
    "tax2name": tax2name,
    "tax2number": tax2number,
    "tax3name": tax3name,
    "tax3number": tax3number,
    "tax4name": tax4name,
    "tax4number": tax4number,
    };
}

