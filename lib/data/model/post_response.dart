// To parse this JSON data, do
//
//     final postResponse = postResponseFromJson(jsonString);

import 'dart:convert';

PostResponse postResponseFromJson(String str) =>
    PostResponse.fromJson(json.decode(str));

String postResponseToJson(PostResponse data) => json.encode(data.toJson());

class PostResponse {
  String code;
  String status;
  String message;
  Data data;

  PostResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int totalItems;
  List<Post> posts;
  int totalPages;
  int currentPage;

  Data({
    required this.totalItems,
    required this.posts,
    required this.totalPages,
    required this.currentPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalItems: json["totalItems"],
    posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
    totalPages: json["totalPages"],
    currentPage: json["currentPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalItems": totalItems,
    "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
    "totalPages": totalPages,
    "currentPage": currentPage,
  };
}

class Post {
  String id;
  String userId;
  String imageUrl;
  String caption;
  bool isLike;
  int totalLikes;
  dynamic user;
  DateTime createdAt;
  DateTime updatedAt;

  Post({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.caption,
    required this.isLike,
    required this.totalLikes,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    userId: json["userId"],
    imageUrl: json["imageUrl"],
    caption: json["caption"],
    isLike: json["isLike"],
    totalLikes: json["totalLikes"],
    user: json["user"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "imageUrl": imageUrl,
    "caption": caption,
    "isLike": isLike,
    "totalLikes": totalLikes,
    "user": user,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
