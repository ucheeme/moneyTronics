
import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import '../../Env/env.dart';
import '../../Utils/appUtil.dart';
import '../../views/startScreen/login/loginFirstTime.dart';
import 'EncRequest.dart';
import 'VendingSecRequest.dart';

BillMakeBillsPaymentRequest billMakeBillsPaymentRequestFromJson(String str) => BillMakeBillsPaymentRequest.fromJson(json.decode(str));

String billMakeBillsPaymentRequestToJson(BillMakeBillsPaymentRequest data) => json.encode(data.toJson());

class BillMakeBillsPaymentRequest {
  String customerId;
  String packageSlug;
  String channel;
  String customerName;
  String phoneNumber;
  String email;
  String accountNumber;
  double amount;
  String transactionPin;
  String otpCode;

  BillMakeBillsPaymentRequest({
    required this.customerId,
    required this.packageSlug,
    required this.channel,
    required this.customerName,
    required this.phoneNumber,
    required this.email,
    required this.accountNumber,
    required this.amount,
    required this.transactionPin,
    required this.otpCode,
  });

  factory BillMakeBillsPaymentRequest.fromJson(Map<String, dynamic> json) => BillMakeBillsPaymentRequest(
    customerId: json["customerId"],
    packageSlug: json["packageSlug"],
    channel: json["channel"],
    customerName: json["customerName"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    accountNumber: json["accountNumber"],
    amount: json["amount"],
    transactionPin: json["transactionPin"],
    otpCode: json["otpCode"],
  );

  Map<String, dynamic> toJson() => {
    "customerId": customerId,
    "packageSlug": packageSlug,
    "channel": channel,
    "customerName": customerName,
    "phoneNumber": phoneNumber,
    "email": email,
    "accountNumber": accountNumber,
    "amount": amount,
    "transactionPin": transactionPin,
    "otpCode": otpCode,
  };
  EncRequest encryptedRequest(){

    VendSecRequest request = VendSecRequest(
        accountNumber: accountNumber,
        amountPaid: amount.toString(),
        channel: "mobile",
        customerName: customerName,
        phoneNumber: phoneNumber,
        email: email,
        transactionPin: transactionPin,
        otpCode: otpCode,
        customerId: customerId,
        packageSlug: packageSlug
    );
    print("raw request: ${vendSecRequestToJson(request)}");
    final buffer = StringBuffer();
    buffer.write(request.customerId);
    buffer.write(AppUtils.convertDateSystem(DateTime.now()));
    buffer.write(packageSlug);
    buffer.write(loginResponse?.username ?? "");
    buffer.write(request.accountNumber);

    var key = utf8.encode(Env.hmacKey);
    Hmac hmac =  Hmac(sha512, key);
    var bytes = utf8.encode(buffer.toString());
    var digest = hmac.convert(bytes);
    String encRequest = base64.encode(digest.bytes);



    var key2 = Key.fromBase64(Env.aesKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key2, mode: AESMode.cbc));
    var bytes2 = utf8.encode(vendSecRequestToJson(request));
    var digest2 = encrypter.encrypt(vendSecRequestToJson(request), iv: iv);
    String detailsRequest = base64.encode(digest2.bytes);
    return EncRequest(encRequest: encRequest, detailsRequest: detailsRequest);
  }
}
