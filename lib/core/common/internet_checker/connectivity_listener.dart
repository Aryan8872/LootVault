import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityListener {
  final Connectivity _connectivity = Connectivity();

  Future<bool> get isConnected async {
    List<ConnectivityResult> results = await _connectivity.checkConnectivity();

    if (results.contains(ConnectivityResult.none)) {
      return false; // No Wi-Fi or Mobile Data
    }

    // 🔹 Double-check actual internet access
    try {
      final lookup = await InternetAddress.lookup('example.com');
      return lookup.isNotEmpty && lookup.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false; // No actual internet access
    }
  }
}
