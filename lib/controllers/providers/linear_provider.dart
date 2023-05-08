import 'package:flutter/material.dart';
import 'package:mirror_wall/modals/linermodel.dart';

class LinerProvider extends ChangeNotifier{

  linerModel l1 = linerModel(liner: 0);

  ChangeProgress(Pg) {
    l1.liner = Pg/100;
    notifyListeners();

  }
}