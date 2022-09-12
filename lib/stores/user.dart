import 'package:flutter/material.dart';
import 'package:ruikeyz_auth/model/ruikeyz_login.dart';

class UserStore extends ChangeNotifier {
  RuikeyLoginDataModel? ruikeyLoginData;
  String loopHeartbeatkey = "";

  void setRuikeyLoginData(RuikeyLoginDataModel val) {
    ruikeyLoginData = val;
  }

  void setLoopHeartbeatkey(String val) {
    loopHeartbeatkey = val;
    notifyListeners();
  }
}
