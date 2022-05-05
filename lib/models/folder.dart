// To parse this JSON data, do
//
//     final folder = folderFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Folder folderFromJson(String str) => Folder.fromJson(json.decode(str));

String folderToJson(Folder data) => json.encode(data.toJson());

class Folder {
    Folder({
        required this.id,
        required this.name,
        required this.price,
        required this.quantity,
        required this.parentId,
    });

    String id;
    String name;
    double price;
    int quantity;
    String parentId;

    factory Folder.fromJson(Map<String, dynamic> json) => Folder(
        id: json["id"],
        name: json["name"],
        price: json["price"].toDouble(),
        quantity: json["quantity"],
        parentId: json["parent_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "quantity": quantity,
        "parent_id": parentId,
    };
}
