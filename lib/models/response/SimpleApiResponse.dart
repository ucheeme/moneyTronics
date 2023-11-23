import 'dart:convert';
SimpleResponse simpleResponseFromJson(String str) => SimpleResponse.fromJson(json.decode(str));
String simpleResponseToJson(SimpleResponse data) => json.encode(data.toJson());
class SimpleResponse {
  int? retval;
  String? retmsg;
  String? phonenumber;
  String? userId;
  SimpleResponse({
    this.retval,
    this.retmsg,
    this.phonenumber,
    this.userId,
  });
  factory SimpleResponse.fromJson(Map<String, dynamic> json) => SimpleResponse(
    retval: json["retval"],
    retmsg: json["retmsg"],
    phonenumber: json["phonenumber"],
    userId: json["userId"],
  );
  Map<String, dynamic> toJson() => {
    "retval": retval,
    "retmsg": retmsg,
    "phonenumber": phonenumber,
    "userId": userId,
  };
}
