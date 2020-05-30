import 'dart:io';

class SocketHandlers {
  static Socket _raspTank;
  static String _ip;
  get raspTankSocket {
    return _raspTank;
  }

  get ipAddress {
    return _ip;
  }

  connectToRaspTank(String ip) async {
    _raspTank = await Socket.connect(ip ?? '', 1233).catchError((onError) {
      print(onError.toString());
    });
    _ip = _raspTank.address.toString();
    print("Socket Address: ${_raspTank.address.toString()}");
  }

  closeAllConnections() {
    _raspTank.flush();
    _raspTank.close();
    _raspTank = null;
  }
}
