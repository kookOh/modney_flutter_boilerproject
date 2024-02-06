import 'dart:developer';
import 'package:modney_flutter_boilerplate/utils/methods/aliases.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SignallingService {
  // instance of Socket
  Socket? socket;
  SignallingService._();
  static final instance = SignallingService._();
  init({required String websocketUrl, required String selfCallerID}) {
    // init Socket
    socket = io(websocketUrl, {
      "transports": ['websocket'],
      "query": {"callerId": selfCallerID}
    });
    // listen onConnect event
    socket!.onConnect((data) {
      logIt.debug("Socket connected !! $data, callerID=$selfCallerID");
    });
    // listen onConnectError event
    socket!.onConnectError((data) {
      logIt.debug("Connect Error $data");
    });
    // connect socket
    socket!.connect();
  }
}
