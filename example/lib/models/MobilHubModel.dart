import 'package:HubboxVpnApp/models/VpnUser.dart';

import 'VpnUser.dart';

class MobilHubModel {
  String username;
  String password;
  String hub_name;
  String ip;
  int id;

  MobilHubModel(this.id, this.username, this.password, this.hub_name, this.ip);

  MobilHubModel.map(dynamic obj) {
    // this._data = new List<VpnUser>.from(
    //     obj["data"].whereType<VpnUser>());
    // this._data = obj["data"].cast<List<VpnUser>>();
    this.username = obj["username"];
    this.password = obj["password"];
    this.hub_name = obj["hub_name"];
    this.ip = obj["ip"];
    this.id = obj["hub_id"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = this.username;
    map["password"] = this.password;
    map["hub_name"] = this.hub_name;
    map["ip"] = this.ip;
    map["id"] = this.id;

    return map;
  }
}
