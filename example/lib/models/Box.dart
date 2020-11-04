class VpnUser {
  /*
  0 = {map entry} "id" -> 228
  1 = {map entry} "hub_id" -> 228
  2 = {map entry} "username" -> "Sub"
  3 = {map entry} "password" -> ""
  4 = {map entry} "status" -> "1"
  5 = {map entry} "ip" -> "185.162.145.67"
  6 = {map entry} "vadapter_name" -> "VPN"
  7 = {map entry} "alias" -> "Office 4026"
  8 = {map entry} "customer_id" -> 57
  9 = {map entry} "boxes" -> [_GrowableList]*/

  int _id;
  int _hub_id;
  String _status;
  String _ip;
  String _vadapter_name;
  String _alias;
  int _customer_id;
  dynamic _boxes;
  String _username;
  String _password;

  VpnUser(this._username);

  VpnUser.map(dynamic obj) {
    this._id = obj["id"];
    this._hub_id = obj["hub_id"];
    this._status = obj["status"];
    this._ip = obj["ip"];
    this._vadapter_name = obj["vadapter_name"];
    this._alias = obj["alias"];
    this._customer_id = obj["customer_id"];
    this._boxes = obj["boxes"];
    this._username = obj["username"];
    this._password = obj["password"];
  }

  String get username => _username;

  Map<String, dynamic> toMap() {
    var obj = new Map<String, dynamic>();
    obj["id"] = this._id;
    obj["hub_id"] = this._hub_id;
    obj["status"] = this._status;
    obj["ip"] = this._ip;
    obj["vadapter_name"] = this._vadapter_name;
    obj["alias"] = this._alias;
    obj["customer_id"] = this._customer_id;
    obj["boxes"] = this._boxes;
    obj["username"] = this._username;
    obj["password"] = this._password;
    return obj;
  }
}
