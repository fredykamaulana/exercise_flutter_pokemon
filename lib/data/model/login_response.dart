// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String code;
  String status;
  String message;
  User user;
  String token;

  LoginResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.user,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "user": user.toJson(),
    "token": token,
  };
}

class User {
  String id;
  String username;
  String name;
  String email;
  String role;
  String profilePictureUrl;
  String phoneNumber;
  String bio;
  String website;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.role,
    required this.profilePictureUrl,
    required this.phoneNumber,
    required this.bio,
    required this.website,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    profilePictureUrl: json["profilePictureUrl"],
    phoneNumber: json["phoneNumber"],
    bio: json["bio"],
    website: json["website"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "name": name,
    "email": email,
    "role": role,
    "profilePictureUrl": profilePictureUrl,
    "phoneNumber": phoneNumber,
    "bio": bio,
    "website": website,
  };
}
