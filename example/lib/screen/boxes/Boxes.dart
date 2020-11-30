/*
 * Hubbox cihazları ağına dahil olabilmek için hazırlanmıştır.
 * @author Cihan Öztürk
 * @Email cihan@chy.com.tr
 * Copyright (c) 2020
 *
 *
 * Kullanıcınn bağlanabileceği hubbox listesi
 *
 */

import 'package:HubboxVpnApp/store/VpnStatusStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../LeftMenu.dart';
import 'BoxesRequest.dart';
import '../../global.dart' as globals;

final vpnStatusStore = VpnStatusStore();

class Boxes extends StatefulWidget {
  static String subPath = '/page';
  static String tag = 'boxes-page';
  String page;
  bool navigate;

  Boxes(this.page, this.navigate);

  @override
  _Boxes createState() => new _Boxes();
}

/**
 *
 */
class _Boxes extends State<Boxes> implements BoxesRequestContract {
  BoxesRequest _request;

  _Boxes() {
    _request = new BoxesRequest(this);
  }

  void _showSnackBar(String text) {
    globals.ScaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EasyLoading.show(status: 'loading...');

    Map<String, dynamic> params = new Map();
    params["hub_id"] = vpnStatusStore.hub_id;
    params["page"] = 0;
    params["limit"] = -1;

    _request.doRequest(params);
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void onRequestSuccess(Object result) {
    EasyLoading.dismiss();
    print(result);
    // TODO: implement onRequestSuccess
  }

  @override
  void onRequestError(String errorTxt) {
    EasyLoading.dismiss();
    // TODO: implement onRequestError
    _showSnackBar(errorTxt);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C'];
    // final List<int> colorCodes = <int>[600, 500, 100];

    var listView = ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          // height: 50,
          // color: Colors.amber[colorCodes[index]],
          child: Center(child: Text('Entry ${entries[index]}')),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );

    final body = Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.all(28.0),

      child: listView,
    );

    return Scaffold(
      appBar: AppBar(title: Text("Hubbox List")),
      drawer: NavDrawer(),
      body: body,
    );
  }
}
