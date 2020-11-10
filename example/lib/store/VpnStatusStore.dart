import 'package:mobx/mobx.dart';

// Include generated file
part 'VpnStatusStore.g.dart';

// This is the class used by rest of your codebase
class VpnStatusStore = _VpnStatusStore with _$VpnStatusStore;

// The store-class
abstract class _VpnStatusStore with Store {
  @observable
  int hub_id = 0;

  @observable
  bool connected = false;
}
