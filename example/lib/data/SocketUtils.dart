import 'dart:io';
import 'package:socket_io/socket_io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

const bool isProduction = bool.fromEnvironment('dart.vm.product');

class SocketUtils {
  static String _serverIP = isProduction ? 'http://localhost' : 'http://10.0.2.2';
  static const int SERVER_PORT = 4002;
  static String _connectUrl = '$_serverIP:$SERVER_PORT';
  IO.Socket _socket;
  initSocket() async {
    await _init();
  }

  _init() async {
    _socket = IO.io(_connectUrl);
  }

  IO.Socket get socket => _socket;

  connectToSocket() {
    if (null == _socket) {
      print("Socket is Null");
      return;
    }
    print("Connecting to socket...");
    _socket.connect();
  }

  setConnectListener(Function onConnect) {
    _socket.on('connect', (data) {
      onConnect(data);
    });
  }

  setEventListener(Function onEvent) {
    _socket.on('event', (data) {
      onEvent(data);
    });
  }

  setOnFromServer(Function onFromServer) {
    _socket.on('fromServer', (data) {
      onFromServer(data);
    });
  }

  setOnDisconnectListener(Function OnDisconnect) {
    _socket.on('disconnect', (data) {
      OnDisconnect(data);
    });
  }

  setOnErrorListener(Function onError) {
    _socket.on('error', (error) {
      onError(error);
    });
  }

  setOnClose(Function onClose) {
    _socket.on('close', (close) {
      onClose(close);
    });
  }

  closeConnection() {
    if (null != _socket) {
      print("Close Connection");
      _socket.clearListeners();
      _socket.close();
    }
  }
}
