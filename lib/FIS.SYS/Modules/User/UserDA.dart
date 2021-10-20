import 'package:Framework/FIS.SYS/Modules/BaseDA.dart';
import 'package:Framework/FIS.SYS/Modules/Config.dart';
import 'package:Framework/FIS.SYS/Modules/User/ModelUserItem.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserItem.dart';
import 'package:http/http.dart' as http;

class UserDA extends BaseDA {
  Future<UsersModel> login(UserItem userItem) async {
    var result = await postData(
      Config.domaniApi + "mobile-login",
      {
        'email': userItem.email,
        'password': userItem.password,
        'isRemember': userItem.isRemember.toString(),
      },
      new UsersModel(),
    );
    return result;
  }

  Future<UsersCreateModel> signIn(UserItem userItem) async {
    var result = await postData(
      Config.domaniApi + "mobile-register-user",
      {
        'username': userItem.email,
        'password': userItem.password,
        'fullname': userItem.fullName,
        'telephone': userItem.phoneNumber,
      },
      new UsersCreateModel(),
    );
    return result;
    // http.post(Config.domaniApi + "mobile-register-user", body: {
    //   'username': userItem.email,
    //   'password': userItem.password,
    //   'fullname': userItem.fullName,
    //   'telephone': userItem.phoneNumber,
    // }).then((response) => print("${response.statusCode} - ${response.body}"));
  }

  Future<UsersUpdateModel> changePassword(
    UserItem userItem,
  ) async {
    var result = await postData(
        Config.domaniApi + 'mobile-change-password',
        {
          'email': userItem.email,
          'oldPassword': userItem.password,
          'newPassword': userItem.newPassword,
        },
        new UsersUpdateModel());
    return result;
  }

  Future<UsersModel> getInfo() async {
    var result =
        await get(Config.domaniApi + "mobile-get-auth-info", new UsersModel());
    return result;
  }

  Future<UsersUpdateModel> updateInfo(UserItem userItem) async {
    var result = await postData(
      Config.domaniApi + "mobile-update-auth-info",
      {
        'userId': userItem.userId,
        'fullName': userItem.fullName,
        'email': userItem.email,
        'phoneNumber': userItem.phoneNumber,
        'orgId': userItem.orgId,
        'avatarBase64': userItem.avatarBase64,
      },
      new UsersUpdateModel(),
    );
    return result;
  }
}
