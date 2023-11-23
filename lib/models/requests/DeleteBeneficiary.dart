
import 'dart:convert';

DeleteBeneficiary deleteBeneficiaryFromJson(String str) => DeleteBeneficiary.fromJson(json.decode(str));

String deleteBeneficiaryToJson(DeleteBeneficiary data) => json.encode(data.toJson());

class DeleteBeneficiary {
  int beneficiaryId;

  DeleteBeneficiary({
    required this.beneficiaryId,
  });

  factory DeleteBeneficiary.fromJson(Map<String, dynamic> json) => DeleteBeneficiary(
    beneficiaryId: json["beneficiaryId"],
  );

  Map<String, dynamic> toJson() => {
    "beneficiaryId": beneficiaryId,
  };
}
