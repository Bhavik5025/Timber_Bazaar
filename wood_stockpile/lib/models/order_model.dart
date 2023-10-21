// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  String companyId;
  String customerId;
  String orderid;
  String paymentId;
  String productname;
  String productid;
  String type;
  String company_name;
  String company_number;
  String customername;
  String company_address;
  String totalPrice;
  String customernumber;
  String customerlet;
  String customerlong;
  String companylet;
  String companylong;
  String deliveryCharge;

  OrderModel({
    required this.companyId,
    required this.customerId,
    required this.orderid,
    required this.paymentId,
    required this.productid,
    required this.company_address,
    required this.company_name,
    required this.company_number,
    required this.companylet,
    required this.companylong,
    required this.customerlet,
    required this.customerlong,
    required this.customernumber,
    required this.productname,
    required this.customername,
    required this.type,
    required this.totalPrice,
    required this.deliveryCharge,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        companyId: json["Company_id"],
        customerId: json["Customer_id"],
        orderid: json["orderid"],
        paymentId: json["paymentId"],
        productid: json["productid"],
        productname: json["productname"],
        company_address: json["company_address"],
        company_name: json["company_name"],
        customerlet: json["customerlet"],
        customerlong: json["customerlong"],
        companylet: json["companylet"],
        customername: json["customername"],
        companylong: json["companylong"],
        customernumber: json["customernumber"],
        company_number: json["company_number"],
        type: json["type"],
        totalPrice: json["total_price"],
        deliveryCharge: json["delivery_charge"],
      );

  Map<String, dynamic> toJson() => {
        "Company_id": companyId,
        "Customer_id": customerId,
        "orderid": orderid,
        "paymentId": paymentId,
        "productid": productid,
        "productname": productname,
        "type": type,
        "customerlet": customerlet,
        "customerlong": customerlong,
        "customernumber": customernumber,
        "customername": customername,
        "company_address": company_address,
        "companylet": companylet,
        "companylong": companylong,
        "company_name": company_name,
        "total_price": totalPrice,
        "delivery_charge": deliveryCharge,
      };
}
