// To parse this JSON data, do
//
//     final encRequest = encRequestFromJson(jsonString);

import 'dart:convert';

EncRequest encRequestFromJson(String str) => EncRequest.fromJson(json.decode(str));

String encRequestToJson(EncRequest data) => json.encode(data.toJson());

class EncRequest {
  String encRequest;
  String detailsRequest;

  EncRequest({
    required this.encRequest,
    required this.detailsRequest,
  });

  factory EncRequest.fromJson(Map<String, dynamic> json) => EncRequest(
    encRequest: json["encRequest"],
    detailsRequest: json["detailsRequest"],
  );

  Map<String, dynamic> toJson() => {
    "encRequest": encRequest,
    "detailsRequest": detailsRequest,
  };
}
