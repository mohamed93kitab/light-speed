import 'package:flutter/material.dart';

var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text = "@ Nippur " + this_year; //this shows in the splash screen
  static String app_name = "light speed"; //this shows in the splash screen
  static String purchase_code = "bkash"; //enter your purchase code for the app from codecanyon
  //static String purchase_code = ""; //enter your purchase code for the app from codecanyon

  //Default language config
  static String default_language ="ar";
  static String default_currency ="USD";
  static String default_currency_symbol ="\$";
  static int default_currency_exchange_rate = 1;
  static String mobile_app_code ="ar";
  static bool app_language_rtl =true;

  //configure this
  static const bool HTTPS = true;

  //configure this
   static const DOMAIN_PATH = "light-speed.me"; //localhost
  // static const DOMAIN_PATH = "10.0.2.2:8000"; //inside a folder
  //static const DOMAIN_PATH = "shop.nippur.cc"; // directly inside the public folder

  //do not configure these below
  static const String API_ENDPATH = "api/v1";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";
}
