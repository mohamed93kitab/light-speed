import 'dart:convert';
import 'package:flash/models/notification_response.dart';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../helpers/shared_value_helper.dart';
import '../models/login_response.dart';
import '../models/logout_response.dart';

class NotificationRepository {
  Future<LoginResponse> getLoginResponse(
      String email, String password) async {
    var post_body = jsonEncode({
      "email": "${email}",
      "password": "$password",
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/auth/login");
    final response = await http.post(url,
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
        },
        body: post_body);

    return loginResponseFromJson(response.body.toString());
  }

  Future<NotificationResponse> getNotificationResponse(int $id) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/notifications/" + $id.toString());
    final response = await http.get(
      url
    );

    print(response.body.toString());

    return notificationResponseFromJson(response.body.toString());
  }

}
