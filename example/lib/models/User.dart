class User {
  String _username;
  String _token;
  // String _platform;
  // int _id;
  // int _sid;
  String _name;
  String _email;
  // bool _authorized;
  // double _iat;

  User(this._username);

  User.map(dynamic obj) {
    this._username = obj["username"];
    this._token = obj["token"];
    // this._platform = obj["_platform"];
    // this._id = obj["_id"];
    // this._sid = obj["_sid"];
    this._name = obj["name"];
    this._email = obj["email"];
    // this._authorized = obj["_authorized"];
    // this._iat = obj["_iat"];
  }

  String get username => _username;
  String get token => _token;
  // String get platform => _platform;
  // int get id => _id;
  // int get sid => _sid;
  String get name => _name;
  String get email => _email;
  // bool get authorized => _authorized;
  // double get iat => _iat;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["token"] = _token;
    // map["platform"] = _platform;
    // map["id"] = _id;
    // map["sid"] = _sid;
    map["name"] = _name;
    map["email"] = _email;
    // map["authorized"] = _authorized;
    // map["iat"] = _iat;

    return map;
  }
}
