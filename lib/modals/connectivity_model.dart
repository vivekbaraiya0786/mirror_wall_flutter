import 'dart:async';

class ConnectivityModel {

  String ConnectivityStatus;
  StreamSubscription? ConnectivityStream;

  ConnectivityModel({
    required this.ConnectivityStatus,
    this.ConnectivityStream,
  });
}
