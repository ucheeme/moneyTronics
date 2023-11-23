// To parse this JSON data, do
//
//     final billerGroupsResponse = billerGroupsResponseFromJson(jsonString);

import 'dart:convert';

List<BillerGroupsResponse> billerGroupsResponseFromJson(String str) => List<BillerGroupsResponse>.from(json.decode(str).map((x) => BillerGroupsResponse.fromJson(x)));

String billerGroupsResponseToJson(List<BillerGroupsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BillerGroupsResponse {
  int? id;
  String? name;
  String? slug;

  BillerGroupsResponse({
    this.id,
    this.name,
    this.slug,
  });

  factory BillerGroupsResponse.fromJson(Map<String, dynamic> json) => BillerGroupsResponse(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
  };
}
