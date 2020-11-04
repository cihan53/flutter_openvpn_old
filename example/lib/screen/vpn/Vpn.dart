import 'dart:developer';

import 'package:HubboxVpn/HubboxVpn.dart';
import 'package:HubboxVpnApp/models/MobilHubModel.dart';
import 'package:HubboxVpnApp/models/VpnResultModel.dart';
import 'package:HubboxVpnApp/screen/vpn/vpn_request.dart';
import 'package:HubboxVpnApp/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../global.dart' as globals;
import '../LeftMenu.dart';

const bool isProduction = bool.fromEnvironment('dart.vm.product');

class Vpn extends StatefulWidget {
  static String subPath = '/page';
  static String tag = 'vpn-page';
  String page;
  bool navigate;

  Vpn(this.page, this.navigate);

  static Future<void> stop() async {
    await HubboxVpn.stopVPN();
  }

  @override
  _Vpn createState() => new _Vpn();
}

class _Vpn extends State<Vpn> implements VpnRequestContract {
  final formKey = new GlobalKey<FormState>();
  // final _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _connected = false;
  bool _isLoading = false;
  VpnRequest _request;
  VpnResultModel _vpnUserList = new VpnResultModel(0, null);

  _Vpn() {
    _request = new VpnRequest(this);
    init()
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: 'loading...');

    _request.doRequest();

    HubboxVpn.vpnStatus.then((value) {
      log("VPN STATUS : " + value.toString());
      setState(() => _connected = value);
    });
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  Future<dynamic> init() async {
      await HubboxVpn.init(
      localizedDescription: "HubboxVPN",
      providerBundleIdentifier: "com.cihan53.HubboxVpnApp.RunnerExtension",
    ).then((value) {
        print(value);
        Fluttertoast.showToast(msg: value.toString(), textColor: Colors.red);
      });

  }

