import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../helpers/shared_value_helper.dart';
import '../models/login_response.dart';
import '../models/logout_response.dart';

class AuthRepository {
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

  Future<LogoutResponse> getLogoutResponse() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/auth/logout");
    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer ${token.$}",
      },
    );

    print(response.body.toString());

    return logoutResponseFromJson(response.body.toString());
  }


  //
  // Future<PasswordForgetResponse> getPasswordForgetResponse(
  //      String email_or_phone, String send_code_by) async {
  //   var post_body = jsonEncode(
  //       {"email_or_phone": "$email_or_phone", "send_code_by": "$send_code_by"});
  //
  //   Uri url = Uri.parse(
  //     "${AppConfig.BASE_URL}/auth/password/forget_request",
  //   );
  //   final response = await http.post(url,
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //       body: post_body);
  //
  //   //print(response.body.toString());
  //
  //   return passwordForgetResponseFromJson(response.body);
  // }
  //
  // Future<PasswordConfirmResponse> getPasswordConfirmResponse(
  //     @required String verification_code, @required String password) async {
  //   var post_body = jsonEncode(
  //       {"verification_code": "$verification_code", "password": "$password"});
  //
  //   Uri url = Uri.parse(
  //     "${AppConfig.BASE_URL}/auth/password/confirm_reset",
  //   );
  //   final response = await http.post(url,
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //       body: post_body);
  //
  //   return passwordConfirmResponseFromJson(response.body);
  // }

}
