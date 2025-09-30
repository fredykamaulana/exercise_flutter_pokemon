// To parse this JSON data, do
//
//     final uploadImageResponse = uploadImageResponseFromJson(jsonString);

import 'dart:convert';

UploadImageResponse uploadImageResponseFromJson(String str) =>
    UploadImageResponse.fromJson(json.decode(str));

String uploadImageResponseToJson(UploadImageResponse data) =>
    json.encode(data.toJson());

class UploadImageResponse {
  String code;
  String status;
  String message;
  String url;

  UploadImageResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.url,
  });

  factory UploadImageResponse.fromJson(Map<String, dynamic> json) =>
      UploadImageResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "url": url,
  };
}
