import 'package:Framework/FIS.SYS/Layout/Body.dart';
import 'package:Framework/FIS.SYS/Modules/User/Action/Login.dart';
import 'package:flutter/material.dart';

class LoginIndex extends StatefulWidget {
  @override
  _LoginIndexState createState() => _LoginIndexState();
}

class _LoginIndexState extends State<LoginIndex> {
  @override
  Widget build(BuildContext context) {
    return BodyLayout(
      body: [UserLogin()],
    );
  }
}
