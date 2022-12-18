import 'package:flash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'lang/appLocalizations.dart';
import 'package:shared_value/shared_value.dart';

import 'config/lang_config.dart';
import 'helpers/shared_value_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  user_id.load();
  user_name.load();
  user_phone.load();
  token.load();
  is_logged_in.load();
  avatar.load();

  runApp(
      SharedValue.wrapApp(
        MyApp(),
      ),
  );

  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("a6f1db82-bb96-4b2f-9576-e2dbeed8767b");
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("+==================================================+" + accepted.toString());
  });
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''),
        Locale('en', ''),
      ],
      locale: _locale == null ? Locale('ar', '') : _locale,
      localeResolutionCallback:
          (Locale deviceLocale, Iterable<Locale> supportedLocales) =>
      deviceLocale != null &&
          ['ar', 'en'].contains(deviceLocale.languageCode)
          ? deviceLocale
          : supportedLocales.first,

      home: SplashScreen(),
    );
  }
}
