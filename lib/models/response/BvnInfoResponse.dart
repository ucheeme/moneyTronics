// To parse this JSON data, do
//
//     final bvnInfoResponse = bvnInfoResponseFromJson(jsonString);

import 'dart:convert';

BvnInfoResponse bvnInfoResponseFromJson(String str) => BvnInfoResponse.fromJson(json.decode(str));

String bvnInfoResponseToJson(BvnInfoResponse data) => json.encode(data.toJson());

class BvnInfoResponse {
  String url;
  bool status;
  bool isValidated;

  BvnInfoResponse({
    required this.url,
    required this.status,
    required this.isValidated,
  });

  factory BvnInfoResponse.fromJson(Map<String, dynamic> json) => BvnInfoResponse(
    url: json["url"],
    status: json["status"],
    isValidated: json["isValidated"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "status": status,
    "isValidated": isValidated,
  };
}
