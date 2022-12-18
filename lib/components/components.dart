import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/colors.dart';
Widget loginbtn(context, onPressed) {
  // ignore: deprecated_member_use
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: MyTheme.accent_color,
      ),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        "تسجيل الدخول",
        style: GoogleFonts.cairo(
            fontSize: 18,
            color: Colors.white,
            letterSpacing: 0.168,
            fontWeight: FontWeight.w500),
      ),
    ),
  );
}

Widget passCode() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "نسيت كلمة المرور؟",
        style: GoogleFonts.cairo(fontSize: 20, color: MyTheme.light_text),
      ),
      InkWell(
        child: Text(
          "إستعادة",
          style: GoogleFonts.cairo(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: MyTheme.accent_color
          ),
        ),
        onTap: () {},
      )
    ],
  );
}

Widget inputField1(controller) {
  return Container(
    decoration: BoxDecoration(
      color: MyTheme.light,
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: MyTheme.light_text,
          blurRadius: 25,
          offset: Offset(0, 5),
          spreadRadius: -25,
        ),
      ],
    ),
    margin: const EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: controller,
      style: GoogleFonts.cairo(
          fontSize: 18,
          color: MyTheme.light_text,
          letterSpacing: 0.24,
          fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        hintText: "البريد الإلكتروني",
        hintStyle: TextStyle(
          color: MyTheme.light_text.withOpacity(.5),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: FaIcon(
            FontAwesomeIcons.at,
            color: MyTheme.light_text.withOpacity(.1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(1),
          ),
          borderSide: BorderSide(color: MyTheme.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(1),
          ),
          borderSide: BorderSide(color: MyTheme.white),
        ),
      ),
    ),
  );
}

Widget inputField2(controller) {
  return Container(
    decoration: BoxDecoration(
      color: MyTheme.light,
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: MyTheme.light_text,
          blurRadius: 25,
          offset: Offset(0, 5),
          spreadRadius: -25,
        ),
      ],
    ),
    margin: const EdgeInsets.only(bottom: 20),
    child: TextField(
      controller: controller,
      style: GoogleFonts.cairo(
          fontSize: 18,
          color: MyTheme.light_text,
          letterSpacing: 0.24,
          fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: "الرمز السري",
        hintStyle: TextStyle(
          color: MyTheme.light_text.withOpacity(.5),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FaIcon(
            FontAwesomeIcons.eye,
            color: MyTheme.accent_color.withOpacity(0.5),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(1),
          ),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(1),
          ),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      obscureText: true,
    ),
  );
}