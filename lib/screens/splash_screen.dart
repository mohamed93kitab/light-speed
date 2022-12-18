import 'package:flash/config/colors.dart';
import 'package:flash/helpers/shared_value_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../lang/appLocalizations.dart';
import 'home_screen.dart';
import 'signin_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () async {

        if(is_logged_in.$) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenuDashboardPage()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
        }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .2,),
          Image.asset("assets/images/logo.png"),
          Text(AppLocalizations.of(context).getTranslate('app_name'), style: GoogleFonts.cairo(
            color: MyTheme.accent_color,
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),),
        ],
      ),
    );
  }
}
