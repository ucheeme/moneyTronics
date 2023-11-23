// To parse this JSON data, do
//
//     final finedgeProduct = finedgeProductFromJson(jsonString);

import 'dart:convert';

List<FinedgeProduct> finedgeProductFromJson(String str) => List<FinedgeProduct>.from(json.decode(str).map((x) => FinedgeProduct.fromJson(x)));

String finedgeProductToJson(List<FinedgeProduct> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FinedgeProduct {
  String productCode;
  String productName;
  FinedgeProduct({
    required this.productCode,
    required this.productName,
  });
  factory FinedgeProduct.fromJson(Map<String, dynamic> json) => FinedgeProduct(
    productCode: json["productCode"],
    productName: json["productName"],
  );
  Map<String, dynamic> toJson() => {
    "productCode": productCode,
    "productName": productName,
  };
}
