import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../FIS.SYS/Components/ComponentsBase.dart';
import '../../FIS.SYS/Modules/User/Actions/Login.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          if (Platform.isAndroid) {
            await SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: FAppBar(
            brightness: Brightness.light,
          ),
          body: ActionLogin(),
        ),
      );
}
