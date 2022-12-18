// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

OrderResponse orderResponseFromJson(String str) => OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
  OrderResponse({
    this.orders,
    this.status,
  });

  List<Order> orders;
  bool status;

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
    orders: List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(orders.map((x) => x.toJson())),
    "status": status,
  };
}

class Order {
  Order({
    this.id,
    this.code,
    this.customer,
    this.address,
    this.city,
    this.amount,
    this.fee_amount,
    this.note,
    this.date,
    this.status,
    this.driver_avatar,
    this.driver_phone,
  });

  int id;
  String code;
  String customer;
  String address;
  String city;
  int amount;
  int fee_amount;
  String note;
  String date;
  String status;
  String driver_avatar;
  String driver_phone;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    code: json["code"],
    customer: json["customer"],
    address: json["address"],
    city: json["city"],
    amount: json["amount"].toInt(),
    fee_amount: json["fee_amount"].toInt(),
    note: json["note"],
    date: json["date"],
    status: json["status"],
    driver_avatar: json["driver_avatar"],
    driver_phone: json["driver_phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "customer": customer,
    "address": address,
    "city": city,
    "amount": amount,
    "fee_amount": fee_amount,
    "note": note,
    "date": date,
    "status": status,
    "driver_avatar": driver_avatar,
    "driver_phone": driver_phone,
  };
}
