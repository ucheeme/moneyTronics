// To parse this JSON data, do
//
//     final createAdditionalAccountResponse = createAdditionalAccountResponseFromJson(jsonString);

import 'dart:convert';

CreateAdditionalAccountResponse createAdditionalAccountResponseFromJson(String str) => CreateAdditionalAccountResponse.fromJson(json.decode(str));

String createAdditionalAccountResponseToJson(CreateAdditionalAccountResponse data) => json.encode(data.toJson());

class CreateAdditionalAccountResponse {
  int? retVal;
  String? nuban;

  CreateAdditionalAccountResponse({
    this.retVal,
    this.nuban,
  });

  factory CreateAdditionalAccountResponse.fromJson(Map<String, dynamic> json) => CreateAdditionalAccountResponse(
    retVal: json["retVal"],
    nuban: json["nuban"],
  );

  Map<String, dynamic> toJson() => {
    "retVal": retVal,
    "nuban": nuban,
  };
}
