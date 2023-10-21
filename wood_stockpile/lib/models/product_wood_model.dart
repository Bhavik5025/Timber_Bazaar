// To parse this JSON data, do
//
//     final productWoodModel = productWoodModelFromJson(jsonString);

import 'dart:convert';

ProductWoodModel productWoodModelFromJson(String str) =>
    ProductWoodModel.fromJson(json.decode(str));

String productWoodModelToJson(ProductWoodModel data) =>
    json.encode(data.toJson());

class ProductWoodModel {
  String companyEmail;
  String cId;
  String category;
  String price;
  String pid;
  String woodDescription;
  final List<String> woodImages;
  String delivery_charge;
  String width;
  String height;
  String thickness;
  String woodType;

  ProductWoodModel({
    required this.companyEmail,
    required this.cId,
    required this.pid,
    required this.category,
    required this.price,
    required this.delivery_charge,
    required this.woodDescription,
    required this.woodImages,
    required this.width,
    required this.height,
    required this.thickness,
    required this.woodType,
  });

  factory ProductWoodModel.fromJson(Map<String, dynamic> json) =>
      ProductWoodModel(
        companyEmail: json["Company_email"],
        cId: json["c_id"],
        delivery_charge: json["delivery_charge"],
        pid: json["pid"],
        category: json["category"],
        price: json["price"],
        woodDescription: json["wood_description"],
        woodImages: json["wood_images"],
        width: json["width"],
        height: json["height"],
        thickness: json["thickness"],
        woodType: json["wood_type"],
      );

  Map<String, dynamic> toJson() => {
        "Company_email": companyEmail,
        "c_id": cId,
        "category": category,
        "delevery_charge": delivery_charge,
        "price": price,
        "pid": pid,
        "wood_description": woodDescription,
        "wood_images": woodImages,
        "width": width,
        "height": height,
        "thickness": thickness,
        "wood_type": woodType,
      };
}
