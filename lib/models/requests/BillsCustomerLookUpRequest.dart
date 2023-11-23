
import 'dart:convert';

BillsCustomerLookUpRequest billsCustomerLookUpRequestFromJson(String str) => BillsCustomerLookUpRequest.fromJson(json.decode(str));

String billsCustomerLookUpRequestToJson(BillsCustomerLookUpRequest data) => json.encode(data.toJson());

class BillsCustomerLookUpRequest {
  String customerId;
  String billerSlug;
  String productName;

  BillsCustomerLookUpRequest({
    required this.customerId,
    required this.billerSlug,
    required this.productName,
  });

  factory BillsCustomerLookUpRequest.fromJson(Map<String, dynamic> json) => BillsCustomerLookUpRequest(
    customerId: json["customerId"],
    billerSlug: json["billerSlug"],
    productName: json["productName"],
  );

  Map<String, dynamic> toJson() => {
    "customerId": customerId,
    "billerSlug": billerSlug,
    "productName": productName,
  };
}
