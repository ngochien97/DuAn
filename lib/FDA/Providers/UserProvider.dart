import 'package:Framework/FIS.SYS/Modules/User/UserItem.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  UserItem _userItem;
  UserItem _userEditItem;

  UserItem get getUser => _userItem;
  UserItem get getNewUser => _userEditItem;

  void setUser(UserItem userItem) {
    _userItem = userItem;
    notifyListeners();
  }

  void setNewUser(UserItem userItem) {
    _userEditItem = userItem;
    notifyListeners();
  }
}
