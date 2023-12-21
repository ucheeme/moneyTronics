// To parse this JSON data, do
//
//     final createExistingUserResponse = createExistingUserResponseFromJson(jsonString);

import 'dart:convert';

CreateExistingUserResponse createExistingUserResponseFromJson(String str) => CreateExistingUserResponse.fromJson(json.decode(str));

String createExistingUserResponseToJson(CreateExistingUserResponse data) => json.encode(data.toJson());

class CreateExistingUserResponse {
  int? retval;
  String? username;

  CreateExistingUserResponse({
    this.retval,
    this.username,
  });

  factory CreateExistingUserResponse.fromJson(Map<String, dynamic> json) => CreateExistingUserResponse(
    retval: json["retval"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "retval": retval,
    "username": username,
  };
}
