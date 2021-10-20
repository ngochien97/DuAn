import 'package:Framework/FDA/Providers/UserProvider.dart';
import 'package:Framework/FIS.SYS/Components/TextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Email extends StatefulWidget {
  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  var _emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    String value =
        Provider.of<UserProvider>(context, listen: false).getUser.email;
    _emailController.text = value;

    return Container(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: FTextField(
        controller: _emailController,
        size: FTextFieldSize.size56,
        enabled: false,
        label: 'Email',
        value: value,
      ),
    );
  }
}
