import 'package:Framework/FIS.SYS/Components/TextField.dart';
import 'package:flutter/material.dart';
class Email extends StatefulWidget {
  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: FTextField(
        size: FTextFieldSize.size56,
        enabled: false,
        label: 'Email',
      ),
    );
  }
}
