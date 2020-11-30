// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VpnStatusStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VpnStatusStore on _VpnStatusStore, Store {
  final _$hub_idAtom = Atom(name: '_VpnStatusStore.hub_id');

  @override
  int get hub_id {
    _$hub_idAtom.reportRead();
    return super.hub_id;
  }

  @override
  set hub_id(int value) {
    _$hub_idAtom.reportWrite(value, super.hub_id, () {
      super.hub_id = value;
    });
  }

  final _$connectedAtom = Atom(name: '_VpnStatusStore.connected');

  @override
  bool get connected {
    _$connectedAtom.reportRead();
    return super.connected;
  }

  @override
  set connected(bool value) {
    _$connectedAtom.reportWrite(value, super.connected, () {
      super.connected = value;
    });
  }

  @override
  String toString() {
    return '''
hub_id: ${hub_id},
connected: ${connected}
    ''';
  }
}
