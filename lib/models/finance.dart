import 'dart:convert';

class Finance {
  final String? id;
  String mainCurrencyname;
  String mainCurrencysymbol;
  String secondCurrencyname;
  String secondCurrencysymbol;


  Finance({
    this.id,
    required this.mainCurrencyname,
    required this.mainCurrencysymbol,
    required this.secondCurrencyname,
    required this.secondCurrencysymbol,
  
  });

  factory Finance.fromJson(String str) => Finance.fromMap(json.decode(str));

  Map<String, dynamic> toJson() => toMap(); // Corrige aquí

  factory Finance.fromMap(Map<String, dynamic> json) => Finance(
    id: json["_id"] ?? '',
    mainCurrencyname: json["mainCurrencyname"] ?? '',
    mainCurrencysymbol: json["mainCurrencysymbol"] ?? '',
    secondCurrencyname: json["secondCurrencyname"] ?? '',
    secondCurrencysymbol: json["secondCurrencysymbol"] ?? '',
    
  );
  Map<String, dynamic> toMap() => {
        "_id": id,
        "mainCurrencyname": mainCurrencyname,
        "mainCurrencysymbol": mainCurrencysymbol,
        "secondCurrencyname": secondCurrencyname,
        "secondCurrencysymbol": secondCurrencysymbol,
      
      };
}
