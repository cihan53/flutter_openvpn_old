import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:HubboxVpnApp/models/MobilHubModel.dart';
import 'package:HubboxVpnApp/models/User.dart';
import 'package:HubboxVpnApp/models/VpnResultModel.dart';
import 'package:HubboxVpnApp/utils/decodeBase64.dart';
import 'package:HubboxVpnApp/utils/network_util.dart';

const bool isProduction = bool.fromEnvironment('dart.vm.product');

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();

//  static final BASE_URL = "https://dev.hubbox.io/desktopapi/";
//   static final BASE_URL = "http://172.17.7.137/api";
  static final BASE_URL = isProduction ? "https://my.hubbox.io/api" : "https://my.hubbox.io/api";
  static final LOGIN_URL = BASE_URL + "/v2/mobileaccount/authenticateMobile";
  static String _API_TOKEN = "";

  static String get API_TOKEN => _API_TOKEN;

  static set API_TOKEN(String value) {
    _API_TOKEN = value;
  }

  Map<String, String> header = {
    // "Content-type": "application/json",
    "Accept": "application/json",
    "authorization": "Basic " + base64.encode(utf8.encode(_API_TOKEN))
  };

  Future<User> login(String username, String password) async {
    log("Login Url " + LOGIN_URL);
    print("Login Url " + LOGIN_URL);
    return _netUtil
        .post(LOGIN_URL, body: {"username": username, "password": password}).then((dynamic res) {
      if (res["success"] == false) throw new Exception(res["message"]);

      final parts = res["token"].split('.');
      Map<String, dynamic> user;

      if (parts.length != 3) {
        throw Exception('invalid token');
      }

      var claim = decodeBase64(res["token"].split(".")[1]);

      if (claim != "") {
        user = json.decode(claim);
        user["token"] = res["token"];
        _API_TOKEN = res["token"];
      }

      return new User.map(user);
    });
  }

  /**
   * vpn kullanıcı bilgilerini alır
   */
  Future<VpnResultModel> getVpnUser() async {
    log("getVpnUser Url " + BASE_URL + "/v2/mobileaccount/hub/list");
    print("getVpnUser Url:" + BASE_URL + "/v2/mobileaccount/hub/list");
    //
    // Map<String, String> header = {
    //   "Content-type": "application/json",
    //   "Accept": "application/json",
    //   "authorization": "Basic " + base64.encode(utf8.encode(_API_TOKEN))
    // };

    return _netUtil.get(BASE_URL + "/v2/mobileaccount/hub/list", header).then((dynamic res) {
      if (res["success"] == false) throw new Exception(res["message"]);
      Map<String, dynamic> vpnUserList;
      vpnUserList = res;
      return new VpnResultModel.map(vpnUserList);
    });
  }

  Future<MobilHubModel> createHub(int id) async {
    log("getVpnUser Url " + BASE_URL + "/v2/mobileaccount/createhub");
    print("getVpnUser Url:" + BASE_URL + "/v2/mobileaccount/createhub");
    return _netUtil
        .post(BASE_URL + "/v2/mobileaccount/createhub",
            body: {"id": id.toString()}, headers: header)
        .then((dynamic res) {
      if (res["success"] == false) throw new Exception(res["message"]);

      return new MobilHubModel.map(res["data"]);
    });
  }
}
