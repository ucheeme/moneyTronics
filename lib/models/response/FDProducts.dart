import 'dart:convert';
List<FdProducts> fdProductsFromJson(String str) => List<FdProducts>.from(json.decode(str).map((x) => FdProducts.fromJson(x)));
String fdProductsToJson(List<FdProducts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FdProducts {
  String productCode;
  String productName;
  String productclass;
  String crRate;

  FdProducts({
    required this.productCode,
    required this.productName,
    required this.productclass,
    required this.crRate,
  });

  factory FdProducts.fromJson(Map<String, dynamic> json) => FdProducts(
    productCode: json["productCode"],
    productName: json["productName"],
    productclass: json["productclass"],
    crRate: json["crRate"],
  );

  Map<String, dynamic> toJson() => {
    "productCode": productCode,
    "productName": productName,
    "productclass": productclass,
    "crRate": crRate,
  };
}
