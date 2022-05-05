// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
    Item({
        required this.id,
        required this.name,
        required this.price,
        required this.quantity,
        required this.image,
    });

    String id;
    String name;
    double price;
    int quantity;
    String image;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        price: json["price"].toDouble(),
        quantity: json["quantity"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "quantity": quantity,
        "image": image,
    };
}
