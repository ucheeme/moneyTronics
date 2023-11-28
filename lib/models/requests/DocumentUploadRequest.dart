// To parse this JSON data, do
//
//     final documentUploadRequest = documentUploadRequestFromJson(jsonString);

import 'dart:convert';

DocumentUploadRequest documentUploadRequestFromJson(String str) => DocumentUploadRequest.fromJson(json.decode(str));

String documentUploadRequestToJson(DocumentUploadRequest data) => json.encode(data.toJson());

class DocumentUploadRequest {
  int documentType;
  String base64String;

  DocumentUploadRequest({
    required this.documentType,
    required this.base64String,
  });

  factory DocumentUploadRequest.fromJson(Map<String, dynamic> json) => DocumentUploadRequest(
    documentType: json["documentType"],
    base64String: json["base64String"],
  );

  Map<String, dynamic> toJson() => {
    "documentType": documentType,
    "base64String": base64String,
  };
}
