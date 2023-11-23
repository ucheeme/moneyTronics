
import 'dart:convert';

DeviceAuthenticationRequest deviceAuthenticationRequestFromJson(String str) => DeviceAuthenticationRequest.fromJson(json.decode(str));
String deviceAuthenticationRequestToJson(DeviceAuthenticationRequest data) => json.encode(data.toJson());

class DeviceAuthenticationRequest {
  String username;
  String otpCode;
  String accountNumber;
  String deviceName;
  String deviceUniqueId;
  String platformOs;
  String deviceModel;
  String deviceType;
  String secretQuestionAnswer;

  DeviceAuthenticationRequest({
    required this.username,
    required this.otpCode,
    required this.accountNumber,
    required this.deviceName,
    required this.deviceUniqueId,
    required this.platformOs,
    required this.deviceModel,
    required this.deviceType,
    required this.secretQuestionAnswer,
  });

  factory DeviceAuthenticationRequest.fromJson(Map<String, dynamic> json) => DeviceAuthenticationRequest(
    username: json["username"],
    otpCode: json["otpCode"],
    accountNumber: json["accountNumber"],
    deviceName: json["deviceName"],
    deviceUniqueId: json["device_UniqueId"],
    platformOs: json["platform_OS"],
    deviceModel: json["device_Model"],
    deviceType: json["deviceType"],
    secretQuestionAnswer: json["secretQuestionAnswer"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "otpCode": otpCode,
    "accountNumber": accountNumber,
    "deviceName": deviceName,
    "device_UniqueId": deviceUniqueId,
    "platform_OS": platformOs,
    "device_Model": deviceModel,
    "deviceType": deviceType,
    "secretQuestionAnswer": secretQuestionAnswer,
  };
}
