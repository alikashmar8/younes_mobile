// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:younes_mobile/models/gallery-item.model.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    this.address,
    required this.role,
    required this.businessId,
    List? createdItems,
    List? updatedItems,
    List? favoriteItems,
  });

  dynamic id;
  String name;
  String email;
  String? password;
  String? address;
  String role;
  dynamic businessId;
  List<GalleryItem>? createdItems;
  List<GalleryItem>? updatedItems;
  List<dynamic>? favoriteItems;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        role: json["role"],
        businessId: json["business_id"],
        // ignore: prefer_null_aware_operators
        createdItems: json["createdItems"] == null
            ? null
            : json["createdItems"].map((x) => GalleryItem.fromJson(x)).toList(),
        updatedItems: json["updatedItems"] == null
            ? null
            : List<dynamic>.from(json["updatedItems"].map((x) => x)),
        favoriteItems: json["favoriteItems"] == null
            ? null
            : List<dynamic>.from(json["favoriteItems"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "address": address,
        "role": role,
        "business_id": businessId,
        "createdItems": createdItems == null
            ? null
            : List<dynamic>.from(createdItems!.map((x) => x)),
        "updatedItems": updatedItems == null
            ? null
            : List<dynamic>.from(updatedItems!.map((x) => x)),
        "favoriteItems": favoriteItems == null
            ? null
            : List<dynamic>.from(favoriteItems!.map((x) => x)),
      };
}
