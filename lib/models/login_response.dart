// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.data,
    this.status,
  });

  bool status;
  User data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json["status"],
    data: json["data"] == null ? null : User.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? null : data.toJson(),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.token,
    this.avatar,
    this.phone,
    this.address,
    this.role_name
  });

  int id;
  String name;
  String email;
  String token;
  String avatar;
  String role_name;
  String phone;
  String address;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    token: json["token"],
    avatar: json["avatar"],
    phone: json["phone"],
    address: json["address"],
    role_name: json["role_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "token": token,
    "avatar": avatar,
    "phone": phone,
    "address": address,
    "role_name": role_name,
  };
}
