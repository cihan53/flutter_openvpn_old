import 'dart:developer';

import 'package:HubboxVpnApp/data/rest_ds.dart';

abstract class VpnRequestContract {
  void onVpnRequestSuccess(Object result);
  void onVpnRequestError(String errorTxt);
}

class VpnRequest {
  VpnRequestContract _view;
  RestDatasource api = new RestDatasource();

  VpnRequest(this._view);

  doRequest() {
    api.getVpnUser().then((vpnUserList) {
      _view.onVpnRequestSuccess(vpnUserList);
    }).catchError((Object error) {
      _view.onVpnRequestError(error.toString());
    });
  }

  createHub(int id) {
    api.createHub(id).then((vpnHub) {
      _view.onVpnRequestSuccess(vpnHub);
    }).catchError((Object error) {
      _view.onVpnRequestError(error.toString());
    });
  }
}
