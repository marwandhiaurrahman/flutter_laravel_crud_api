import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(
    json.decode(str)['data'].map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    @required this.id,
    @required this.name,
    @required this.detail,
    @required this.createdAt,
    @required this.updatedAt,
  });

  int id;
  String name;
  String detail;
  String createdAt;
  String updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        detail: json["detail"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "detail": detail,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
