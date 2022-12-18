import 'dart:convert';

import 'package:flash/screens/notifications_screen.dart';

NotificationResponse notificationResponseFromJson(String str) => NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) => json.encode(data.toJson());

class NotificationResponse {
  NotificationResponse({
    this.data,
    this.status,
  });

  List<Notification> data;
  bool status;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
    data: List<Notification>.from(json["data"].map((x) => Notification.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class Notification {
  Notification({
    this.id,
    this.store_id,
    this.title_ar,
    this.title_en,
    this.content_ar,
    this.content_en,
    this.created_at,
  });

  int id;
  int store_id;
  String title_ar;
  String title_en;
  String content_ar;
  String content_en;
  String created_at;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"].toInt(),
    store_id: json["store_id"].toInt(),
    title_ar: json["title_ar"],
    title_en: json["title_en"],
    content_ar: json["content_ar"],
    content_en: json["content_en"],
    created_at: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": store_id,
    "title_ar": title_ar,
    "title_en": title_en,
    "content_ar": content_ar,
    "content_en": content_en,
    "created_at": created_at,
  };
}
