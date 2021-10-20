import 'dart:io';

import 'package:Framework/FIS.SYS/Modules/User/Action/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginIndex extends StatefulWidget {
  @override
  _LoginIndexState createState() => _LoginIndexState();
}

class _LoginIndexState extends State<LoginIndex> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
        return false;
      },
      child: Scaffold(
        body: UserLogin(),
      ),
    );
  }
}
