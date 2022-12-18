// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

OrdersCountResponse ordersCountResponseFromJson(String str) => OrdersCountResponse.fromJson(json.decode(str));

String OrdersCountResponseToJson(OrdersCountResponse data) => json.encode(data.toJson());

class OrdersCountResponse {
  OrdersCountResponse({
    this.data,
    this.totalAmount,
    this.delivery_amount,
    this.shop_amount,
    this.status,
  });

  int data;
  int totalAmount;
  int delivery_amount;
  int shop_amount;
  bool status;

  factory OrdersCountResponse.fromJson(Map<String, dynamic> json) => OrdersCountResponse(
    data: json["data"]["count"],
    totalAmount: json["data"]["amount"],
    delivery_amount: json["data"]["delivery_amount"],
    shop_amount: json["data"]["shop_amount"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "totalAmount": totalAmount,
    "delivery_amount": delivery_amount,
    "shop_amount": shop_amount,
    "status": status,
  };
}
