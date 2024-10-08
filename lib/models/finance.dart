import 'dart:convert';

class Finance {
    final String id;
    Currencys mainCurrency;
    Currencys secondaryCurrency;
    List<Tax> tax1;
    List<Tax> tax2;
    List<Tax> tax3;
    List<Tax> tax4;

    Finance({
        required this.id,
        required this.mainCurrency,
        required this.secondaryCurrency,
        required this.tax1,
        required this.tax2,
        required this.tax3,
        required this.tax4,
    });

    factory Finance.fromJson(String str) => Finance.fromMap(json.decode(str));

    String toJson() => json.encode(toJson());

factory Finance.fromMap(Map<String, dynamic> json) => Finance(
    id: json["_id"] ?? '',
    mainCurrency: Currencys.fromMap(json["mainCurrency"] ?? '') , 
    secondaryCurrency: Currencys.fromMap(json["secondaryCurrency"] ?? ''),  
    tax1: List<Tax>.from(json["tax1"].map((x) => Tax.fromMap(x)) ?? ''),  
    tax2: List<Tax>.from(json["tax2"].map((x) => Tax.fromMap(x)) ?? ''), 
    tax3: List<Tax>.from(json["tax3"].map((x) => Tax.fromMap(x)) ?? ''),  
    tax4: List<Tax>.from(json["tax4"].map((x) => Tax.fromMap(x)) ?? ''),  
);


    Map<String, dynamic> toMap() => {
        "_id": id,
        "mainCurrency": mainCurrency.toJson(),
        "secondaryCurrency": secondaryCurrency.toJson(),
        "tax1": List<dynamic>.from(tax1.map((x) => x.toJson())),
        "tax2": List<dynamic>.from(tax2.map((x) => x.toJson())),
        "tax3": List<dynamic>.from(tax3.map((x) => x.toJson())),
        "tax4": List<dynamic>.from(tax4.map((x) => x.toJson())),
    };
}

class Currencys {
    String name;
    String symbol;

    Currencys({required this.name, required this.symbol});

    factory Currencys.fromMap(Map<String, dynamic> json) => Currencys(
        name: json["name"] ?? '',
        symbol: json["symbol"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
    };
}

class Tax {
    String name;
    double percentage;

    Tax({required this.name, required this.percentage});

    factory Tax.fromMap(Map<String, dynamic> json) => Tax(
        name: json["name"] ?? '',
        percentage: json["percentage"]?.toDouble() ?? 0.0,
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "percentage": percentage,
    };
}

