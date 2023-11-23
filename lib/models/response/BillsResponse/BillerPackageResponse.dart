// To parse this JSON data, do
//
//     final billerPackageResponse = billerPackageResponseFromJson(jsonString);

import 'dart:convert';

List<BillerPackageResponse> billerPackageResponseFromJson(String str) => List<BillerPackageResponse>.from(json.decode(str).map((x) => BillerPackageResponse.fromJson(x)));

String billerPackageResponseToJson(List<BillerPackageResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BillerPackageResponse {
  int? id;
  String? name;
  String? slug;
  int? amount;
  int? billerId;
  int? sequenceNumber;

  BillerPackageResponse({
    this.id,
    this.name,
    this.slug,
    this.amount,
    this.billerId,
    this.sequenceNumber,
  });

  factory BillerPackageResponse.fromJson(Map<String, dynamic> json) => BillerPackageResponse(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    amount: json["amount"],
    billerId: json["billerId"],
    sequenceNumber: json["sequenceNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "amount": amount,
    "billerId": billerId,
    "sequenceNumber": sequenceNumber,
  };
}
