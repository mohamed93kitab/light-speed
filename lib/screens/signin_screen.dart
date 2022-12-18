import 'dart:convert';

import 'package:flash/config/colors.dart';
import 'package:flash/main.dart';
import 'package:flash/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flash/components/components.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../components/toast_component.dart';
import '../config/app_config.dart';
import 'package:http/http.dart' as http;
import '../helpers/auth_helper.dart';
import '../helpers/shared_value_helper.dart';
import '../lang/appLocalizations.dart';
import '../repositories/login_repository.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> SetOneSignalPlayerId() async {

    OSDeviceState oneSingla =
    await OneSignal.shared.getDeviceState();

    var post_body = jsonEncode({
      'player_id': oneSingla.userId
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/auth/player_id/" + user_id.$.toString());
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: post_body);

    print("$response");
  }

  onPressedLogin() async {
    var email = _emailController.text.toString();
    var password = _passwordController.text.toString();


    var loginResponse = await AuthRepository().getLoginResponse(email, password);

    if (loginResponse.status == true) {
      SetOneSignalPlayerId();
      ToastComponent.showDialog("login successfully", context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      AuthHelper().setUserData(loginResponse);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MenuDashboardPage();
      }));
    } else {
      ToastComponent.showDialog("login error", context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      //
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return Main();
      // }));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 110, horizontal: 30),
              color: Colors.white,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        AppLocalizations.of(context).getTranslate('app_name'),
                        style: GoogleFonts.cairo(
                          fontSize: 22,
                          color: MyTheme.accent_color,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "أدخل تفاصيل حسابك ",
                        style: GoogleFonts.cairo(
                          fontSize: 18,
                          color: MyTheme.light_text,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "للدخول إلى لوحة التحكم",
                        style: GoogleFonts.cairo(
                          fontSize: 18,
                          color: MyTheme.light_text,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  inputField1(_emailController),
                  SizedBox(height: MediaQuery.of(context).size.height * .03),
                  inputField2(_passwordController),
                  SizedBox(height: MediaQuery.of(context).size.height * .03),
                  loginbtn(context, () {onPressedLogin();}),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  passCode()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
