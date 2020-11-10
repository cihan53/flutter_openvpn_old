import 'dart:developer';

import 'package:HubboxVpn/HubboxVpn.dart';
import 'package:HubboxVpnApp/data/SocketUtils.dart';
import 'package:HubboxVpnApp/models/MobilHubModel.dart';
import 'package:HubboxVpnApp/models/VpnResultModel.dart';
import 'package:HubboxVpnApp/screen/vpn/vpn_request.dart';
import 'package:HubboxVpnApp/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../global.dart' as globals;
import '../LeftMenu.dart';

class BroadCast extends StatefulWidget {
  static String subPath = '/page';
  static String tag = 'vpn-page';
  String page;
  bool navigate;

  BroadCast(this.page, this.navigate);

  @override
  _BroadCast createState() => new _BroadCast();
}

class _BroadCast extends State<BroadCast> implements VpnRequestContract {
  final formKey = new GlobalKey<FormState>();
  // final _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _connected = false;
  bool _isLoading = false;
  static SocketUtils socketUtils;

  _BroadCast() {
    init();
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: 'loading...');
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  void init() async {
    if (socketUtils == null) {
      socketUtils = new SocketUtils();
    }

    socketUtils.connectToSocket();
  }

  void onConnect(data) async {
    EasyLoading.show(status: 'loading...');
  }

  void onDisconnect(data) async {
    EasyLoading.show(status: 'loading...');
  }

  void onError(data) async {
    EasyLoading.show(status: 'loading...');
  }

  Widget _buildButtonColumn(Color color, IconData icon, String label, onTap) {
    return GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    log("VPN STATUS2:" + _connected.toString());
    return Scaffold(
        key: globals.ScaffoldKey, drawer: NavDrawer(), body: Center(child: Text("test")));
  }

  /**
   * notify çıkarıyor
   */
  void _showSnackBar(String text) {
    globals.ScaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  void onVpnRequestError(String errorTxt) {
    // TODO: implement onVpnRequestError
    EasyLoading.dismiss();
    log("Request Error:" + errorTxt);
    print("Request Error:" + errorTxt);
    _showSnackBar(errorTxt);
  }

  @override
  void onVpnRequestSuccess(Object result) {}
}
