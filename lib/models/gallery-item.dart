// ignore_for_file: file_names, prefer_if_null_operators, unnecessary_null_comparison

import 'dart:convert';

import 'package:younes_mobile/models/user.model.dart';

GalleryItem galleryItemFromJson(String str) =>
    GalleryItem.fromJson(json.decode(str));

String galleryItemToJson(GalleryItem data) => json.encode(data.toJson());

class GalleryItem {
  GalleryItem({
    required this.id,
    required this.name,
    this.price,
    this.quantity,
    this.image,
    this.parentId,
    required this.type,
    this.description,
    this.isActive = true,
    required this.businessId,
    required this.createdById,
    this.updatedById,
    this.createdBy,
    this.updatedBy,
  });

  int id;
  String name;
  double? price;
  int? quantity;
  String? image;
  int? parentId;
  String type;
  String? description;
  bool isActive;
  int businessId;
  int createdById;
  int? updatedById;
  User? createdBy;
  User? updatedBy;

  factory GalleryItem.fromJson(Map<String, dynamic> json) => GalleryItem(
        id: json["id"],
        name: json["name"],
        price: json['price'].toDouble(),
        quantity: json['quantity'],
        image: json["image"],
        parentId: json["parent_id"],
        type: json["type"],
        description: json["description"],
        isActive: json["is_active"],
        businessId: json["business_id"],
        createdById: json["created_by_id"],
        updatedById: json["updated_by_id"],
        createdBy:
            json["created_by"] == null ? null : User.fromJson(json["created_by"]),
        updatedBy:
            json["updated_by"] == null ? null : User.fromJson(json["updated_by"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "quantity": quantity,
        "image": image == null ? null : image,
        "parent_id": parentId,
        "type": type,
        "description": description,
        "is_active": isActive,
        "business_id": businessId,
        "created_by_id": createdById,
        "updated_by_id": updatedById,
        "created_by": createdBy!.toJson(),
        "updated_by": updatedBy!.toJson(),
      };
}
