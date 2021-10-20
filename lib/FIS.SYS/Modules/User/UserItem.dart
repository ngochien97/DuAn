import 'package:Framework/FIS.SYS/Modules/BaseSimple.dart';

class UserItem extends BaseItem {
  String email;
  String password;
  bool isRemember = false;
  UserItem(
    this.email,
    this.password,
    this.isRemember,
  );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'isRemember': isRemember.toString(),
      };
}

class UserUpdatePassword {
  String email;
  String oldPassword;
  String newPassword;

  UserUpdatePassword({this.email, this.oldPassword, this.newPassword});

  Map<String, dynamic> toJson() => {
        'email': email,
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      };
}
