import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String companyEmail;
  String cId;
  String productName;
  String category;
  String pid;
  String price;
  String delivery_charge;
  String productDescription;
  final List<String> productImages;

  ProductModel(
      {required this.companyEmail,
      required this.cId,
      required this.productName,
      required this.category,
      required this.pid,
      required this.price,
      required this.productDescription,
      required this.productImages,
      required this.delivery_charge});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      companyEmail: json["Company_email"],
      cId: json["c_id"],
      pid: json["pid"],
      productName: json["product_name"],
      category: json["category"],
      price: json["price"],
      productDescription: json["product_description"],
      productImages: json["product_images"],
      delivery_charge: json["delivery_charge"]);

  Map<String, dynamic> toJson() => {
        "Company_email": companyEmail,
        "c_id": cId,
        "pid":pid,
        "product_name": productName,
        "category": category,
        "price": price,
        "product_description": productDescription,
        "product_images": productImages,
        "delivey_charge": delivery_charge,
      };
}
