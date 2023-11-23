// To parse this JSON data, do
//
//     final billerGroupsDetailsResponse = billerGroupsDetailsResponseFromJson(jsonString);

import 'dart:convert';

List<BillerGroupsDetailsResponse> billerGroupsDetailsResponseFromJson(String str) => List<BillerGroupsDetailsResponse>.from(json.decode(str).map((x) => BillerGroupsDetailsResponse.fromJson(x)));

String billerGroupsDetailsResponseToJson(List<BillerGroupsDetailsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BillerGroupsDetailsResponse {
  int? id;
  String? name;
  String? slug;
  int? groupId;
  bool? skipValidation;
  bool? handleWithProductCode;
  bool? isRestricted;
  bool? hideInstitution;

  BillerGroupsDetailsResponse({
    this.id,
    this.name,
    this.slug,
    this.groupId,
    this.skipValidation,
    this.handleWithProductCode,
    this.isRestricted,
    this.hideInstitution,
  });

  factory BillerGroupsDetailsResponse.fromJson(Map<String, dynamic> json) => BillerGroupsDetailsResponse(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    groupId: json["groupId"],
    skipValidation: json["skipValidation"],
    handleWithProductCode: json["handleWithProductCode"],
    isRestricted: json["isRestricted"],
    hideInstitution: json["hideInstitution"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "groupId": groupId,
    "skipValidation": skipValidation,
    "handleWithProductCode": handleWithProductCode,
    "isRestricted": isRestricted,
    "hideInstitution": hideInstitution,
  };
}
