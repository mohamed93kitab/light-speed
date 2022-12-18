import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/colors.dart';
import '../lang/appLocalizations.dart';
import '../main.dart';
class SettingScreen extends StatefulWidget {
  SettingScreen();

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: MyTheme.light_text,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: MyTheme.white,
        centerTitle: true,
        elevation: 0,
        title: Text(AppLocalizations.of(context).getTranslate('settings'), style: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyTheme.light_text
        ),),
      ),
      body: Container(
        color: MyTheme.bg_light,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 16, right: 12, left: 12),
        child: SingleChildScrollView(
          child: ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
                  GestureDetector(
                    onTap: () {
                      MyApp.of(context).setLocale(Locale.fromSubtags(languageCode: 'ar'));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 22, horizontal: 15),
                      margin: EdgeInsets.only(
                    bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      color: MyTheme.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: MyTheme.light_text.withOpacity(.08),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    // padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: Row(

                        children : [
                          SvgPicture.asset("assets/icons/ar.svg", width: 40,),
                          SizedBox(width: 10,),
                          Text(
                            AppLocalizations.of(context).getTranslate('arabic'),
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          Spacer(),

                          Icon(Icons.arrow_forward_ios),

                        ]
                    ),
                ),
                  ),

                  GestureDetector(
                    onTap: () {
                      MyApp.of(context).setLocale(Locale.fromSubtags(languageCode: 'en'));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 22, horizontal: 15),
                    margin: EdgeInsets.only(
                    bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      color: MyTheme.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: MyTheme.light_text.withOpacity(.08),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    // padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: Row(

                      children : [
                        SvgPicture.asset("assets/icons/en.svg", width: 40,),
                         SizedBox(width: 10,),
                         Text(
                           AppLocalizations.of(context).getTranslate('english'),
                          style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        Spacer(),

                        Icon(Icons.arrow_forward_ios),

                      ]
                    ),
                ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
