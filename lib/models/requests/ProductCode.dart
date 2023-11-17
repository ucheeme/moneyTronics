import 'dart:convert';
ProductCode productCodeFromJson(String str) => ProductCode.fromJson(json.decode(str));
String productCodeToJson(ProductCode data) => json.encode(data.toJson());
class ProductCode {
  String productCode;
  ProductCode({
    required this.productCode,
  });
  factory ProductCode.fromJson(Map<String, dynamic> json) => ProductCode(
    productCode: json["productCode"],
  );
  Map<String, dynamic> toJson() => {
    "productCode": productCode,
  };
}
