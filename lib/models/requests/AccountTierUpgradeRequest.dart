import 'dart:convert';
AccountTierUpgradeRequest accountTierUpgradeRequestFromJson(String str) => AccountTierUpgradeRequest.fromJson(json.decode(str));

String accountTierUpgradeRequestToJson(AccountTierUpgradeRequest data) => json.encode(data.toJson());

class AccountTierUpgradeRequest {
  String authorizationCode;

  AccountTierUpgradeRequest({
    required this.authorizationCode,
  });

  factory AccountTierUpgradeRequest.fromJson(Map<String, dynamic> json) => AccountTierUpgradeRequest(
    authorizationCode: json["authorizationCode"],
  );

  Map<String, dynamic> toJson() => {
    "authorizationCode": authorizationCode,
  };
}
