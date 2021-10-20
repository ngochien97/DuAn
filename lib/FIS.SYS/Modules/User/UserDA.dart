import 'package:Framework/FDA/Models/User.dart';
import 'package:Framework/FIS.SYS/Modules/BaseDA.dart';
import 'package:Framework/FDA/Models/Auth.dart';
import 'package:Framework/FDA/Providers/AuthProvider.dart';
import 'package:Framework/FIS.SYS/Modules/User/UserItem.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:provider/provider.dart';

class UserDA extends BaseDA {
  static String url = "mobile-login";
  static Future<void> login(
    UserItem userItem,
    BuildContext context,
  ) async {
    http.post(BaseDA.domaniApi + url, body: userItem.toJson()).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = convert.jsonDecode(response.body);
        Provider.of<AuthProvider>(context, listen: false).setAuth(
          Auth(
            token: data["data"][0]["token"],
            refreshToken: "",
            expireDate: DateTime.now().add(Duration(hours: 1)),
          ),
        );
      } else {
        print(response.statusCode);
      }
    });
  }

  static Future<void> getAccountData(BuildContext context) async {
    print("getAccountData");
    http.get(BaseDA.domaniApi + "mobile-get-auth-info", headers: {
      "token": Provider.of<AuthProvider>(context, listen: false).token
    }).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> data =
            convert.jsonDecode(response.body)["data"][0];
        Provider.of<AuthProvider>(context, listen: false).setUserData(User(
          id: data["userId"],
          fullName: data["fullName"],
          phoneNumber: data["phoneNumber"],
          email: data["email"],
          orgId: data["orgId"],
          avatarBase64: data["avatarBase64"],
        ));
      } else {
        print(response.statusCode);
      }
    });
  }

  static Future<void> updateAccountData(User user, BuildContext context) async {
    http
        .post(
            "http://uaa-fda-demo.paas.xplat.fpt.com.vn/mobile-update-auth-info",
            headers: {
              "token": Provider.of<AuthProvider>(context, listen: false).token
            },
            body: user.toJson())
        .then((response) {
      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        print(response.statusCode);
      }
    });
  }

  static Future<void> changePassword(
    BuildContext context,
    UserUpdatePassword user,
    Function showSuccessMessage,
  ) async {
    http
        .post(BaseDA.domaniApi + 'mobile-change-password',
            headers: {
              'token': Provider.of<AuthProvider>(context, listen: false).token
            },
            body: user.toJson())
        .then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = convert.jsonDecode(response.body);
        if (data['statusCode'] == 0) {
          showSuccessMessage();
        } else if (data['statusCode'] == 1) {
          print('Failed');
        }
      }
    }).catchError((e) => print(e));
  }
}
