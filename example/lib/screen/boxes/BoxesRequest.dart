import 'package:HubboxVpnApp/data/BoxesStore.dart';

abstract class BoxesRequestContract {
  void onRequestSuccess(Object result);

  void onRequestError(String errorTxt);
}

class BoxesRequest {
  BoxesRequestContract _view;
  BoxesStore api = new BoxesStore("boxes");

  BoxesRequest(this._view);

  doRequest(Map<String, dynamic> params) {
    api.load(params, action: "load").then((boxes) {
      _view.onRequestSuccess(boxes);
    }).catchError((Object error) {
      _view.onRequestError(error.toString());
    });
  }
}
