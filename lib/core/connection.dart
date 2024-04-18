import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class Connection {
  final Connectivity _connectivity;

  Connection({Connectivity? connectivity}) : _connectivity = connectivity ?? Connectivity();

  Future<bool> checkConnection() async {
    final connection = await _connectivity.checkConnectivity();

    if (connection.contains(ConnectivityResult.mobile) ||
        connection.contains(ConnectivityResult.wifi) ||
        connection.contains(ConnectivityResult.ethernet) ||
        connection.contains(ConnectivityResult.other) ||
        connection.contains(ConnectivityResult.vpn)) {
      try {
        final result = await InternetAddress.lookup("example.com");
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } on SocketException catch (_) {
        return false;
      }
    }

    return false;
  }
}
