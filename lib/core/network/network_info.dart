
import 'dart:io';
import 'package:http/http.dart' as http;
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  // final InternetConnectionChecker connectionChecker;

  // NetworkInfoImpl(this.connectionChecker);

  @override
Future<bool> get isConnected async {
    try {
      final result = await http.get(Uri.parse('www.google.com'));
      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}