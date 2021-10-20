import 'dart:io';

import 'package:Framework/FIS.SYS/Modules/User/Action/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserSignIn(),
    );
  }
}
