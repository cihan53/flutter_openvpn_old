import 'dart:async';
import 'dart:typed_data';
import 'package:sentry/sentry.dart';
import 'package:HubboxVpnApp/screen/home/HomePage.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'data/database_helper.dart';
import 'global.dart';
import 'screen/login/loginPage.dart';
import 'screen/vpn/Vpn.dart';

const bool isProduction = bool.fromEnvironment('dart.vm.product');

void main() {
  runZonedGuarded(
    () => runApp(BetterFeedback(
        child: MyApp(),
        onFeedback: (
          BuildContext context,
          String feedbackText,
          Uint8List feedbackScreenshot,
        ) {
          /**
               * upload
               */

          var event = Event(
            message: feedbackText,
            exception: "Mobil Uygulama",
            //extra: {"feedbackScreenshot": base64Encode(feedbackScreenshot)},
          );
          sentry.capture(event: event).whenComplete(() => null);

          BetterFeedback.of(context).hide();
        })),
    (error, stackTrace) async {
      await sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    },
  );

  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..maskType = EasyLoadingMaskType.black
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false;
  // ..customAnimation = CustomAnimation();
}

class MyApp extends StatefulWidget {
  AppLifecycleState _notification;

  static Future<void> logout() {
    /**
     * vpn stop yap
     */
    if (vpnStatusStore.connected) Vpn.stop();

    var db = new DatabaseHelper();
    db.deleteUsers();
  }

  @override
  _MyAppState createState() => _MyAppState();

  MyApp({Key key}) : super(key: key);
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final appTitle = 'Hubbox Apps';

  @override
  Future<void> initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    if (vpnStatusStore.connected) Vpn.stop();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("Kapandi3 ${state}");

    switch (state) {
      case AppLifecycleState.detached:
        {
          await Vpn.stop();
        }
        break;
    }

    setState(() {
      widget._notification = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          LoginPage.tag: (context) => LoginPage(),
          HomePage.tag: (context) => HomePage(title: appTitle),
          Vpn.tag: (context) => Vpn('0', false),
//        '/third': (context) => ThirdRoute(),
        },
        home: LoginPage(),
        // home: Vpn('0', false),
        // ignore: missing_return
        builder: (BuildContext context, Widget child) {
          /// make sure that loading can be displayed in front of all other widgets
          return FlutterEasyLoading(child: child);
        },
        // ignore: missing_return
        onGenerateRoute: (settings) {
          if (settings.name.contains(Vpn.subPath)) {
            String page =
                settings.name.contains(Vpn.subPath) ? settings.name.split(Vpn.subPath)[1] : '0';
            return MaterialPageRoute(builder: (context) {
              return Vpn(page, settings.name.split(Vpn.subPath)[1].compareTo('2') < 0);
            });
          }
        });
  }
}
