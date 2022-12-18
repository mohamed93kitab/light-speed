import 'package:flutter/material.dart';

class MyTheme{
  /*configurable colors stars*/
  static Color accent_color = Color(0xfff0b22d);
  static Color soft_accent_color = Color(0xffFE8333);
  static Color splash_screen_color = Color(0xfff38335);// if not sure , use the same color as accent color
  static Gradient gradient_color = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xffF5672C),
        Color(0xffFC7829),
      ]
  );
  static Gradient indego = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xff7400B3),
        Color(0xff440087),
      ]
  );
  static Color transparent = Colors.transparent;
  static Gradient gradient_transparent = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.transparent,
        Colors.transparent,
      ]
  );// if not sure , use the same color as accent color
  // static Color bg_light = Color(0xffF5F6F7);
  static Color bg_light = Color(0xfff6f7ff);
  static Color green = Color(0xff219653);
  static Color danger = Color(0xffEB5757);
  static Color facebook_color = Color(0xff1877f2);
  static Color light = Color(0xfff1f5ff);
  static Color input_color = Color(0xffF5F6FB);
  static Color shadow = Color(0xffa8adcb);
  static Color dark_bg = Color(0xff151521);
  static Color light_text = Color(0xff2F3548);
  static Color auction_btn = Color(0xff292B3A);

  /*configurable colors ends*/


  /*If you are not a developer, do not change the bottom colors*/
  static Color white = Color.fromRGBO(255,255,255, 1);
  static Color light_grey = Color.fromRGBO(239,239,239, 1);
  static Color dark_grey = Color(0xff424242);
  static Color opacity_grey = Color.fromRGBO(187, 187, 187, 1.0);
  static Color medium_grey = Color.fromRGBO(132,132,132, 1);
  static Color medium_grey_50 = Color.fromRGBO(132,132,132, .5);
  static Color grey_153 = Color.fromRGBO(153,153,153, 1);
  static Color text_grey = Color(0xff828282);
  static Color font_grey = Color.fromRGBO(73,73,73, 1);
  static Color textfield_grey = Color.fromRGBO(209,209,209, 1);
  static Color golden = Color.fromRGBO(248, 181, 91, 1);
  static Color shimmer_base = Colors.grey.shade50;
  static Color shimmer_highlighted = Colors.grey.shade200;


//testing shimmer
/*static Color shimmer_base = Colors.redAccent;
  static Color shimmer_highlighted = Colors.yellow;*/



}