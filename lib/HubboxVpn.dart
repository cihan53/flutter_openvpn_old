import 'dart:async';
import 'dart:io';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

typedef OnProfileStatusChanged = Function(bool isProfileLoaded);
typedef OnVPNStatusChanged = Function(String status);

const String _profileLoaded = "profileloaded";
const String _profileLoadFailed = "profileloadfailed";

class HubboxVpn {
  static const MethodChannel _channel = const MethodChannel('HubboxVpn');
  static OnProfileStatusChanged _onProfileStatusChanged;
  static OnVPNStatusChanged _onVPNStatusChanged;

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  static Future<bool> get vpnStatus async {
     bool s = await _channel.invokeMethod("vpnStatus") ;
     return s;
  }



  /**
   * Vpn init
   */
  static Future<dynamic> init(
      {String providerBundleIdentifier, String localizedDescription}) async {
    dynamic isInited = await _channel.invokeMethod("init", {
      'localizedDescription': localizedDescription,
      'providerBundleIdentifier': providerBundleIdentifier,
    }).catchError((error) {
      log(error.toString());
    });

    if (!(isInited is PlatformException) || isInited == null) {
      _channel.setMethodCallHandler((call) {
        switch (call.method) {
          case _profileLoaded:
            _onProfileStatusChanged?.call(true);
            break;
          case _profileLoadFailed:
            _onProfileStatusChanged?.call(false);
            break;
          default:
            _onVPNStatusChanged?.call(call.method);
        }
        return null;
      });

      log("isInited "+ isInited.toString());
      return isInited;
    } else {
      log('OpenVPN Initilization failed');
      log((isInited as PlatformException).message);
      log((isInited as PlatformException).details);

      return null;
    }
  }

  /**
   * Lunch Vpn
   */
  static Future<int> lunchVpn(String ovpnFileContents,
      OnProfileStatusChanged onProfileStatusChanged, OnVPNStatusChanged onVPNStatusChanged,
      {DateTime expireAt}) async {
    _onProfileStatusChanged = onProfileStatusChanged;
    _onVPNStatusChanged = onVPNStatusChanged;
    dynamic isLunched = await _channel.invokeMethod(
      "lunch",
      {
        'ovpnFileContent': ovpnFileContents,
        'expireAt': expireAt == null ? null : DateFormat("yyyy-MM-dd HH:mm:ss").format(expireAt),
      },
    ).catchError((error) {
      log("lunchVpn Error" + error);
    });

    if (isLunched == null) return 0;

    print((isLunched as PlatformException).message);

    return int.tryParse((isLunched as PlatformException).code);
  }

  /**
   * Stop Vpn
   */
  static Future<void> stopVPN() async {
    await _channel.invokeMethod("stop");
  }
}
