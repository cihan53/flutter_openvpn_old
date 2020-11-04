import 'package:HubboxVpnApp/models/VpnUser.dart';

import 'VpnUser.dart';

class VpnResultModel {
  int _rowCount;
  List<VpnUser> _data;

  VpnResultModel(this._rowCount, this._data);

  VpnResultModel.map(dynamic obj) {
    // this._data = new List<VpnUser>.from(
    //     obj["data"].whereType<VpnUser>());
    // this._data = obj["data"].cast<List<VpnUser>>();
    this._data = (obj["data"] as List)?.map((e) => new VpnUser.map(e))?.toList();
    this._rowCount = obj["rowCount"];
  }

  int get totalCount => _rowCount;

  List<VpnUser> get data => _data;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["totalCount"] = _rowCount;
    map["data"] = _data;

    return map;
  }
}
