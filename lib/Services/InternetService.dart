import 'dart:io';

class InternetService{
  Future<bool> checkConnected() async{
    try {
      final result = await InternetAddress.lookup('avinab.in.net');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("Connected");
        return true;
      }
    } on SocketException catch (_) {
      print("Connection Error:");
      return false;
    }
    return false;
  }
}