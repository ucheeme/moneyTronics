// To parse this JSON data, do
//
//     final billsCustomerLookUpResponse = billsCustomerLookUpResponseFromJson(jsonString);

import 'dart:convert';

BillsCustomerLookUpResponse billsCustomerLookUpResponseFromJson(String str) => BillsCustomerLookUpResponse.fromJson(json.decode(str));

String billsCustomerLookUpResponseToJson(BillsCustomerLookUpResponse data) => json.encode(data.toJson());

class BillsCustomerLookUpResponse {
  String? billerName;
  Customer? customer;
  bool? paid;
  String? statusCode;
  int? amount;

  BillsCustomerLookUpResponse({
    this.billerName,
    this.customer,
    this.paid,
    this.statusCode,
    this.amount,
  });

  factory BillsCustomerLookUpResponse.fromJson(Map<String, dynamic> json) => BillsCustomerLookUpResponse(
    billerName: json["billerName"],
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    paid: json["paid"],
    statusCode: json["statusCode"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "billerName": billerName,
    "customer": customer?.toJson(),
    "paid": paid,
    "statusCode": statusCode,
    "amount": amount,
  };
}

class Customer {
  String? firstName;
  String? lastName;
  dynamic customerName;
  dynamic accountNumber;
  dynamic dueDate;
  bool? canVend;
  dynamic phoneNumber;
  dynamic emailAddress;

  Customer({
    this.firstName,
    this.lastName,
    this.customerName,
    this.accountNumber,
    this.dueDate,
    this.canVend,
    this.phoneNumber,
    this.emailAddress,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    firstName: json["firstName"],
    lastName: json["lastName"],
    customerName: json["customerName"],
    accountNumber: json["accountNumber"],
    dueDate: json["dueDate"],
    canVend: json["canVend"],
    phoneNumber: json["phoneNumber"],
    emailAddress: json["emailAddress"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "customerName": customerName,
    "accountNumber": accountNumber,
    "dueDate": dueDate,
    "canVend": canVend,
    "phoneNumber": phoneNumber,
    "emailAddress": emailAddress,
  };
}
