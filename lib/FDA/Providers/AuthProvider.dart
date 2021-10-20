import 'package:Framework/FDA/Models/Auth.dart';
import 'package:Framework/FDA/Models/User.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserItem.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  Auth _auth;
  User _user = User(
    id: "",
    fullName: "",
    email: "",
    phoneNumber: "",
    orgId: "",
    avatarBase64: "",
  );

  User _editUser = User(
    id: "",
    fullName: "",
    email: "",
    phoneNumber: "",
    orgId: "",
    avatarBase64: "",
  );

  UserUpdatePassword _userUpdatePassword = UserUpdatePassword(
    email: '',
    newPassword: '',
    oldPassword: '',
  );
  bool get isAuth =>
      _auth != null &&
      (_auth.expireDate.isBefore(DateTime.now()) || _auth.token != null);

  String get token => _auth.token;

  void setAuth(Auth auth) {
    _auth = auth;
    notifyListeners();
  }

  void clearAuth() {
    _auth = new Auth();
    notifyListeners();
  }

  User get getUserData => _user;
  User get getDisplayUserData => _editUser;

  void setUserData(User user) {
    _user = user;
    _editUser = user;
    notifyListeners();
  }

  void setDisplayUserData(User user) {
    _editUser = user;
    notifyListeners();
  }

  UserUpdatePassword get getUserUpdatePassword => _userUpdatePassword;
  void setUserUpdatePassword(UserUpdatePassword userUpdatePassword) {
    _userUpdatePassword = userUpdatePassword;
    notifyListeners();
  }
}
