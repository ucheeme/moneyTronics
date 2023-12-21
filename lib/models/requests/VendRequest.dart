// To parse this JSON data, do
//
//     final vendRequest = vendRequestFromJson(jsonString);

import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import '../../Env/env.dart';
import '../../Utils/appUtil.dart';
import '../../views/startScreen/login/loginFirstTime.dart';
import 'EncRequest.dart';
import 'VendingSecRequest.dart';

VendRequest vendRequestFromJson(String str) => VendRequest.fromJson(json.decode(str));

String vendRequestToJson(VendRequest data) => json.encode(data.toJson());

class VendRequest {
  String accountNumber;
  double amountPaid;
  String phoneNumber;
  String transactionDate;
  String networkProvider;
  String vendingCode;
  String subCode;
  String transactionPin;
  bool usesPreset;
  String bsig;
  String otpCode;

  VendRequest({
    required this.accountNumber,
    required this.amountPaid,
    required this.phoneNumber,
    required this.transactionDate,
    required this.networkProvider,
    required this.vendingCode,
    required this.subCode,
    required this.transactionPin,
    required this.usesPreset,
    required this.bsig,
    required this.otpCode,
  });

  factory VendRequest.fromJson(Map<String, dynamic> json) => VendRequest(
    accountNumber: json["accountNumber"],
    amountPaid: json["amountPaid"],
    phoneNumber: json["phoneNumber"],
    transactionDate: json["transactionDate"],
    networkProvider: json["networkProvider"],
    vendingCode: json["vendingCode"],
    subCode: json["subCode"],
    transactionPin: json["transactionPin"],
    usesPreset: json["usesPreset"],
    bsig: json["bsig"],
    otpCode: json["otpCode"],
  );

  Map<String, dynamic> toJson() => {
    "accountNumber": accountNumber,
    "amountPaid": amountPaid,
    "phoneNumber": phoneNumber,
    "transactionDate": transactionDate,
    "networkProvider": networkProvider,
    "vendingCode": vendingCode,
    "subCode": subCode,
    "transactionPin": transactionPin,
    "usesPreset": usesPreset,
    "bsig": bsig,
    "otpCode": otpCode,
  };
  EncRequest encryptedRequest(){
    VendSecRequest request = VendSecRequest(
        accountNumber: accountNumber,
        amountPaid: amountPaid.toString(),
        channel: "mobile",
        customerName: loginResponse?.fullname ?? "",
        phoneNumber: phoneNumber,
        email: loginResponse?.email ?? "",
        transactionPin: transactionPin,
        otpCode: otpCode,
        customerId: loginResponse?.customerId ?? "",
        packageSlug: subCode
    );

    final buffer = StringBuffer();
    buffer.write(request.phoneNumber);
    buffer.write(AppUtils.convertDateSystem(DateTime.now()));
    buffer.write(loginResponse?.username ?? "");
    buffer.write(request.accountNumber);
    buffer.write(request.amountPaid);
    buffer.write(vendingCode);
    var key = utf8.encode(Env.hmacKey);
    Hmac hmac =  Hmac(sha512, key);
    var bytes = utf8.encode(buffer.toString());
    var digest = hmac.convert(bytes);
    String encRequest = base64.encode(digest.bytes);


    var key2 =Key.fromUtf8(Env.aesKey);
    final encrypter = Encrypter(AES(key2, mode: AESMode.cbc));
    var digest2 = encrypter.encrypt(vendSecRequestToJson(request));
    String detailsRequest = base64.encode(digest2.bytes);

    return EncRequest(encRequest: encRequest, detailsRequest: detailsRequest);
  }
}
