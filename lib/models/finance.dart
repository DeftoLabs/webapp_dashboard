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
  String taxa1name;
  double taxa1number;
  String taxa2name;
  double taxa2number;
  String taxa3name;
  double taxa3number;
  String taxa4name;
  double taxa4number;

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
    required this.taxa1name,
    required this.taxa1number,
    required this.taxa2name,
    required this.taxa2number,
    required this.taxa3name,
    required this.taxa3number,
    required this.taxa4name,
    required this.taxa4number,
  });

  factory Finance.fromJson(String str) => Finance.fromMap(json.decode(str));

  Map<String, dynamic> toJson() => toMap(); // Corrige aquí

  factory Finance.fromMap(Map<String, dynamic> json) => Finance(
        id: json["_id"] ?? '',
    mainCurrencyname: json["mainCurrencyname"] ?? '',
    mainCurrencysymbol: json["mainCurrencysymbol"] ?? '',
    secondCurrencyname: json["secondCurrencyname"] ?? '',
    secondCurrencysymbol: json["secondCurrencysymbol"] ?? '',
    tax1name: json["tax1name"] ?? '',
    tax1number: (json["tax1number"] is String)
      ? double.tryParse(json["tax1number"]) ?? 0.0
      : json["tax1number"]?.toDouble() ?? 0.0,
    tax2name: json["tax2name"] ?? '',
    tax2number: (json["tax2number"] is String)
      ? double.tryParse(json["tax2number"]) ?? 0.0
      : json["tax2number"]?.toDouble() ?? 0.0,
    tax3name: json["tax3name"] ?? '',
    tax3number: (json["tax3number"] is String)
      ? double.tryParse(json["tax3number"]) ?? 0.0
      : json["tax3number"]?.toDouble() ?? 0.0,
    tax4name: json["tax4name"] ?? '',
    tax4number: (json["tax4number"] is String)
      ? double.tryParse(json["tax4number"]) ?? 0.0
      : json["tax4number"]?.toDouble() ?? 0.0,
    taxa1name: json["taxa1name"] ?? '',
    taxa1number: (json["taxa1number"] is String)
      ? double.tryParse(json["taxa1number"]) ?? 0.0
      : json["taxa1number"]?.toDouble() ?? 0.0,
    taxa2name: json["taxa2name"] ?? '',
    taxa2number: (json["taxa2number"] is String)
      ? double.tryParse(json["taxa2number"]) ?? 0.0
      : json["taxa2number"]?.toDouble() ?? 0.0,
    taxa3name: json["taxa3name"] ?? '',
    taxa3number: (json["taxa3number"] is String)
      ? double.tryParse(json["taxa3number"]) ?? 0.0
      : json["taxa3number"]?.toDouble() ?? 0.0,
    taxa4name: json["taxa4name"] ?? '',
    taxa4number: (json["taxa4number"] is String)
      ? double.tryParse(json["taxa4number"]) ?? 0.0
      : json["taxa4number"]?.toDouble() ?? 0.0,
  );
  Map<String, dynamic> toMap() => {
        "_id": id,
        "mainCurrencyname": mainCurrencyname,
        "mainCurrencysymbol": mainCurrencysymbol,
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
        "taxa1name": taxa1name,
        "taxa1number": taxa1number,
        "taxa2name": taxa2name,
        "taxa2number": taxa2number,
        "taxa3name": taxa3name,
        "taxa3number": taxa3number,
        "taxa4name": taxa4name,
        "taxa4number": taxa4number,
      };

  // Método para manejar la conversión de String a double
  static double _parseDouble(dynamic value) {
    if (value is String) {
      return double.tryParse(value) ?? 0.0; // Intenta parsear y usa 0.0 si falla
    } else if (value is num) {
      return value.toDouble(); // Si ya es num, conviértelo a double
    }
    return 0.0; // Valor por defecto
  }
}
