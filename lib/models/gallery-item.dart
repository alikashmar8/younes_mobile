// ignore_for_file: file_names, prefer_if_null_operators, unnecessary_null_comparison

import 'dart:convert';

GalleryItem galleryItemFromJson(String str) => GalleryItem.fromJson(json.decode(str));

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
  });

  String id;
  String name;
  double? price;
  int? quantity;
  String? image;
  String? parentId;
  String type;
  String? description;
  bool isActive;
  String businessId;
  String createdById;
  String? updatedById;

  factory GalleryItem.fromJson(Map<String, dynamic> json) => GalleryItem(
        id: json["id"],
        name: json["name"],
        price: json["price"] ? json['price'].toDouble(): null,
        quantity: json["quantity"]? json['quantity']: null,
        image: json["image"] ? json["image"] : null,
        parentId: json["parent_id"],
        type: json["type"],
        description: json["description"],
        isActive: json["is_active"],
        businessId: json["business_id"],
        createdById: json["created_by_id"],
        updatedById: json["updated_by_id"],
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
      };
}
