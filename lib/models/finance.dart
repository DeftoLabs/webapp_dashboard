import 'dart:convert';

class Finance {
    final String id;
    Currency mainCurrency;
    Currency secondaryCurrency;
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
    mainCurrency: Currency.fromMap(json["mainCurrency"]),  // Cambiado de fromJson a fromMap
    secondaryCurrency: Currency.fromMap(json["secondaryCurrency"]),  // Cambiado de fromJson a fromMap
    tax1: List<Tax>.from(json["tax1"].map((x) => Tax.fromMap(x))),  // Cambiado de fromJson a fromMap
    tax2: List<Tax>.from(json["tax2"].map((x) => Tax.fromMap(x))),  // Cambiado de fromJson a fromMap
    tax3: List<Tax>.from(json["tax3"].map((x) => Tax.fromMap(x))),  // Cambiado de fromJson a fromMap
    tax4: List<Tax>.from(json["tax4"].map((x) => Tax.fromMap(x))),  // Cambiado de fromJson a fromMap
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

class Currency {
    String name;
    String symbol;

    Currency({required this.name, required this.symbol});

    factory Currency.fromMap(Map<String, dynamic> json) => Currency(
        name: json["name"],
        symbol: json["symbol"],
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
        name: json["name"],
        percentage: json["percentage"]?.toDouble() ?? 0.0,
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "percentage": percentage,
    };
}

