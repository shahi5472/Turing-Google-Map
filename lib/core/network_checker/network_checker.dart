import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkChecker {
  Future<bool> isConnected();
}

class NetworkCheckerImpl implements NetworkChecker {
  final Connectivity connectivity;

  NetworkCheckerImpl(this.connectivity);

  @override
  Future<bool> isConnected() async {
    final result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) return true;
    return false;
  }
}
