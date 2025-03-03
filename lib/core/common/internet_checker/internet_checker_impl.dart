import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:loot_vault/core/common/internet_checker/internet_checker.dart';

class InternetCheckerImpl implements IInternetChecker {
  final Connectivity _connectivity = Connectivity();

  @override
  Future<bool> isConnected() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
           connectivityResult == ConnectivityResult.wifi;
  }
}