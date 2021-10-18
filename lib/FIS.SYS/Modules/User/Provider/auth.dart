import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  String authenAccessToken = '';
  bool get isAuth => authenAccessToken != '';

  Future<bool> setToken(String tk) async {
    authenAccessToken = tk;
    notifyListeners();
    return true;
  }
}