  Future<dynamic> _connect(_vpnUser) async {
    EasyLoading.show(status: 'loading...');
    _request.createHub(_vpnUser.id);
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
        key: globals.ScaffoldKey,
        drawer: NavDrawer(),
        body: CustomScrollView(
          slivers: <Widget>[
            // Add the app bar to the CustomScrollView.
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.lightBlue,
              // Provide a standard title.
              // title: Text("Hub List"),
              // Allows the user to reveal the app bar if they begin scrolling
              // back up the list of items.
              floating: false,
              // Display a placeholder widget to visualize the shrinking size.
              flexibleSpace: FlexibleSpaceBar(
                // title: Text('Hubbox - VPN '),
                background: Image.asset(
                  "assets/images/hubbox.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              // Make the initial height of the SliverAppBar larger than normal.
              expandedHeight: 250.0,
            ),
            // Next, create a SliverList
            SliverList(
              // Use a delegate to build items as they're scrolled on screen.
              delegate: SliverChildBuilderDelegate(
                // The builder function returns a ListTile with a title that
                // displays the index of the current item.
                (context, index) {
                  String title = _vpnUserList.data[index].custom_title != null
                      ? _vpnUserList.data[index].custom_title
                      : _vpnUserList.data[index].hubbox_alias;

                  title += "(" + _vpnUserList.data[index].alias + ")";
                  return Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 1.0, color: Color.fromARGB(200, 200, 200, 200)),
                    )),
                    padding: EdgeInsets.only(right: 5, left: 20),
                    alignment: Alignment.centerLeft,
                    // color: Colors.blue[200 + bottom[index] % 4 * 100],
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 6, // 60% of space => (6/(6 + 4))
                          child: Container(child: Text(title)),
                        ),
                        Expanded(
                            flex: 1,
                            child: _buildButtonColumn(Colors.green, Icons.vpn_lock, '',
                                !_connected ? () => _connect(_vpnUserList.data[index]) : null)),
                        Expanded(
                            flex: 1,
                            child: _buildButtonColumn(
                                Colors.red, Icons.power_off, '', _connected ? _stop : null)),
                        // Expanded(
                        //   flex: 1,
                        //   child: Container(
                        //       margin: EdgeInsets.only(right: 0, left: 0),
                        //       child: RaisedButton(
                        //         padding: EdgeInsets.all(2),
                        //         color: Colors.green,
                        //         onPressed:
                        //             !_connected ? () => _connect(_vpnUserList.data[index]) : null,
                        //         child: Text('Connect',
                        //             style: TextStyle(
                        //                 fontSize: 8, color: Color.fromARGB(255, 255, 255, 255))),
                        //       )),
                        // ),
                        //   Expanded(
                        //       flex: 1,
                        //       child: Container(
                        //           margin: EdgeInsets.only(right: 0, left: 3),
                        //           child: RaisedButton(
                        //             color: Colors.red,
                        //             disabledColor: Color.fromARGB(100, 255, 0, 0),
                        //             padding: EdgeInsets.all(2),
                        //             onPressed: _connected ? _stop : null,
                        //             child: Text('Disconnect',
                        //                 style: TextStyle(
                        //                     fontSize: 8, color: Color.fromARGB(255, 255, 255, 255))),
                        //           ))),
                      ],
                    ),
                  );
                },
                // Builds 1000 ListTiles
                childCount: _vpnUserList.totalCount,
              ),
            ),
          ],
          // body: Center(
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: <Widget>[
          //       RaisedButton(
          //         onPressed: !_connected ? _connect : null,
          //         child: Text('Connect VPN', style: TextStyle(fontSize: 20)),
          //       ),
          //       RaisedButton(
          //         onPressed: _connected ? Vpn.stop : null,
          //         child: Text('Disconnect VPN', style: TextStyle(fontSize: 20)),
          //       )
          //     ],
          //   ),
//        child: Center(
//          child: Text(
//            page.toString(),
//          ),
//        ),
        ));
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
  void onVpnRequestSuccess(Object result) {
    // TODO: implement onVpnRequestSuccess
    if (result is VpnResultModel) {
      _vpnUserList = result as VpnResultModel;
      // log("request success " + result.totalCount.toString());
      // print("request success" + result.totalCount.toString());
      if (widget.page == '0' && result.totalCount > 0 && !_connected) init();
      EasyLoading.dismiss();
      setState(() => _isLoading = false);
    }

    if (result is MobilHubModel) {
      _toConnect(result);
    }
  }

  Future<void> _stop() {
    HubboxVpn.stopVPN();
    setState(() => _connected = false);
  }

  Future<dynamic> _toConnect(MobilHubModel vpnhub) async {
    EasyLoading.show();
    // if (await init() != null) {
    String fileData = await getFileData("assets/vpn.conf");

    String hubName = vpnhub.hub_name; // (isProduction ? "DEV_" : "DEV_") + vpnhub.hub_name;
    fileData = fileData.replaceAll("{ip}", vpnhub.ip);
    fileData = fileData.replaceAll("{username}", vpnhub.username);
    fileData = fileData.replaceAll("{hubname}", hubName);
    fileData = fileData.replaceAll("{password}", vpnhub.password);

    await HubboxVpn.lunchVpn(
      fileData,
      (isProfileLoaded) {
        print("isProfileLoaded ${isProfileLoaded}");
        log('isProfileLoaded : $isProfileLoaded');
      },
      (vpnActivated) {
        log('vpnActivated ************************* : $vpnActivated');
        switch (vpnActivated) {
          case "EXITING":
          case "AUTH_FAILED":
            EasyLoading.dismiss();
            setState(() => _isLoading = false);
            // HubboxVpn.stopVPN();
            break;
          case "NOPROCESS":
            //HubboxVpn.stopVPN();
            //EasyLoading.dismiss();
            setState(() => _connected = false);

            break;
          case "CONNECTED":
            EasyLoading.dismiss();
            setState(() => _connected = true);

            break;
        }
      },
      // expireAt: DateTime.now().add(Duration(seconds: 30)),
      expireAt: null,
    );
    // } else {
    //   // setState(() => _connected = true);
    //   EasyLoading.dismiss();
    // }
  }
}
