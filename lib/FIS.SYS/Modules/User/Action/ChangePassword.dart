import 'package:Framework/FDA/Providers/AuthProvider.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  // Initially password is obscure
  bool _obscureText = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  String checkPassword = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => Container(
        padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Column(
          children: [
            FTextField(
              size: FTextFieldSize.size56,
              label: 'Mật khẩu cũ',
              obscureText: _obscureText,
              rightIcon:
                  _obscureText ? FFilledIcons.eye : FFilledIcons.eye_invisible,
              onRightIconPressed: _toggle,
              onChanged: (value) {
                authProvider.getUserUpdatePassword.oldPassword = value;
              },
            ),
            FSpacer.space24px,
            FTextField(
              size: FTextFieldSize.size56,
              label: 'Mật khẩu mới',
              obscureText: _obscureText1,
              rightIcon:
                  _obscureText1 ? FFilledIcons.eye : FFilledIcons.eye_invisible,
              onRightIconPressed: _toggle1,
              onChanged: (value) {},
            ),
            FSpacer.space24px,
            FTextField(
              size: FTextFieldSize.size56,
              label: 'Nhập lại mật khẩu',
              obscureText: _obscureText2,
              rightIcon:
                  _obscureText2 ? FFilledIcons.eye : FFilledIcons.eye_invisible,
              onRightIconPressed: _toggle2,
              onChanged: (value) {
                if (checkPassword == value) {
                  authProvider.getUserUpdatePassword.newPassword = value;
                } else {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
