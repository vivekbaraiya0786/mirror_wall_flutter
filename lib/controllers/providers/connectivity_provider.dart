
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:mirror_wall/modals/connectivity_model.dart';

class ConnectivityProvier extends ChangeNotifier{

  Connectivity connectivity = Connectivity();

  ConnectivityModel connectivityModel = ConnectivityModel(ConnectivityStatus: "Waiting");

  void checkInternetConnectvity(){
    connectivityModel.ConnectivityStream = connectivity.onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
      switch(connectivityResult){
        case ConnectivityResult.wifi :
          connectivityModel.ConnectivityStatus = "wifi";
          notifyListeners();
          break;
        case ConnectivityResult.mobile :
          connectivityModel.ConnectivityStatus = "mobile";
          notifyListeners();
          break;
        default:
          connectivityModel.ConnectivityStatus = "Waiting..";
          notifyListeners();
          break;
      }
    });
  }
}