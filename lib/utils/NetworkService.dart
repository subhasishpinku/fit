import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkService {

  /// One-time internet check
  Future<bool> hasInternet() async {
    return await InternetConnectionChecker().hasConnection;
  }

}
